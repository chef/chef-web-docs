#!/bin/bash

set -eou pipefail

# Resolve transitive dependencies without changing installed direct versions.
# Requires an existing installation and lockfile; run from the repository root.

temp_dir=$(mktemp -d "${TMPDIR:-/tmp}/chef-pnpm-update.XXXXXX")
backups_ready=false

cleanup() {
  status=$?
  trap - EXIT
  if [ "$backups_ready" = true ]; then
    cp "$temp_dir/package.json" package.json
    if [ "$status" -ne 0 ]; then
      echo "Dependency update failed; restoring the original manifest and lockfile." >&2
      cp "$temp_dir/pnpm-lock.yaml" pnpm-lock.yaml
    fi
  fi
  rm -f "$temp_dir/package.json" "$temp_dir/pnpm-lock.yaml" \
    "$temp_dir/before.json" "$temp_dir/after.json"
  rm -rf "$temp_dir/resolution-cache" "$temp_dir/resolution-state" \
    "$temp_dir/verification-cache" "$temp_dir/verification-state"
  rmdir "$temp_dir"
  exit "$status"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
trap 'exit 129' HUP

cp package.json "$temp_dir/package.json"
cp pnpm-lock.yaml "$temp_dir/pnpm-lock.yaml"
backups_ready=true

pnpm list --json --depth 0 > "$temp_dir/before.json"
node - "$temp_dir/before.json" <<'NODE'
const fs = require('node:fs');
const manifest = JSON.parse(fs.readFileSync('package.json', 'utf8'));
const [installed] = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
for (const group of ['dependencies', 'devDependencies', 'optionalDependencies']) {
  for (const name of Object.keys(manifest[group] ?? {})) {
    const version = installed?.[group]?.[name]?.version;
    if (!version || !/^\d+\.\d+\.\d+(?:-[\w.-]+)?(?:\+[\w.-]+)?$/.test(version)) {
      throw new Error(`Missing or unsupported installed version for ${name}; run pnpm install --frozen-lockfile first.`);
    }
    manifest[group][name] = version;
  }
}
fs.writeFileSync('package.json', `${JSON.stringify(manifest, null, 2)}\n`);
NODE

pnpm clean --lockfile
# Never resolve from the developer's potentially stale registry metadata.
pnpm install --no-frozen-lockfile \
  --config.cacheDir="$temp_dir/resolution-cache" \
  --config.stateDir="$temp_dir/resolution-state"
cp "$temp_dir/package.json" package.json
pnpm install --lockfile-only --no-frozen-lockfile \
  --config.cacheDir="$temp_dir/resolution-cache" \
  --config.stateDir="$temp_dir/resolution-state"
pnpm clean
# A separate empty cache prevents resolution-time policy results masking errors.
pnpm install --frozen-lockfile \
  --config.cacheDir="$temp_dir/verification-cache" \
  --config.stateDir="$temp_dir/verification-state"
pnpm list --json --depth 0 > "$temp_dir/after.json"

node - "$temp_dir/before.json" "$temp_dir/after.json" <<'NODE'
const fs = require('node:fs');
const manifest = JSON.parse(fs.readFileSync('package.json', 'utf8'));
const [before] = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
const [after] = JSON.parse(fs.readFileSync(process.argv[3], 'utf8'));
for (const group of ['dependencies', 'devDependencies', 'optionalDependencies']) {
  for (const name of Object.keys(manifest[group] ?? {})) {
    const expected = before[group][name].version;
    const actual = after?.[group]?.[name]?.version;
    if (actual !== expected) {
      throw new Error(`Direct dependency ${name} changed from ${expected} to ${actual}.`);
    }
  }
}
console.log('Verified a clean frozen install with unchanged direct dependency versions.');
NODE
