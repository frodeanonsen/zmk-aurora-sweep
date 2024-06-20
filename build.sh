#!/bin/bash

PYENV_VIRTUALENV_DISABLE_PROMPT=1
PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv activate zmk

# if [ -z "$1" ]; then
#   echo "Usage: $0 home|zygizo"
#   exit 1
# fi

# if [ "$1" = "home" ]; then
#   CONFIG_ZMK_KEYBOARD_NAME="Aurora Home"
# else
#   CONFIG_ZMK_KEYBOARD_NAME="Aurora Zygizo"
# fi

[ -f left.uf2 ] && rm left.uf2
[ -f right.uf2 ] && rm right.uf2

echo Building $CONFIG_ZMK_KEYBOARD_NAME left
# west build -p -b nice_nano_v2 -- -DSHIELD="splitkb_aurora_sweep_left"
# mv build/zephyr/zmk.uf2 left.uf2
west build -p -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=$(pwd)/config -DSHIELD="splitkb_aurora_sweep_left"
cp -f build/zephyr/zmk.uf2 left.uf2

echo Building $CONFIG_ZMK_KEYBOARD_NAME right
# west build -p -b nice_nano_v2 -- -DSHIELD="splitkb_aurora_sweep_right"
# mv build/zephyr/zmk.uf2 right.uf2
west build -p -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=$(pwd)/config -DSHIELD="splitkb_aurora_sweep_right"
cp -f build/zephyr/zmk.uf2 right.uf2

