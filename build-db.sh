#!/usr/bin/env bash
#
# Script name: build-db.sh
# Description: Script for rebuilding the database for polonel-arch-repo.
# Github: https://www.github.com/polonel/polonel-arch-repo
# Contributors: Chris Brame

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

x86_pkgbuild=$(find ./x86_64 -type f -name "*.pkg.tar.zst*")

echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64
cd x86_64
rm -f nidus-core-repo*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
## -v: verify package sig
repo-add -s -n -v -R nidus-core-repo.db.tar.gz *.pkg.tar.zst

# Removing the symlinks because Github can't handle them.
rm nidus-core-repo.db
rm nidus-core-repo.db.sig
rm nidus-core-repo.files
rm nidus-core-repo.files.sig

# Renaming the tar.gz files without the extension.
mv nidus-core-repo.db.tar.gz nidus-core-repo.db
mv nidus-core-repo.db.tar.gz.sig nidus-core-repo-db.sig
mv nidus-core-repo.files.tar.gz nidus-core-repo.files
mv nidus-core-repo.files.tar.gz.sig nidus-core-repo.files.sig


echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"

