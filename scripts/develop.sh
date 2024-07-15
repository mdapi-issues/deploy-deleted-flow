#!/usr/bin/env bash

set -eo pipefail
set -x

sf org create scratch -f config/project-scratch-def.json --alias deploy-deleted-flow --set-default
sf project deploy start
