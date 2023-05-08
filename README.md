# advisories

Security advisory data for Wolfi

## Introduction

This repository is where we store Wolfi's security advisory data. Each Wolfi package is represented with a `<package-name>.advisories.yaml` file, if there are any advisories recorded for the given package.

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
