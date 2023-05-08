#!/bin/bash

set -euo pipefail

### Configuration: Set these first!

distro_repo_dir="$HOME/code/wolfi-os"
advisories_repo_dir="$HOME/code/wolfi-advisories"

### Logic

import() {
  local advisories_file_extension=".advisories.yaml"

  (
    echo "About to remove existing advisories files... (Ctrl+C to cancel)"
    sleep 5
    cd "${advisories_repo_dir}"
    rm -fv ./*${advisories_file_extension}
  )

  (
    cd "${distro_repo_dir}"

    for f in *.yaml; do

      # If it's not a Melange config file, ignore it.
      if [[ "${f}" == ".yam.yaml" ]]; then
        continue
      fi

      # If it doesn't have any advisory data, ignore it.
      if [[ $(yq 'keys | contains(["advisories"])' "${f}") == "false" ]]; then
        continue
      fi

      # Import advisory data (and secfixes, for now) from the distro.
      echo "importing ${f}"

      new_file_path="${advisories_repo_dir}/$(basename "${f}" .yaml)${advisories_file_extension}"
      yq '. |= pick(["package", "secfixes", "advisories"]) | .package |= pick(["name"]) | . comments=""' "${f}" > "${new_file_path}"

    done
  )


  (
    cd "${advisories_repo_dir}"
    yam .
  )
}

import
