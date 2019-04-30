BUILDDIR = public
BUILD_COMMAND = sphinx-build -a -W
BUILD_COMMAND_AND_ARGS = $(BUILD_COMMAND)

docs:
	pip install -r requirements.txt --install-option="--install-scripts=/usr/local/bin"
	mkdir -p $(BUILDDIR)
	cp -r misc/robots.txt public/
	cp -r misc/sitemap.xml public/
	$(BUILD_COMMAND_AND_ARGS) chef_master/source $(BUILDDIR)
	bash doctools/rundtags.sh

clean:
	@rm -rf $(BUILDDIR)

docker-build:
	docker run -v $(shell pwd):/chef-web-docs \
		-w /chef-web-docs chefes/buildkite \
		bash -c 'export PATH=$$PATH:/chef-web-docs/doctools; make docs'

docker-preview: docker-build
	docker run -it -v $(shell pwd):/chef-web-docs \
		-w /chef-web-docs/public \
		-p 8000:8000 chefes/buildkite \
		bash -c 'export PATH=$$PATH:/chef-web-docs/doctools; python -m SimpleHTTPServer'

docker-dtags:
	docker run -it -v $(shell pwd):/chef-web-docs \
		-w /chef-web-docs chefes/buildkite \
		bash -c 'export PATH=$$PATH:/chef-web-docs/doctools; bash'
