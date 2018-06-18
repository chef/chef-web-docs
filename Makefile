BUILDDIR = build
BUILD_COMMAND = sphinx-build -a -W
BUILD_COMMAND_AND_ARGS = $(BUILD_COMMAND)

docs:
	mkdir -p $(BUILDDIR)
	cp -r misc/robots.txt build/
	cp -r misc/sitemap.xml build/
	$(BUILD_COMMAND_AND_ARGS) chef_master/source $(BUILDDIR)
	bash doctools/rundtags.sh

clean:
	@rm -rf $(BUILDDIR)

docker-build:
	docker build . -t docsbuild
	docker run -v $(shell pwd):/build_dir -it docsbuild:latest

docker-preview:
	docker build -f Dockerfile.runner -t docsrunner .
	docker run -p 8080:80 -it docsrunner:latest