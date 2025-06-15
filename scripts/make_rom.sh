#!/usr/bin/env bash
#
# Copyright (C) 2025 Salvo Giangreco
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# [
source "$SRC_DIR/scripts/utils/build_utils.sh" || exit 1

FORCE=false
BUILD_ROM=false
BUILD_ZIP=true

START_TIME="$(date +%s)"

FIRMWARE_PATH="$(cut -d "/" -f 1 -s <<< "$FIRMWARE")_$(cut -d "/" -f 2 -s <<< "$FIRMWARE")"

GET_WORK_DIR_HASH()
{
    find "$SRC_DIR/stardust" "$SRC_DIR/target/$DEVICE_CODENAME" -type f -print0 | \
        sort -z | xargs -0 sha1sum | sha1sum | cut -d " " -f 1
}

PREPARE_SCRIPT()
{
    while [ "$#" != 0 ]; do
        if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
            FORCE=true
        elif [[ "$1" == "--no-rom-zip" ]]; then
            BUILD_ZIP=false
        else
            if [[ "$1" == "-"* ]]; then
                LOGE "Unknown option: $1"
            fi
            PRINT_USAGE
            exit 1
        fi

        shift
    done
}

PRINT_BUILD_OUTCOME()
{
    local EXIT_CODE="$?"
    local END_TIME
    local ESTIMATED

    END_TIME="$(date +%s)"
    ESTIMATED="$((END_TIME - START_TIME))"

    if [ "$EXIT_CODE" != "0" ]; then
        echo -n -e '\n\033[1;31m'"Build failed "
    else
        echo -n -e '\n\033[1;32m'"Build completed "
    fi
    echo -e "in $((ESTIMATED / 3600))hrs $(((ESTIMATED / 60) % 60))min $((ESTIMATED % 60))sec."'\033[0m\n'
}

PRINT_USAGE()
{
    echo "Usage: make_rom [options]" >&2
    echo " -f, --force : Force ROM build" >&2
    echo " --no-rom-zip : Do not build ROM zip" >&2
}
# ]

PREPARE_SCRIPT "$@"

if $FORCE; then
    BUILD_ROM=true
else
    if [ -f "$WORK_DIR/.completed" ]; then
        if [[ "$(cat "$WORK_DIR/.completed")" == "$(GET_WORK_DIR_HASH)" ]]; then
            LOGW "No changes have been detected in the build environment"
            BUILD_ROM=false
        else
            LOGW "Changes detected in the build environment"
            BUILD_ROM=true
        fi
    else
        BUILD_ROM=true
    fi
fi

trap 'PRINT_BUILD_OUTCOME' EXIT
trap 'echo' INT

if $BUILD_ROM; then
    [ -d "$APKTOOL_DIR" ] && rm -rf "$APKTOOL_DIR"
    [ -f "$WORK_DIR/.completed" ] && rm -f "$WORK_DIR/.completed"

    if [ ! -f "$FW_DIR/$FIRMWARE_PATH/.extracted" ]; then
        if [ ! -f "$ODIN_DIR/$FIRMWARE_PATH/.downloaded" ]; then
            LOG_STEP_IN true "Downloading required firmwares"
            "$SRC_DIR/scripts/download_fw.sh" || exit 1
            LOG_STEP_OUT
        fi
        LOG_STEP_IN true "Extracting required firmwares"
        "$SRC_DIR/scripts/extract_fw.sh" || exit 1
        LOG_STEP_OUT
    fi

    LOG_STEP_IN true "Creating work dir"
    "$SRC_DIR/scripts/internal/create_work_dir.sh" || exit 1
    LOG_STEP_OUT

    if [ -d "$SRC_DIR/stardust/patches" ]; then
        LOG_STEP_IN true "Applying universal ROM patches"
        "$SRC_DIR/scripts/internal/apply_modules.sh" "$SRC_DIR/stardust/patches" || exit 1
        LOG_STEP_OUT
    fi

    if [ -d "$SRC_DIR/platform/$DEVICE_PLATFORM/patches" ]; then
        LOG_STEP_IN true "Applying $DEVICE_PLATFORM patches"
        "$SRC_DIR/scripts/internal/apply_modules.sh" "$SRC_DIR/platform/$DEVICE_PLATFORM/patches" || exit 1
        LOG_STEP_OUT
    fi

    if [ -d "$SRC_DIR/platform/$DEVICE_PLATFORM/mods" ]; then
        LOG_STEP_IN true "Applying $DEVICE_PLATFORM mods"
        "$SRC_DIR/scripts/internal/apply_modules.sh" "$SRC_DIR/platform/$DEVICE_PLATFORM/mods" || exit 1
        LOG_STEP_OUT
    fi

    if [ -d "$SRC_DIR/target/$DEVICE_CODENAME/patches" ]; then
        LOG_STEP_IN true "Applying $DEVICE_CODENAME patches"
        "$SRC_DIR/scripts/internal/apply_modules.sh" "$SRC_DIR/target/$DEVICE_CODENAME/patches" || exit 1
        LOG_STEP_OUT
    fi

    if [ -d "$SRC_DIR/stardust/mods" ]; then
        LOG_STEP_IN true "Applying ROM mods"
        "$SRC_DIR/scripts/internal/apply_modules.sh" "$SRC_DIR/stardust/mods" || exit 1
        LOG_STEP_OUT
    fi

    if [ -d "$OUT_DIR/apktool" ]; then
        LOG_STEP_IN true "Building APKs/JARs"

        while IFS= read -r f; do
            f="${f/$APKTOOL_DIR\//}"
            PARTITION="$(cut -d "/" -f 1 -s <<< "$f")"
            if [[ "$PARTITION" == "system" ]]; then
                "$SRC_DIR/scripts/apktool.sh" b "system" "$f" &
            else
                "$SRC_DIR/scripts/apktool.sh" b "$PARTITION" "$(cut -d "/" -f 2- -s <<< "$f")" &
            fi
        done < <(find "$APKTOOL_DIR" -type d \( -name "*.apk" -o -name "*.jar" \))

        # shellcheck disable=SC2046
        wait $(jobs -p) || exit 1

        LOG_STEP_OUT
    fi

    echo -n "$(GET_WORK_DIR_HASH)" > "$WORK_DIR/.completed"
fi

if $BUILD_ZIP; then
    LOG_STEP_IN true "Creating zip"
    "$SRC_DIR/scripts/internal/build_flashable_zip.sh" || exit 1
    LOG_STEP_OUT
fi

exit 0
