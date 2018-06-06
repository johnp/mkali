# mkali - Make Alpine Linux VM Image
[![Build Status](https://travis-ci.org/johnp/mkali.svg?branch=master)](https://travis-ci.org/johnp/mkali)

This project currently is just a simple wrapper around alpinelinux/alpine-make-vm-image to easily make VM images. It caches the apk-tool, as well as the packages by default, so that subsequent builds are quicker. The intention is to upstream some these changes prototyped here.

## TODO

- [x] Implement config file sourcing
- [x] Move generic postinst stuff with 'mkosi.extra'-like functionality into mkali directly, so that user provided postinst can be simpler
- [ ] Support `VERSION` in `mkali.conf` that generates `repositories` file automatically from template
- [ ] Upstream apk-tool and apk package caching
