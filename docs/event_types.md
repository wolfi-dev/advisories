# Event Types

Advisories include a list of ordered, timestamped "events". Each event has a designated "type". Each type has a specific meaning, and it indicates the structure of the data contained in the event.

## detection

This indicates that we've detected a potential vulnerability match for the distro package. This event doesn't imply the vulnerability match is a true positive or that any remediation is planned, it just puts the vulnerability on our radar of issues to look further into.

## true-positive-determination

This indicates that we've determined that a given vulnerability match is a true positive, i.e. that the package is affected by the vulnerability.

## false-positive-determination

This indicates that we've determined that a given vulnerability does not affect the package. This information will be propagated to vulnerability scanners. Not all scanners will respect Chainguard's false positive determinations.

## fixed

This indicates that the vulnerabiblity had affected a version of our package but has been fixed as of the specified "fixed version" of our package.

## fix-not-planned

This indicates that we're aware of the vulnerability match, but we don't plan on issuing a fix. This type of event **should never be used on supported software**. We generally only use this event type on packages that have reached end-of-life.

## pending-upstream-fix

This indicates that we've been unable to resolve a vulnerability without work from the upstream project, such as because applying a fix introduces breaking changes to a package, or because the upstream fix has yet to be made available. This is an event type that we use as a last resort when there are very specific reasons preventing a fix to a vulnerability. This is especially relevant when trying to bump a language level dependency. The need for code changes isn't enough to justify using the `pending-upstream-fix` type. We should ensure alignment with the [CVE Philosophy](./philosophy.md) before using this event type.
