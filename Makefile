# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash

bundle:
	pushd themes/docs-new && make bundle && popd

clean_all:
	pushd themes/docs-new && make clean_all && popd
	rm -rf resources/
	rm -rf public/
	hugo mod clean

serve: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture

metrics: bundle
	hugo --gc --minify --enableGitInfo --templateMetrics --templateMetricsHints

nodrafts: bundle
	hugo server --noHTTPCache --buildFuture

production: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture --environment production

serve_ignore_vendor: bundle
	hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths github.com/**

lint: bundle
	hugo -D

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
	markdownDir=generated/generated_content/workstation/cookstyle; \
	for f in $$(ls $${dataDir}); \
		do mdFile="$${f/.yml/.md}"; \
		mdFilePath="$${markdownDir}/$${mdFile/cops_/}"; \
		if test ! -f "$${mdFilePath}"; then \
			echo "$${mdFilePath} does not exist."; \
		fi; \
	done; \
	if test ! -f "generated/generated_content/workstation/cookstyle/cops.md"; then \
			echo "generated/generated_content/workstation/cookstyle/cops.md does not exist."; \
	fi; \

