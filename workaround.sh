#!/usr/bin/env bash
set -eo pipefail

FLOW_NAME="Set_Account_Description"

echo "generating destructiveChangesPost.xml"
node -pe 'JSON.parse(fs.readFileSync(0, "utf8")).result.records.map(flow => `--metadata Flow:${flow.Definition.DeveloperName}-${flow.VersionNumber}`).join(" ")' \
    < <(sf data query -t -q "SELECT Definition.DeveloperName, VersionNumber FROM Flow WHERE Definition.DeveloperName='${FLOW_NAME}'" --json) \
    | xargs sf project generate manifest --name destructiveChangesPost --output-dir mdapi/deactivate-and-delete-flow-versions

cat mdapi/deactivate-and-delete-flow-versions/destructiveChangesPost.xml
set -x
sf project deploy start --metadata-dir mdapi/deactivate-and-delete-flow-versions "$@"
