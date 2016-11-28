BUILDDIR = build
S3BUCKET = chef-docs
S3OPTIONS = --acl-public --exclude='.doctrees/*' --exclude='chef/.doctrees/*' --config ~/.s3cfg-chef-docs  --add-header "Cache-Control: max-age=900"
BUILD_COMMAND = sphinx-build -a -W
PARALLEL_BUILD:=
BUILD_COMMAND_AND_ARGS = $(BUILD_COMMAND) $(PARALLEL_BUILD)

# was the first option after S3OPTIONS
# --delete-removed


#
# SAVED FOR HISTORY PURPOSES
# This is the old mapping of the makefile for what should be built, not built
# Add after `release:` the builds to build; everything else underneath commented out
#
# release: master 12-5 decks
#
#
# OTHER BUILDS -- REMOVED FOR THE MOMENT AND ONLY REBUILD AD HOC
# devkit analytics_1-1 delivery
#
# 11-0 11-2 11-4 11-6 11-8 11-10 11-12 11-14 11-16 11-18
# 12-0 12-1 12-2 12-3 12-4
# ohai-6 ohai-7 ohai-8
# push_1-0
# server_12-0 server_12-1 server_12-2
# oec_11-0 oec_11-1 oec_11-2
# osc_11-0 osc_11-1
#
# RETIRED: located in chef-docs-misc, no longer built or maintained
# enterprise open_source slides
# 10 private_chef
# all analytics delivery client devkit server
#

#
# Parallel Building:
# Supported by Sphinx 1.2.x and above
#
# Specify PARALLEL_BUILD="-j X" on the make cmdline
# If you have an 8 cpu machine, 6 might be a good number
#
# make master PARALLEL_BUILD="-j 6"
#

clean:
	@rm -rf $(BUILDDIR)

master:
	mkdir -p $(BUILDDIR)
	cp -r misc/robots.txt build/
	cp -r misc/sitemap.xml build/
	cp -r misc/google69a8711569b2fcce.html build/
	$(BUILD_COMMAND_AND_ARGS) chef_master/source $(BUILDDIR)
	bash doctools/rundtags.sh

decks:
	mkdir -p $(BUILDDIR)/decks/
	$(BUILD_COMMAND_AND_ARGS) snapshots/slide_decks/source $(BUILDDIR)/decks/

automate:
	mkdir -p $(BUILDDIR)/release/automate/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_automate/source $(BUILDDIR)/release/automate/

compliance:
	mkdir -p $(BUILDDIR)/release/compliance/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_compliance/source $(BUILDDIR)/release/compliance/

11-0:
	mkdir -p $(BUILDDIR)/release/11-0/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-0/source $(BUILDDIR)/release/11-0/

11-2:
	mkdir -p $(BUILDDIR)/release/11-2/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-2/source $(BUILDDIR)/release/11-2/

11-4:
	mkdir -p $(BUILDDIR)/release/11-4/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-4/source $(BUILDDIR)/release/11-4/

11-6:
	mkdir -p $(BUILDDIR)/release/11-6/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-6/source $(BUILDDIR)/release/11-6/

11-8:
	mkdir -p $(BUILDDIR)/release/11-8/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-8/source $(BUILDDIR)/release/11-8/

11-10:
	mkdir -p $(BUILDDIR)/release/11-10/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-10/source $(BUILDDIR)/release/11-10/

11-12:
	mkdir -p $(BUILDDIR)/release/11-12/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-12/source $(BUILDDIR)/release/11-12/

11-14:
	mkdir -p $(BUILDDIR)/release/11-14/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-14/source $(BUILDDIR)/release/11-14/

11-16:
	mkdir -p $(BUILDDIR)/release/11-16/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-16/source $(BUILDDIR)/release/11-16/

11-18:
	mkdir -p $(BUILDDIR)/release/11-18/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_11-18/source $(BUILDDIR)/release/11-18/

12-0:
	mkdir -p $(BUILDDIR)/release/12-0/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-0/source $(BUILDDIR)/release/12-0/

12-1:
	mkdir -p $(BUILDDIR)/release/12-1/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-1/source $(BUILDDIR)/release/12-1/

12-2:
	mkdir -p $(BUILDDIR)/release/12-2/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-2/source $(BUILDDIR)/release/12-2/

12-3:
	mkdir -p $(BUILDDIR)/release/12-3/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-3/source $(BUILDDIR)/release/12-3/

12-4:
	mkdir -p $(BUILDDIR)/release/12-4/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-4/source $(BUILDDIR)/release/12-4/

12-5:
	mkdir -p $(BUILDDIR)/release/12-5/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-5/source $(BUILDDIR)/release/12-5/

12-6:
	mkdir -p $(BUILDDIR)/release/12-6/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-6/source $(BUILDDIR)/release/12-6/

12-7:
	mkdir -p $(BUILDDIR)/release/12-7/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-7/source $(BUILDDIR)/release/12-7/

12-8:
	mkdir -p $(BUILDDIR)/release/12-8/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-8/source $(BUILDDIR)/release/12-8/

12-9:
	mkdir -p $(BUILDDIR)/release/12-9/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-9/source $(BUILDDIR)/release/12-9/

12-10:
	mkdir -p $(BUILDDIR)/release/12-10/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-10/source $(BUILDDIR)/release/12-10/

12-11:
	mkdir -p $(BUILDDIR)/release/12-11/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-11/source $(BUILDDIR)/release/12-11/

12-12:
	mkdir -p $(BUILDDIR)/release/12-12/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-12/source $(BUILDDIR)/release/12-12/

12-13:
	mkdir -p $(BUILDDIR)/release/12-13/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_chef_12-13/source $(BUILDDIR)/release/12-13/

oec_11-0:
	mkdir -p $(BUILDDIR)/release/oec_11-0/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_oec_11-0/source $(BUILDDIR)/release/oec_11-0/

oec_11-1:
	mkdir -p $(BUILDDIR)/release/oec_11-1/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_oec_11-1/source $(BUILDDIR)/release/oec_11-1/

oec_11-2:
	mkdir -p $(BUILDDIR)/release/oec_11-2/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_oec_11-2/source $(BUILDDIR)/release/oec_11-2/

osc_11-0:
	mkdir -p $(BUILDDIR)/release/osc_11-0/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_osc_11-0/source $(BUILDDIR)/release/osc_11-0/

osc_11-1:
	mkdir -p $(BUILDDIR)/release/osc_11-1/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_osc_11-1/source $(BUILDDIR)/release/osc_11-1/

analytics:
	mkdir -p $(BUILDDIR)/release/analytics/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_analytics/source $(BUILDDIR)/release/analytics/

devkit:
	mkdir -p $(BUILDDIR)/release/devkit/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_devkit/source $(BUILDDIR)/release/devkit/

ohai-8:
	mkdir -p $(BUILDDIR)/release/ohai-8/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_ohai_8/source $(BUILDDIR)/release/ohai-8/

ohai-7:
	mkdir -p $(BUILDDIR)/release/ohai-7/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_ohai_7/source $(BUILDDIR)/release/ohai-7/

ohai-6:
	mkdir -p $(BUILDDIR)/release/ohai-6/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_ohai_6/source $(BUILDDIR)/release/ohai-6/

push_1-0:
	mkdir -p $(BUILDDIR)/release/push_jobs_1-0/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_push_jobs_1-0/source $(BUILDDIR)/release/push_jobs_1-0/

push_2-1:
	mkdir -p $(BUILDDIR)/release/push_jobs_2-1/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_push_jobs_2-1/source $(BUILDDIR)/release/push_jobs_2-1/

server_12-8:
	mkdir -p $(BUILDDIR)/release/server_12-8/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-8/source $(BUILDDIR)/release/server_12-8/

server_12-7:
	mkdir -p $(BUILDDIR)/release/server_12-7/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-7/source $(BUILDDIR)/release/server_12-7/

server_12-6:
	mkdir -p $(BUILDDIR)/release/server_12-6/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-6/source $(BUILDDIR)/release/server_12-6/

server_12-5:
	mkdir -p $(BUILDDIR)/release/server_12-5/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-5/source $(BUILDDIR)/release/server_12-5/

server_12-4:
	mkdir -p $(BUILDDIR)/release/server_12-4/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-4/source $(BUILDDIR)/release/server_12-4/

server_12-3:
	mkdir -p $(BUILDDIR)/release/server_12-3/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-3/source $(BUILDDIR)/release/server_12-3/

server_12-2:
	mkdir -p $(BUILDDIR)/release/server_12-2/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-2/source $(BUILDDIR)/release/server_12-2/

server_12-1:
	mkdir -p $(BUILDDIR)/release/server_12-1/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-1/source $(BUILDDIR)/release/server_12-1/

server_12-0:
	mkdir -p $(BUILDDIR)/release/server_12-0/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_server_12-0/source $(BUILDDIR)/release/server_12-0/

supermarket:
	mkdir -p $(BUILDDIR)/release/supermarket/
	$(BUILD_COMMAND_AND_ARGS) snapshots/release_supermarket/source $(BUILDDIR)/release/supermarket/


upload:	release
	s3cmd sync $(S3OPTIONS) $(BUILDDIR)/ s3://$(S3BUCKET)/

#
# OLD BUILDS DO NOT BUILD
#
# 10:
# 	mkdir -p $(BUILDDIR)/release/10/
# 	$(BUILD_COMMAND_AND_ARGS) release_chef_10/source $(BUILDDIR)/release/10/
#
# private_chef:
# 	mkdir -p $(BUILDDIR)/release/private_chef/
# 	$(BUILD_COMMAND_AND_ARGS) release_private_chef/source $(BUILDDIR)/release/private_chef/
