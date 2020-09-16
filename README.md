# Docker container for JDownlaoder2 on aarch64

This is a fork based on [jlesage/jdownloader-2](https://hub.docker.com/r/jlesage/jdownloader-2), and modified to run on aarch64 machines.

Refer to  [jlesage/jdownloader-2](https://github.com/jlesage/docker-jdownloader-2) for usage and setup, the packages are equivalent.

Tested on Raspberry Pi 4 4GB running Ubuntu 20.04 (64bit)

## Changes

+ baseimage: use Ubuntu 20.04, for better support on aarch64 packages
+ openjdk-8-jre: From Ubuntu focal repository
+ 7-Zip-Bindings V16.02 built for Linux-aarch64
