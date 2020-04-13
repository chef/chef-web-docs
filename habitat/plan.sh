pkg_name=docs-chef-io
pkg_origin=chef
pkg_version="0.1.0"
pkg_maintainer="Chef Software Inc. <support@chef.io>"
pkg_license=('Chef-MLSA')
pkg_description="HTML for docs.chef.io"
pkg_upstream_url="https://docs.chef.io"
pkg_build_deps=(
  core/hugo
  core/git
  core/go
  core/make
  core/node
)

do_build() {
  make assets
  $(pkg_path_for core/hugo)/bin/hugo
}

do_install() {
  mv "$PLAN_CONTEXT/../public" "$pkg_prefix/public"
}
