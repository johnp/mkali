# mkali - Make Alpine Linux VM Image
[![Build Status](https://travis-ci.org/johnp/mkali.svg?branch=master)](https://travis-ci.org/johnp/mkali)

This project is a simple wrapper around [alpinelinux/alpine-make-vm-image](https://github.com/alpinelinux/alpine-make-vm-image) to more easily make Alpine Linux images. It allows configuration similar to `mkosi` and caches the apk-tool as well as the packages by default so that subsequent builds are quicker. The intention is to upstream some of the changes prototyped here.

## Requirements

See alpine-make-vm-image; also: sudo.

## Usage

Simply pull this git repo and execute `./mkali $TARGET`, where `$TARGET` is a path to the directory containing your `mkali.conf`. Available config options can be found at the top of the `mkali` script.  
The `example` directory contains a simple build that includes an OpenRC service file in `etc/init.d/`, a program in `opt/` and an `mkali.postinst` script that sets up a new user account and enables the service.  
The `etc/apk/` directory is needed in every build directory for now, so that apk has access to the alpine GPG keys as well as to the repositories file, in which the user can change the Alpine Linux version (usually latest-stable or edge).

Top level directories in the `$TARGET` directory are recursively copied into the image before the postinst step.

## TODO

- [x] Implement config file sourcing
- [x] Move generic postinst stuff with 'mkosi.extra'-like functionality into mkali directly, so that user provided postinst can be simpler
- [ ] Support `VERSION` in `mkali.conf` that generates `repositories` file automatically from template
- [ ] Upstream apk-tool and apk package caching
