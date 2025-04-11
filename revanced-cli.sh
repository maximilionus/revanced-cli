#!/bin/bash

# CLI utility to apply selected ReVanced patches.
# Copyright (C) 2025  Max Gashutin <maximilionuss@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

TOOLCHAIN="./bin"

if [[ ! -d $TOOLCHAIN ]]; then
    echo "Revanced toolchain not found!"
    ./install.sh
fi

patch_tiktok() {
    echo "- Patching TikTok"
    echo

    java -jar "$TOOLCHAIN/revanced-cli.jar" patch \
        --patches "$TOOLCHAIN/patches.rvp" \
        --enable "SIM spoof" \
        "$1"

    echo
    echo "Done"
}

patch_spotify() {
    echo "- Patching Spotify"
    echo

    java -jar "$TOOLCHAIN/revanced-cli.jar" patch \
        --patches "$TOOLCHAIN/patches.rvp" \
        --exclusive \
        --enable "Spoof signature" \
        "$1"

    echo
    echo "Done"
}

package_name=$( basename "$1" )
case $package_name in
    com.zhiliaoapp.musically*)
        patch_tiktok "$1"
        ;;
    com.spotify.music*|Spotify*)
        patch_spotify "$1"
        ;;
    *)
        echo "No supported apk provided to script"
        ;;
esac
