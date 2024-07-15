# deploy-deleted-flow

> Deploying a Flow as a Destructive Change does not work out of the box (`insufficient access rights on cross-reference id`)
> but there is a workaround.

[![Actions Status](https://github.com/mdapi-issues/deploy-deleted-flow/actions/workflows/default.yml/badge.svg?branch=main)](https://github.com/mdapi-issues/deploy-deleted-flow/actions?query=branch:main)

> [!IMPORTANT]
> A green status badge means the issue was successfully reproduced.
>
> A red status badge means the issue was fixed or the pipeline failed for another reason.

## Issue

Error Message:

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
    <version>61.0</version>
</Package>
```
