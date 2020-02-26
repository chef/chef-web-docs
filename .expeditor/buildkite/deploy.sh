#!/bin/bash

set -euo pipefail

export CHANNEL="${EXPEDITOR_TARGET_CHANNEL:-acceptance}"

cd terraform
make apply
