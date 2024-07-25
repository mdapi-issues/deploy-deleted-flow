# deploy-deleted-flow

> Deploying a Flow as a Destructive Change does not work out of the box (`insufficient access rights on cross-reference id`)
> but there is a workaround.

[![Actions Status](https://github.com/mdapi-issues/deploy-deleted-flow/actions/workflows/default.yml/badge.svg?branch=main)](https://github.com/mdapi-issues/deploy-deleted-flow/actions?query=branch:main)

> [!IMPORTANT]
> A green status badge means the issue was successfully reproduced.
>
> A red status badge means the issue was fixed or the pipeline failed for another reason.

## Issue

When trying to delete a Flow with a `destructiveChanges.xml` or `destructiveChangesPost.xml` like this:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Package xmlns="http://soap.sforce.com/2006/04/metadata">
    <types>
        <members>Set_Account_Description</members>
        <name>Flow</name>
    </types>
</Package>
```

You'll get this error message:

> insufficient access rights on cross-reference id

Known Issue: https://issues.salesforce.com/issue/a028c00000gAwixAAC/deletion-of-flow-metadata-through-destructive-changes-not-supported

## Workaround

It is possible to deactivate the Flow and delete all inactive Flow Versions in a single deployment:

Deactivate a Flow: Deploy a `FlowDefinition` (`flowDefinitions/Set_Account_Description.flowDefinition-meta.xml`) with active version number `0`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<FlowDefinition xmlns="http://soap.sforce.com/2006/04/metadata">
    <activeVersionNumber>0</activeVersionNumber>
</FlowDefinition>
```

Delete inactive Flow Versions using `destructiveChangesPost.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Package xmlns="http://soap.sforce.com/2006/04/metadata">
    <types>
        <members>Set_Account_Description-1</members>
        <members>Set_Account_Description-2</members>
        <name>Flow</name>
    </types>
</Package>
```

## References

Bug reports and forums

- [Known Issue: Deletion of flow metadata through destructive changes not supported](https://issues.salesforce.com/issue/a028c00000gAwixAAC/deletion-of-flow-metadata-through-destructive-changes-not-supported)
- [StackExchange: Insufficient access rights on cross-reference id when reverting a flow in CI/CD pipeline](https://salesforce.stackexchange.com/questions/298592/insufficient-access-rights-on-cross-reference-id-when-reverting-a-flow-in-ci-cd)

Open Source Tools

- [sfdx leboff:flows:deactivate](https://www.npmjs.com/package/sfdx-leboff#sfdx-leboffflowsdeactivate--n-string--p-string--v-string--u-string---apiversion-string---json---loglevel-tracedebuginfowarnerrorfataltracedebuginfowarnerrorfatal)
- [sfdx leboff:flows:delete](https://www.npmjs.com/package/sfdx-leboff#sfdx-leboffflowsdelete--n-string--p-string--v-string--u-string---apiversion-string---json---loglevel-tracedebuginfowarnerrorfataltracedebuginfowarnerrorfatal)
- [sf hardis:org:purge:flow](https://sfdx-hardis.cloudity.com/hardis/org/purge/flow/)
- [sf ziemniakoss:flows:deactivate](https://www.npmjs.com/package/@ziemniakoss/sf-flow-management-plugin)
- [sf ziemniakoss:flows:purge](https://www.npmjs.com/package/@ziemniakoss/sf-flow-management-plugin)
- [sfdx-git-delta PR to apply workaround for Flow deletions](https://github.com/scolladon/sfdx-git-delta/pull/893)
- [sfdx-git-delta PR to warn about Flow deletions](https://github.com/scolladon/sfdx-git-delta/pull/894)

Vendors

- [Gearset: Flow Definitions can't be deleted"](https://docs.gearset.com/en/articles/2506780-flow-definitions-can-t-be-deleted)
- [Copado: Destructive Changes in Copado Doesn't Support Flow and Process Builder](https://docs.copado.com/articles/#!copado-ci-cd-publication/destructive-changes-in-copado-doesn-t-support-flow-and-process-builder/a/h3_411261369)
