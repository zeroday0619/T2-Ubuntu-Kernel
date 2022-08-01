#!/bin/bash

set -eu -o pipefail

BUILD_PATH=/tmp/build-kernel

# Patches
APPLE_SMC_DRIVER_GIT_URL=https://github.com/AdityaGarg8/linux-t2-patches.git
APPLE_SMC_DRIVER_BRANCH_NAME=5.15
APPLE_SMC_DRIVER_COMMIT_HASH=dd10d0d8ae3e54599c8d00c76db0a163b7cbb8f8

rm -rf "${BUILD_PATH}"
mkdir -p "${BUILD_PATH}"
cd "${BUILD_PATH}" || exit

### AppleSMC and BT aunali fixes
git clone --single-branch --branch ${APPLE_SMC_DRIVER_BRANCH_NAME} ${APPLE_SMC_DRIVER_GIT_URL} \
  "${BUILD_PATH}/linux-mbp-arch"
cd "${BUILD_PATH}/linux-mbp-arch" || exit
git checkout ${APPLE_SMC_DRIVER_COMMIT_HASH}
rm 100*

while IFS= read -r file; do
  echo "==> Adding ${file}"
  cp -rfv "${file}" "${WORKING_PATH}"/patches/"${file##*/}"
done < <(find "${BUILD_PATH}/linux-mbp-arch" -type f -name "*.patch" | grep -vE '000[0-9]')
