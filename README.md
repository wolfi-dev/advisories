# advisories

> ⚠️ **This repository has been archived.** For the latest Wolfi security advisory data, please visit <https://images.chainguard.dev/security>.

Security advisory data for the Wolfi distribution.

## Introduction

This repository is where we store Wolfi's security advisory data. Each Wolfi package is represented with a `<package-name>.advisories.yaml` file, if there are any advisories recorded for the given package.

The purpose of the advisory data is to record all investigated package vulnerabilities and indicate the latest understanding of whether or not the package is affected by the vulnerability.

## Interpreting the data

Each package advisories file in this repository has a list of one or more advisories. Each advisory is named by an ID (e.g. "CVE-2023-12345") and contains a list of timestamped events that describe the investigation of a vulnerability's impact on the given package.

### Event Types

For a detailed look at the current event types, see the [Event Types](./docs/event_types.md) document.

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
