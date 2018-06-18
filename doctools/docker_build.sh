#!/usr/bin/env bash

cd /build_dir
# We explicitly install our requirements on every local build to make sure we're
# up to date. This takes a little longer than building it into the docker image
# but ensures we don't run into stale dependencies.
pip install -r requirements.txt
make docs