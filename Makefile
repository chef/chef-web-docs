# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash -eou pipefail

# bundle is also executed from other repositories when people run local previews
bundle:
	pnpm install --frozen-lockfile

clean_hugo_mod:
	hugo mod clean --all

clean:
	rm -rf node_modules
	rm -rf dart-sass
	rm -rf resources/
	rm -rf public/

clean_all: clean clean_hugo_mod

serve: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture

serve_production: bundle
	hugo server --noHTTPCache --environment production

metrics: bundle
	hugo --gc --minify --enableGitInfo --templateMetrics --templateMetricsHints

nodrafts: bundle
	hugo server --noHTTPCache --buildFuture

production: bundle
	hugo --gc --minify --enableGitInfo

static: bundle
	hugo --gc --enableGitInfo --cleanDestinationDir

deploy_preview: bundle
	hugo --gc --minify --enableGitInfo --buildFuture

serve_ignore_vendor: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths github.com/**

test_theme: bundle
	HUGO_MODULE_WORKSPACE=hugo.work hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths "github.com/chef/chef-docs-theme"

test_theme_production: bundle
	HUGO_MODULE_WORKSPACE=hugo.work hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths "github.com/chef/chef-docs-theme" --environment production

# https://gohugo.io/troubleshooting/audit/
audit: bundle
	HUGO_MINIFY_TDEWOLFF_HTML_KEEPCOMMENTS=true HUGO_ENABLEMISSINGTRANSLATIONPLACEHOLDERS=true hugo && grep -inorE "<\!-- raw HTML omitted -->|ZgotmplZ|\[i18n\]|\(<nil>\)|(&lt;nil&gt;)|hahahugo" public/

lint: bundle
	hugo -D

update_theme:
	hugo mod get -u github.com/chef/chef-docs-theme
	rm -rf _vendor
	rm -rf node_modules
	hugo mod tidy
	hugo mod vendor
	hugo mod npm pack
	pnpm install
	$(MAKE) update_transitive_deps
	sed -i '' \
	  -e 's|/-/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/|/-/|g' \
	  -e 's|/-/@[^/]*/|/-/|g' \
	  pnpm-lock.yaml

## Updates transitive (non-direct) dependencies in pnpm-lock.yaml without
## changing the direct dependency versions defined in package.json.
## package.json is backed up, then direct deps are pinned to their exact installed
## versions so pnpm update cannot move them. After all transitive deps are updated,
## package.json is restored verbatim and the lockfile specifiers for direct deps
## are patched back to their original values.
update_transitive_deps:
	@cp package.json package.json.bak; \
	trap 'mv -f package.json.bak package.json 2>/dev/null; exit 1' ERR; \
	EXACT=$$(node -e "const {execSync}=require('child_process'); const d=JSON.parse(execSync('pnpm ls --json --depth 0').toString())[0].dependencies; process.stdout.write(Object.entries(d).map(([k,v])=>k+'@'+v.version).join(' '))"); \
	echo "Pinning direct deps to exact resolved versions: $$EXACT"; \
	pnpm add --save-exact $$EXACT; \
	echo "Updating transitive dependencies..."; \
	pnpm update --depth Infinity; \
	echo "Restoring original package.json..."; \
	mv package.json.bak package.json; \
	echo "Fixing lockfile specifiers for direct deps..."; \
	node -e "const fs=require('fs');const pkg=JSON.parse(fs.readFileSync('./package.json','utf8'));let lock=fs.readFileSync('./pnpm-lock.yaml','utf8');for(const[name,spec]of Object.entries(pkg.dependencies)){const marker='      '+name+':\n        specifier: ';const idx=lock.indexOf(marker);if(idx!==-1){const s=idx+marker.length;const e=lock.indexOf('\n',s);lock=lock.slice(0,s)+spec+lock.slice(e);}}fs.writeFileSync('./pnpm-lock.yaml',lock);"

## See:
## - https://cspell.org/docs/getting-started/
## - https://cspell.org/configuration/
## - and cspell.yaml file.
spellcheck:
	cspell --no-progress "**/*.{md, html, js, yml, yaml, toml, json}"


# Generates blank resource pages, one for each yaml file in data/client/resources
# And an index page that lists all the resources.
resource_files:
	rm content/resources/*
	dataDir=data/infra/resources; \
	for f in $$(ls $${dataDir}); \
		do echo $${f}; \
		file=$${f%.yaml}; \
		hugo new -k resource content/resources/$${file}.md ; \
	done
	hugo new -k all_the_resources content/resources/_index.md ;


# Verifies that all Cookstyle MD pages exist
verify_cookstyle_pages:
	dataDir=generated/_vendor/github.com/chef/cookstyle/docs-chef-io/assets/cookstyle; \
	markdownDir=generated/generated_content/workstation/cookstyle/cops; \
	for f in $$(ls $${dataDir}); \
		do mdFile="$${f/.yml/.md}"; \
		mdFilePath="$${markdownDir}/$${mdFile/cops_/}"; \
		if test ! -f "$${mdFilePath}"; then \
			echo "$${mdFilePath} does not exist."; \
		fi; \
	done; \
	if test ! -f "generated/generated_content/workstation/cookstyle/cops/_index.md"; then \
			echo "generated/generated_content/workstation/cookstyle/cops/_index.md does not exist."; \
	fi; \

