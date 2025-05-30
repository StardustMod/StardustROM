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

FIRMWARE_PATH="$(cut -d "/" -f 1 -s <<< "$FIRMWARE")_$(cut -d "/" -f 2 -s <<< "$FIRMWARE")"

COPY_FIRMWARE()
{
    local SOURCE_FOLDERS="product system vendor"
    for f in $SOURCE_FOLDERS; do
        if [ -d "$FW_DIR/$FIRMWARE_PATH/$f" ]; then
            LOG "- Copying /$f from source firmware"
            EVAL "rsync -a --mkpath --delete --exclude=\"*system_ext*\" \"$FW_DIR/$FIRMWARE_PATH/$f\" \"$WORK_DIR\"" || exit 1
            sed "/system_ext/d" "$FW_DIR/$FIRMWARE_PATH/file_context-$f" > "$WORK_DIR/configs/file_context-$f"
            sed "/system_ext/d" "$FW_DIR/$FIRMWARE_PATH/fs_config-$f" > "$WORK_DIR/configs/fs_config-$f"
        else
            [ -d "$WORK_DIR/$f" ] && rm -rf "$WORK_DIR/$f"
            [ -f "$WORK_DIR/configs/file_context-$f" ] && rm -f "$WORK_DIR/configs/file_context-$f"
            [ -f "$WORK_DIR/configs/fs_config-$f" ] && rm -f "$WORK_DIR/configs/fs_config-$f"
        fi
    done

    if [ -d "$FW_DIR/$FIRMWARE_PATH/system_ext" ]; then
        if $HAS_SYSTEM_EXT; then
            LOG_STEP_IN "- Copying /system_ext from source firmware"

            [ -L "$WORK_DIR/system/system_ext" ] && rm -f "$WORK_DIR/system/system_ext"
            [ -d "$WORK_DIR/system/system/system_ext" ] && rm -rf "$WORK_DIR/system/system/system_ext"

            EVAL "rsync -a --mkpath --delete \"$FW_DIR/$FIRMWARE_PATH/system_ext\" \"$WORK_DIR\"" || exit 1
            mkdir -p "$WORK_DIR/system/system_ext"
            EVAL "ln -sf \"/system_ext\" \"$WORK_DIR/system/system/system_ext\"" || exit 1
            SET_METADATA "system" "system_ext" 0 0 755 "u:object_r:system_file:s0"
            SET_METADATA "system" "system/system_ext" 0 0 644 "u:object_r:system_file:s0"
            EVAL "cp -a \"$FW_DIR/$FIRMWARE_PATH/file_context-system_ext\" \"$WORK_DIR/configs/file_context-system_ext\"" || exit 1
            EVAL "cp -a \"$FW_DIR/$FIRMWARE_PATH/fs_config-system_ext\" \"$WORK_DIR/configs/fs_config-system_ext\"" || exit 1

            LOG_STEP_OUT
        else
            LOG_STEP_IN "- Copying /system/system/system_ext from source firmware"

            [ -d "$WORK_DIR/system/system_ext" ] && rm -rf "$WORK_DIR/system/system_ext"
            [ -L "$WORK_DIR/system/system/system_ext" ] && rm -f "$WORK_DIR/system/system/system_ext"
            [ -d "$WORK_DIR/system_ext" ] && rm -rf "$WORK_DIR/system_ext"
            [ -f "$WORK_DIR/configs/file_context-system_ext" ] && rm -f "$WORK_DIR/configs/file_context-system_ext"
            [ -f "$WORK_DIR/configs/fs_config-system_ext" ] && rm -f "$WORK_DIR/configs/fs_config-system_ext"

            EVAL "rsync -a --mkpath --delete \"$FW_DIR/$FIRMWARE_PATH/system_ext\" \"$WORK_DIR/system/system\"" || exit 1
            EVAL "ln -sf \"/system/system_ext\" \"$WORK_DIR/system/system_ext\"" || exit 1
            SET_METADATA "system" "system_ext" 0 0 644 "u:object_r:system_file:s0"
            sed "s/^\/system_ext/\/system\/system_ext/g" "$FW_DIR/$FIRMWARE_PATH/file_context-system_ext" >> "$WORK_DIR/configs/file_context-system"
            sed "s/^system_ext/system\/system_ext/g" "$FW_DIR/$FIRMWARE_PATH/fs_config-system_ext" >> "$WORK_DIR/configs/fs_config-system"

            DELETE_FROM_WORK_DIR "system" "system/system_ext/etc/NOTICE.xml.gz"
            DELETE_FROM_WORK_DIR "system" "system/system_ext/etc/fs_config_dirs"
            DELETE_FROM_WORK_DIR "system" "system/system_ext/etc/fs_config_files"

            LOG_STEP_OUT
        fi
    elif [ -d "$FW_DIR/$FIRMWARE_PATH/system/system/system_ext" ]; then
        if $HAS_SYSTEM_EXT; then
            LOG_STEP_IN "- Copying /system_ext from source firmware"

            [ -L "$WORK_DIR/system/system_ext" ] && rm -f "$WORK_DIR/system/system_ext"
            [ -d "$WORK_DIR/system/system/system_ext" ] && rm -rf "$WORK_DIR/system/system/system_ext"

            EVAL "rsync -a --mkpath --delete \"$FW_DIR/$FIRMWARE_PATH/system/system/system_ext\" \"$WORK_DIR\"" || exit 1
            mkdir -p "$WORK_DIR/system/system_ext"
            EVAL "ln -sf \"/system_ext\" \"$WORK_DIR/system/system/system_ext\"" || exit 1
            SET_METADATA "system" "system_ext" 0 0 755 "u:object_r:system_file:s0"
            SET_METADATA "system" "system/system_ext" 0 0 644 "u:object_r:system_file:s0"
            grep -F "system/system_ext" "$FW_DIR/$FIRMWARE_PATH/file_context-system" | sed "s/^\/system//" > "$WORK_DIR/configs/file_context-system_ext"
            grep -F "system/system_ext" "$FW_DIR/$FIRMWARE_PATH/fs_config-system" | sed "s/^system\///" > "$WORK_DIR/configs/fs_config-system_ext"

            LOG_STEP_OUT
        else
            LOG_STEP_IN "- Copying /system/system/system_ext from source firmware"

            [ -d "$WORK_DIR/system/system_ext" ] && rm -rf "$WORK_DIR/system/system_ext"
            [ -L "$WORK_DIR/system/system/system_ext" ] && rm -f "$WORK_DIR/system/system/system_ext"
            [ -d "$WORK_DIR/system_ext" ] && rm -rf "$WORK_DIR/system_ext"
            [ -f "$WORK_DIR/configs/file_context-system_ext" ] && rm -f "$WORK_DIR/configs/file_context-system_ext"
            [ -f "$WORK_DIR/configs/fs_config-system_ext" ] && rm -f "$WORK_DIR/configs/fs_config-system_ext"

            EVAL "rsync -a --mkpath --delete \"$FW_DIR/$FIRMWARE_PATH/system/system/system_ext\" \"$WORK_DIR/system/system\"" || exit 1
            EVAL "ln -sf \"/system/system_ext\" \"$WORK_DIR/system/system_ext\"" || exit 1
            grep -F "system_ext" "$FW_DIR/$FIRMWARE_PATH/file_context-system" >> "$WORK_DIR/configs/file_context-system"
            grep -F "system_ext" "$FW_DIR/$FIRMWARE_PATH/fs_config-system" >> "$WORK_DIR/configs/fs_config-system"

            LOG_STEP_OUT
        fi
    fi
}

COPY_KERNEL()
{
    if [ -d "$FW_DIR/$FIRMWARE_PATH/kernel" ]; then
        LOG_STEP_IN "- Copying firmware kernel images"
        EVAL "rsync -a --mkpath --delete \"$FW_DIR/$FIRMWARE_PATH/kernel\" \"$WORK_DIR\"" || exit 1
        $KEEP_ORIGINAL_SIGN || find "$WORK_DIR/kernel" -mindepth 1 -exec "$SRC_DIR/scripts/unsign_bin.sh" {} \;
        LOG_STEP_OUT
    else
        [ -d "$WORK_DIR/kernel" ] && rm -rf "$WORK_DIR/kernel"
    fi

    [ -f "$WORK_DIR/kernel/vbmeta.img" ] && rm -f "$WORK_DIR/kernel/vbmeta.img"
    [ -d "$WORK_DIR/kernel" ] && [ -n "$(find "$WORK_DIR/kernel" -maxdepth 0 -empty)" ] && rm -rf "$WORK_DIR/kernel"
}
# ]

mkdir -p "$WORK_DIR"
mkdir -p "$WORK_DIR/configs"
COPY_FIRMWARE
COPY_KERNEL

exit 0
