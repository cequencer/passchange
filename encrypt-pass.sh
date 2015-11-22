#!/bin/bash

PASS_DIR=${1}
GPG_ID=${2}

if [[ -z "${PASS_DIR}" || -z "${GPG_ID}" ]]; then
  echo "Usage: $0 <pass directory> <gpg id>"
  exit 0
fi

for pass in $(find "${PASS_DIR}" -type f); do
  echo "Encrypting ${pass}"

  gpg --out "${pass}.gpg" -r "${GPG_ID}" -e "${pass}"

  if [ -e "${pass}.gpg" ]; then
    shred -u "${pass}"
  fi
done

echo "Adding .gpg-id file"
echo "${GPG_ID}" >> "${PASS_DIR}/.gpg-id"
