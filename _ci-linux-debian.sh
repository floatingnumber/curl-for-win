#!/bin/sh

# Copyright 2017-present Viktor Szakats <https://vsz.me/>
# See LICENSE.md

_BRANCH="${APPVEYOR_REPO_BRANCH}${CI_COMMIT_REF_NAME}${GITHUB_REF}${GIT_BRANCH}"

cat /etc/*-release

export _CCSUFFIX=''
[ "${CC}" = 'mingw-clang' ] && _optpkg="clang${_CCSUFFIX}"

dpkg --add-architecture i386
apt-get --quiet 2 --option Dpkg::Use-Pty=0 update
# shellcheck disable=SC2086
apt-get --quiet 2 --option Dpkg::Use-Pty=0 install \
  curl git gpg rsync python3-pip make cmake \
  libssl-dev \
  gcc-mingw-w64 g++-mingw-w64 ${_optpkg} \
  autoconf automake libtool \
  zip zstd time jq dos2unix wine64 wine32

./_build.sh
