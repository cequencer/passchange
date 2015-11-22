#!/bin/bash

PASS_DIR=${1}
GPG_ID=${2}

if [[ -z "${PASS_DIR}" || -z "${GPG_ID}" ]]; then
  echo "Usage: $0 <pass directory> <gpg id>"
  exit 0
fi

for pass in $(find "${PASS_DIR}" -type f -name "*.gpg"); do
  echo "Decrypting ${pass}"

  gpg --out "${pass%.gpg}" -d "${pass}"

  if [ -e "${pass%.gpg}" ]; then
    shred -u "${pass}"
  fi
done

echo "Removing previous .gpg-id file"
rm "${PASS_DIR}/.gpg-id"
