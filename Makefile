BUILDDIR = build
BUILD_COMMAND = sphinx-build -a -W
BUILD_COMMAND_AND_ARGS = $(BUILD_COMMAND)

# if we are in CI we need to add the habitat build container's python binpath
export PATH := $(shell hab pkg path core/python2)/bin:$(PATH)

prepare:
	pip install -r requirements.txt

docs: prepare
	mkdir -p $(BUILDDIR)
	cp -r misc/robots.txt build/
	cp -r misc/sitemap.xml build/
	$(BUILD_COMMAND_AND_ARGS) chef_master/source $(BUILDDIR)
	doctools/rundtags.sh

clean:
	@rm -rf $(BUILDDIR)

docker-build:
	docker build . -t docsbuild
	docker run -v $(shell pwd):/build_dir -it docsbuild:latest

docker-preview:
	docker build -f Dockerfile.runner -t docsrunner .
	docker run -p 8080:80 -it docsrunner:latest