incus exec bazelisk -- rm -rf /home/maciej/mgit-bazelisk
incus exec bazelisk -- rm -rf /home/maciej/.cache
incus file push /home/maciej/mgit-bazelisk bazelisk/home/maciej -r
