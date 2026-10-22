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

.PHONY: update_theme update_packages update_transitive_deps

update_theme:
	hugo mod get -u github.com/chef/chef-docs-theme
	$(MAKE) update_packages

update_packages:
	rm -rf _vendor
	hugo mod tidy
	hugo mod vendor
	hugo mod npm pack
	@temp_dir=$$(mktemp -d); \
	trap 'rm -rf "$$temp_dir/cache" "$$temp_dir/state"; rmdir "$$temp_dir"' EXIT; \
	pnpm clean --lockfile; \
	pnpm install --no-frozen-lockfile \
		--config.cacheDir="$$temp_dir/cache" --config.stateDir="$$temp_dir/state"
	$(MAKE) update_transitive_deps

# Preserve installed direct versions while resolving transitive dependencies afresh.
update_transitive_deps:
	bash scripts/update-transitive-deps.sh

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
