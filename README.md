# advisories

Security advisory data for the Wolfi distribution.

## Introduction

This repository is where we store Wolfi's security advisory data. Each Wolfi package is represented with a `<package-name>.advisories.yaml` file, if there are any advisories recorded for the given package.

The purpose of the advisory data is to record all investigated package vulnerabilities and indicate the latest understanding of whether or not the package is affected by the vulnerability.

## Interpreting the data

Each package advisories file in this repository has a list of one or more advisories. Each advisory is named by an ID (e.g. "CVE-2023-12345") and contains a list of timestamped events that describe the investigation of a vulnerability's impact on the given package.

### Event Types

Here are the types of events found in an advisory and what they mean:

`detection`: The maintainers are aware that the package is potentially affected by the vulnerability, but more investigation is needed in order to reach a conclusion.

`true-positive-determination`: The package is believed to be affected by the vulnerability.

`false-positive-determination`: The package is not believed to be affected by the vulnerability. Where possible, further explanation about why this match is a false positive is included in the event data's `type` and `note` fields.

`fixed`: There was one or more versions of the package affected by the vulnerability, but as of the `fixed-version`, the vulnerability has been mitigated.

## Using the data

The best way to interact with the data in this repo is to use [`wolfictl`](https://github.com/wolfi-dev/wolfictl). Run `wolfictl advisory -h` to see a list of commands designed to interact with this dataset.

For example, to see advisories for every package in Wolfi:

```console
$ wolfictl advisory list
apko: CVE-2023-28840: fixed (0.7.3-r1)
apko: CVE-2023-28841: fixed (0.7.3-r1)
apko: CVE-2023-28842: fixed (0.7.3-r1)
bind: CVE-2018-5736: fixed (9.18.10-r0)
(and so on...)
```
