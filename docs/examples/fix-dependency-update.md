# Fix: dependency update

Dependency updates work differently depending on the language.

## Java

### trino [CVE-2023-6378](https://github.com/advisories/GHSA-vmq6-5m68-f53m)

In this example, we introduce a patch to the Maven `pom.xml` file in order to bump a transitive dependency: https://github.com/wolfi-dev/os/pull/9669

### cassandra [CVE-2023-6378](https://github.com/advisories/GHSA-vmq6-5m68-f53m)

In this example, we introduce a patch to the antfile `build.xml` to build a dependency: https://github.com/wolfi-dev/os/pull/9676

## Go

### istio-pilot-discovery-1.20 [GHSA-2c7c-3mj9-8fqh](https://github.com/advisories/GHSA-2c7c-3mj9-8fqh)

This is a very standard example for bumping an easy Go dependency: https://github.com/wolfi-dev/os/pull/9663

<!-- TODO: Add a few complex otel examples -->
