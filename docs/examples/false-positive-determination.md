# False positive determination

### trino: [GHSA-2cqf-6xv9-f22w](https://github.com/advisories/GHSA-2cqf-6xv9-f22w)

This is an example where resolving the CVE was not possible. We attempted to contribute a patch upstream: https://github.com/trinodb/trino/pull/19983

However, the upstream tests helped to identify an incompatibility in newer versions of the `elasticsearch` dependency. Specifically, newer versions of `elasticsearch` are not compatible with OpenSearch since new validation was added to the client. This prevents a medium-difficulty bump of the dependency.

After inspecting the code further, we determined the CVE was a false positive. This is not an ideal scenario since the CVE still shows up in scan results, but provides a good example of when the complexity reaches a upper threshold: https://github.com/wolfi-dev/advisories/pull/513

<!-- TODO: Provide a better example of an analysis that surfaced evidence that a vulnerability match was a false positive. Ideally, show examples for each of the different types of false positives we enumerate in our advisory data format. -->
