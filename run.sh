#!bin/sh
set -xe
docker run \
  --rm \
  --user 1000 \
  --device /dev/ttyACM1 \
  --device /dev/ttyACM0 \
  -e "DISPLAY=$DISPLAY" \
  -v "$HOME/.Xauthority:/$HOME/.Xauthority:ro" \
  --network host \
  -it \
  pico-sigrok bash #pulseview
