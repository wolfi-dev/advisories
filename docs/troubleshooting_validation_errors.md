# Troubleshooting Validation Errors

Validation messages are shown in a hierarchy.

## Error message: `package build configuration not found in the distro`

### What triggers this error

Wolfictl looks at the name by the distro package referenced in each advisories YAML file's content (specifically, the value of `.package.name`), and then it checks whether this package is currently defined in the distro repo (e.g. `wolfi-dev/os`, if the advisory file is in `wolfi-dev/advisories`).

Wolfictl emits this error when it doesn't see this package defined in any Melange configuration YAML file in the `main` branch of the distro repo.

[Here](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L227) is where the error originates in the code.

### Possible causes and solutions

1. The distro package is brand new, and the distro PR (e.g. in `wolfi-dev/os`) that adds this package hasn't been merged yet.
    - **Solution:** Re-run the advisory validation CI check once the distro PR is merged.
        - You might be wondering: "But the distro repo CI is scanning my package and will show an :x: until this advisories PR merges... So this seems like a chicken-and-egg problem." Good observation. Invariably, one PR will need to be merged first. We've set things up in these repos to reflect the opinion that _the distro PR should be merged before the advisories PR_. That's why the distro CI scan check is non-blocking, whereas the advisories CI check is blocking.

1. The distro package has been renamed. Maybe it was turned into a "version stream" and so the package name has a new version suffix now. Or maybe the original name of the package just wasn't good enough for some reason, so someone fixed it.
    - **Solution:** If the package name was changed, and we're sure that this advisories file is meant to describe that distro package, we need to update the advisories file to match — both the `.package.name: foo` value and the filename itself (`foo.advisories.yaml`).

### Why we have this validation rule

If the package name doesn't match the referenced package name in the advisories file, scanners won't know to apply the data from the advisories file when it detects the package installed on the filesystem. This means the advisory data for this package would be useless, and users would see incorrect vulnerability match results for this package.

[This issue](https://github.com/wolfi-dev/advisories/issues/277) describes a proposal that might make this kind of validation less painful in the future, specifically for the case of package renames. Feel free to comment there if you have an opinion!

## Error message: `event's timestamp (2024-01-02T19:46:34Z) set to more than 3 days ago; timestamps should accurately capture event creation time`

### What makes wolfictl show this error?

At the start of validation, wolfictl takes note of the current time, and it looks at the **new** [events](../README.md#interpreting-the-data) in your PR (that weren't present in the advisories repo before your PR), and it checks to see if your events' timestamps are more than 3 days older than the current time.

This validation error means that the specified event timestamp is more than 3 days old. New events should not be more than 3 days old.

[Here](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L530-L534) is where the error originates in the code.

### Possible causes and solutions

1. You copied and pasted this advisory data from somewhere else. Maybe you're setting up a new version stream, and some of an existing version stream's advisory data apply to this new package as well. Or maybe the advisory data is relevant here for a different reason, e.g. it was a Go stdlib vulnerability for a different Go-based package, but the same reasoning on its vulnerable status applies to other Go-based packages as well.
    - **Solution:** You'll need to update the timestamp values for the new events you're adding to the current time.

1. You started working on this advisories PR a while ago. When you first added these events to your advisories file, the timestamps _were_ current! The fact that they're more than 3 days old is merely because that was 4+ days ago, and CI validation ran only just now.
    - **Solution:** You'll need to update the timestamp values for the new events you're adding to the current time.

### Why do we need this validation rule?

We weren't sure about this rule initially, but in a group discussion we ultimately agreed that it was for the best. This rule is intended to prevent two kinds of problem:

- It's important that as maintainers of the distro, we're being transparent about when we investigated the vulnerability and when exactly the realization behind each event took place. If we're adding new event data with significantly old timestamps, it distorts the truth of when the event really happened. Instead, we want to encourage the prompt recording of any new analysis for a given package vulnerability, as well as the prompt integration of this data into the `main` branch of the advisory repo.

- Before we introduced this rule, there were several cases where old advisory data was being copied into new advisory files, where the conclusions or context from the original advisory file didn't apply to the new file, resulting in the addition of low-quality, low-accuracy advisory data. This made it take longer for PR reviewers to verify that the data and its conclusions were appropriate for the new advisory files, which in turn discouraged reviewers from taking the time to check this data at all. The hypothesis behind the rule was that adding timestamp validation would add just enough of a speedbump that new data would be entered more carefully. Users running `wolfictl adv create/update` to enter their own fresh analyses were guaranteed have current timestamps applied to their data, which meant they wouldn't be slowed down by the timestamp validation rule. So far in practice, this hypothesis has been proving right.

Does it have to be exactly 3 days? No, this value is somewhat arbitrary, but we had to choose something, and 3 days seemed like a reasonable starting point. This value is centrally defined [here](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L521) if we want to tweak it! (And if you do, please update _**this documentation**_ at the same time!)

## Error message: `package not found in APKINDEX`

### What happened here?

TODO

[Here's where the error originates in the code.](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L272) (If you see it twice, the second instance is from [here](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L309). It could be nice to avoid printing the message twice, if anyone wants to submit a PR!)

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `package version "0.49.0-r0" not found in APKINDEX`

### What happened here?

TODO

[Here's where the error originates in the code.](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L288) (If you see it twice, the second instance is from [here](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L338). It could be nice to avoid printing the message twice, if anyone wants to submit a PR!)

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `"3.40.0-r2" is the first version of the package listed in the APKINDEX, so it cannot be used as a fixed-version (consider switching type to "false-positive-determination")`

### What happened here?

TODO

[Here's where the error originates in the code.](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L327-L331)

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `one or more events were modified or removed`

### What happened here?

TODO

[Here's where the error originates in the code.](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L439)

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `advisory was removed`

### What happened here?

TODO

[Here's where the error originates in the code.](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/advisory/validate.go#L427)

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `error during command execution: unable to clone upstream advisories repo for comparison: unable to checkout hash "0ff93cecf86e942b2acd9f261cb85763dacec60a" for repo "https://github.com/wolfi-dev/advisories": object not found`

### What happened here?

TODO

[Here's where the error originates in the code](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/cli/advisory_validate.go#L152) (with respect to advisory validation).

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `error during command execution: unable to create index of advisories repo: unable to parse configuration at "thanos-0.33.advisories.yaml": strict YAML unmarshaling failed: failed to decode to Go type *v2.partialEvent: yaml: unmarshal errors`

### What happened here?

Wolfictl tried to parse the advisory data from the named YAML file, but it couldn't for some reason. Unfortunately, this prevents validation from even starting, since the validation logic operates on successfully decoded advisory data, but the decoding wasn't able to finish.

[Here's where the error originates in the code](https://github.com/wolfi-dev/wolfictl/blob/ca8eb3cc61b93e7eee8f85bc992c20d376945148/pkg/cli/advisory_validate.go#L165) (with respect to advisory validation).

### Possible causes

TODO

### Why do we need this validation rule?

TODO

## Error message: `error during command execution: unable to create index of advisories repo: unable to add entry to index for "spark.yaml": unable to add configuration (for item named "spark") to index: name already used by existing item`
