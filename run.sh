#!bin/sh
set -xe
docker run \
  --rm \
  --user 1000 \
  -e "DISPLAY=$DISPLAY" \
  -v "$HOME/.Xauthority:/$HOME/.Xauthority:ro" \
  --network host \
  -it \
  pico-sigrok pulseview
