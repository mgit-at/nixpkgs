#!/bin/bash

set -euxo pipefail

lnt rebuild bazelisk
incus restart bazelisk
sleep 5s
incus exec bazelisk -- sh -c "cd /home/maciej/mgit-bazelisk && su maciej -c 'bazelisk-env build //... --sandbox_debug --verbose_failures --keep_going'"
