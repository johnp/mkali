# mkali - Make Alpine Linux VM Image
[![Build Status](https://travis-ci.org/johnp/mkali.svg?branch=master)](https://travis-ci.org/johnp/mkali)

This project currently is just a simple wrapper around alpinelinux/alpine-make-vm-image to easily make VM images. It caches the apk-tool, as well as the packages by default, so that subsequent builds are quicker. The intention is to upstream these changes prototyped here.

## TODO

- [ ] Parse `$SCENARIO/packages` file (currently packages have to be added to the mkali script directly)
- [ ] Implement root-less mode via [libguestfs](https://libguestfs.org)
   (libguestfs is not packaged for alpine yet)
- [ ] Implement [mkosi](https://github.com/systemd/mkosi) like config file parsing
- [ ] Upstream apk-tool and apk package caching
