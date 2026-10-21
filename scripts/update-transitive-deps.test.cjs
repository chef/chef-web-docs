const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { test } = require('node:test');

const manifest = {
  packageManager: 'pnpm@11.7.0',
  dependencies: { '@example/runtime': '^1.0.0' },
  devDependencies: { builder: '~2.0.0' },
  optionalDependencies: { watcher: '^3.0.0' },
};
const installed = {
  dependencies: { '@example/runtime': { version: '1.2.3' } },
  devDependencies: { builder: { version: '2.0.4' } },
  optionalDependencies: { watcher: { version: '3.1.0' } },
};
const commands = [
  'list --json --depth 0',
  'clean --lockfile',
  'install --no-frozen-lockfile',
  'install --lockfile-only --no-frozen-lockfile',
  'clean',
  'install --frozen-lockfile',
  'list --json --depth 0',
];

function fixture(t, environment = {}, dependencies = installed) {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'update-transitive-deps-'));
  t.after(() => fs.rmSync(directory, { recursive: true, force: true }));
  const bin = path.join(directory, 'bin');
  const temporary = path.join(directory, 'tmp');
  fs.mkdirSync(bin);
  fs.mkdirSync(temporary);
  const originalManifest = `${JSON.stringify(manifest, null, 4)}\n`;
  fs.writeFileSync(path.join(directory, 'package.json'), originalManifest);
  fs.writeFileSync(path.join(directory, 'pnpm-lock.yaml'), 'original lockfile\n');
  fs.writeFileSync(path.join(directory, 'installed.json'), JSON.stringify([dependencies]));
  fs.writeFileSync(path.join(bin, 'pnpm'), `#!${process.execPath}
const assert = require('node:assert/strict');
const fs = require('node:fs');
const args = process.argv.slice(2);
const command = args.filter(arg => !arg.startsWith('--config.')).join(' ');
if (args[0] === 'install') {
  const path = require('node:path');
  const verification = args.includes('--frozen-lockfile');
  const prefix = verification ? 'verification' : 'resolution';
  const cache = args.find(arg => arg.startsWith('--config.cacheDir='));
  const state = args.find(arg => arg.startsWith('--config.stateDir='));
  assert.ok(cache, 'Install must isolate the metadata cache');
  assert.ok(state, 'Install must isolate policy verification state');
  const cacheDir = cache.slice('--config.cacheDir='.length);
  const stateDir = state.slice('--config.stateDir='.length);
  assert.equal(path.basename(cacheDir), prefix + '-cache');
  assert.equal(path.basename(stateDir), prefix + '-state');
  assert.ok(cacheDir.startsWith(process.env.TMPDIR + path.sep));
  assert.ok(stateDir.startsWith(process.env.TMPDIR + path.sep));
  if (verification || !args.includes('--lockfile-only')) {
    assert.ok(!fs.existsSync(cacheDir), 'Initial cache must be empty');
    assert.ok(!fs.existsSync(stateDir), 'Initial state must be empty');
  }
  fs.mkdirSync(cacheDir, { recursive: true });
  fs.mkdirSync(stateDir, { recursive: true });
  fs.writeFileSync(path.join(cacheDir, 'metadata'), 'cached metadata');
  fs.writeFileSync(path.join(stateDir, 'policy'), 'cached verification');
}
fs.appendFileSync('commands.log', command + '\\n');
if (command === process.env.FAIL_COMMAND) {
  console.error('Simulated pnpm failure');
  process.exit(42);
}
if (command === process.env.SIGNAL_COMMAND) {
  process.kill(process.ppid, 'SIGTERM');
  process.exit(0);
}
const manifest = JSON.parse(fs.readFileSync('package.json', 'utf8'));
if (command === 'list --json --depth 0') {
  const installed = JSON.parse(fs.readFileSync('installed.json', 'utf8'));
  if (process.env.DRIFT && fs.existsSync('reconciled')) {
    installed[0].dependencies['@example/runtime'].version = '1.2.4';
  }
  console.log(JSON.stringify(installed));
} else if (command === 'clean --lockfile') {
  fs.unlinkSync('pnpm-lock.yaml');
} else if (command === 'install --no-frozen-lockfile') {
  assert.equal(manifest.dependencies['@example/runtime'], '1.2.3');
  assert.equal(manifest.devDependencies.builder, '2.0.4');
  assert.equal(manifest.optionalDependencies.watcher, '3.1.0');
  fs.writeFileSync('pnpm-lock.yaml', 'fresh lockfile\\n');
} else if (command === 'install --lockfile-only --no-frozen-lockfile') {
  assert.equal(manifest.dependencies['@example/runtime'], '^1.0.0');
  assert.equal(manifest.devDependencies.builder, '~2.0.0');
  assert.equal(manifest.optionalDependencies.watcher, '^3.0.0');
  fs.writeFileSync('reconciled', '');
} else if (command === 'install --frozen-lockfile') {
  assert.ok(fs.existsSync('reconciled'));
}
`, { mode: 0o755 });

  const result = spawnSync('bash', [path.join(__dirname, 'update-transitive-deps.sh')], {
    cwd: directory,
    env: {
      ...process.env,
      PATH: `${bin}${path.delimiter}${process.env.PATH}`,
      TMPDIR: temporary,
      ...environment,
    },
    encoding: 'utf8',
    timeout: 10000,
  });
  assert.ifError(result.error);
  assert.equal(fs.readFileSync(path.join(directory, 'package.json'), 'utf8'), originalManifest);
  assert.deepEqual(fs.readdirSync(temporary), []);
  return {
    result,
    commands: fs.readFileSync(path.join(directory, 'commands.log'), 'utf8').trim().split('\n'),
    lockfile: fs.readFileSync(path.join(directory, 'pnpm-lock.yaml'), 'utf8'),
  };
}

test('pins all dependency groups and validates with an independent empty metadata cache', (t) => {
  const actual = fixture(t);
  assert.equal(actual.result.status, 0, actual.result.stderr);
  assert.deepEqual(actual.commands, commands);
  assert.equal(actual.lockfile, 'fresh lockfile\n');
  assert.match(actual.result.stdout, /unchanged direct dependency versions/);
});

for (const command of commands.slice(1, -1)) {
  test(`restores manifest and lockfile when ${command} fails`, (t) => {
    const actual = fixture(t, { FAIL_COMMAND: command });
    assert.equal(actual.result.status, 42);
    assert.equal(actual.commands.at(-1), command);
    assert.equal(actual.lockfile, 'original lockfile\n');
    assert.match(actual.result.stderr, /Simulated pnpm failure/);
  });
}

test('rejects a missing installed direct dependency before deleting the lockfile', (t) => {
  const actual = fixture(t, {}, {});
  assert.notEqual(actual.result.status, 0);
  assert.deepEqual(actual.commands, [commands[0]]);
  assert.equal(actual.lockfile, 'original lockfile\n');
  assert.match(actual.result.stderr, /Missing or unsupported installed version/);
});

test('rejects a changed direct version and restores the original lockfile', (t) => {
  const actual = fixture(t, { DRIFT: 'true' });
  assert.notEqual(actual.result.status, 0);
  assert.equal(actual.lockfile, 'original lockfile\n');
  assert.match(actual.result.stderr, /changed from 1.2.3 to 1.2.4/);
});

test('restores manifest and lockfile on termination', (t) => {
  const actual = fixture(t, { SIGNAL_COMMAND: 'install --no-frozen-lockfile' });
  assert.equal(actual.result.status, 143);
  assert.equal(actual.lockfile, 'original lockfile\n');
});
