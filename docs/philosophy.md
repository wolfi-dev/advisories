# Philosophy

## Our mission

We endeavor to provide software with no security vulnerabilities. Along with this, we want our users' experience with vulnerability scanners to be positive — we want to enable accurate scanner to produce high quality results. We believe both of these goals intersect to enable vulnerability management workflows that minimize friction and risk for the consumers of our software.

We solve this through a mixture of removing unnecessary components, high quality curation of vulnerability data, and actual patching of vulnerabilities. Upstream projects also play a role in this overall process, but at the end of the day, **users are relying on us to solve this problem for them**.

## How

First, we need to ensure we can always detect potential vulnerabilities in packages. Second, we need to figure out the best way to fix the vulnerability or to prevent a false positive from adding noise to users' scan results. There is a handful of options at our disposal, and in each case we have to choose which path to take.

We should not shy away from fixing vulnerabilities unless there’s a real reason we can’t do it ourselves. Some approaches are harder than others, and some add more value to our users. For example, using a `pending-upstream-fix` event is relatively easy and gives us an advisory entry to point at, but in most cases, it doesn’t add value to our users.

### Resolving Vulnerabilities

#### a. (best) Update our package to a new upstream released version

This is easy and the best case scenario. It allows us to match what upstream wants to ship as their tested and supportable version.

#### b. (great) Update dependencies

When the vulnerability is addressed in a newer version of an upstream dependency, we can update our build configuration to bump the dependency for our package. We need to be more careful with testing the change. This introduces some drift from what upstream (or other users elsewhere) have tested.

For dependency changes that require code changes, we should contribute patches upstream, to provide a path toward removing the drift between our package and the upstream project once again.

#### c. (okay) Cherry-picking a fix from upstream

This is harder, but can provide a lot of value to our users. This involves manual work, research, and sometimes dealing with patch munging. We should use this as a temporary “bridge”, until such time as we’re able to merge in a new upstream released version, as described in (a).

#### d. (almost never) Net-new development, where we create the actual fix ourselves

This is by far the hardest work, and almost certainly impractical at scale. Crafting net-new patches for vulnerabilities would involve deep expertise in potentially dozens of different projects, written in different languages, every day (or week). However, there are a few edge cases where we may choose to develop a new patch to create value for our users.

### Identifying false-positives

We can “nack” vulnerabilities by marking the vulnerability as a `false-positive-determination`. For scanners that have [correctly implemented support for the distro](https://github.com/chainguard-dev/vulnerability-scanner-support/blob/main/docs/scanning_implementation.md), this has the effect of silencing the scanner for our users, in other cases it doesn’t. Over time we expect this to help more users in more cases, as scanners continue to work to support our distro and vulnerability feed.
