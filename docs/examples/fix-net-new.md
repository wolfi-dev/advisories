# Fix: net-new

We should **almost never** develop net-new CVE fixes. However, there's always an exception to the rule.

### Example: [CVE-2023-46402](https://github.com/advisories/GHSA-3f2q-6294-fmq5)

This vulnerability has been reported on an abandoned repository. There are no fixes available and this is a fairly simple Go repository. Chainguard authored a patch and attempted to contribute back:

- https://github.com/whilp/git-urls/pull/25

Given the repo is abandoned, the PR didn't get merge and Chainguard choose to fork the repo to apply the net-new patch: https://github.com/chainguard-dev/git-urls

This is providing us a way to replace the vulnerable repository with Chainguard's repository. This is **rare** and should not happen on a regular basis.
