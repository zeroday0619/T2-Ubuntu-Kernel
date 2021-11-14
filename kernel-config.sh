#!/bin/bash

# Get Subversion
sudo apt update
sudo apt install subversion

# Get kernel config by arch
svn checkout --depth=empty svn://svn.archlinux.org/packages
cd packages/
svn update linux

# Get log of older releases
#svn log linux

# Use svn update -rXXX to revert to older release.
