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
source "$SRC_DIR/scripts/utils/common_utils.sh" || exit 1

trap '[ $? -ne 0 ] && rm -f "$OUT_DIR/config.sh"' EXIT

GET_BUILD_VAR()
{
    if [ "$2" ]; then
        if [ ! "${!1}" ]; then
            echo "${1}=\"${2}\""
            return 0
        fi
    else
        _CHECK_NON_EMPTY_PARAM "$1" "${!1}" || exit 1
    fi

    echo "${1}=\"${!1}\""
    return 0
}
# ]

if [ $# -ne 1 ]; then
    echo "Usage: gen_config_file <target>" >&2
    exit 1
elif [ ! -f "$SRC_DIR/target/$1/config.sh" ]; then
    LOGE "File not found: target/$1/config.sh"
    exit 1
else
    source "$SRC_DIR/stardust/config.sh" || exit 1
    source "$SRC_DIR/target/$1/config.sh" || exit 1
fi

if [ -f "$OUT_DIR/config.sh" ]; then
    LOGW "config.sh already exists. Regenerating"
    rm -f "$OUT_DIR/config.sh"
fi

# The following environment variables are considered during execution:
#
#   ROM_VERSION
#     String containing the version name in the format of "x.y.z-xxxxxxxx",
#     it is set in stardust/config.sh.
#
#   ROM_BUILD_TIMESTAMP
#     Integer containing the build timestamp in seconds.
#     Defaults to the current time of execution of the script.
#
#   [SOURCE/TARGET]_FIRMWARE
#     String containing the source/target device firmware to use in the format of "Model number/CSC/IMEI".
#     IMEI number is necessary to fetch the firmware from FUS, alternatively the device serial number can be used.
#
#   [SOURCE/TARGET]_EXTRA_FIRMWARES
#     If defined, this set of extra devices firmwares will be downloaded/extracted when running `download_fw`/`extract_fw`
#     along with the ones set in [SOURCE/TARGET]_FIRMWARE.
#     This variable must be set as a string array in bash syntax, with each string element having the format of "Model number/CSC/IMEI".
#     Please note that due to bash limitations the variable will be stored as a string with each item delimited using ":".
#
#     Example:
#       - Setting the variable: `SOURCE_EXTRA_FIRMWARES=("SM-A528B/BTU/352599501234566" "SM-A528N/KOO/354049881234560")`
#       - Converting back to array: `IFS=":" read -r -a SOURCE_EXTRA_FIRMWARES <<< "$SOURCE_EXTRA_FIRMWARES"`
#
#   TARGET_NAME
#     String containing the target device name, it must match the `SEC_FLOATING_FEATURE_SETTINGS_CONFIG_BRAND_NAME` config.
#     SoC OEM name can be appended in case the device has multiple variants with a different SoC.
#
#     Example:
#       `TARGET_NAME="Galaxy S24 (Exynos)"`
#
#   TARGET_CODENAME
#     String containing the target device codename, it must match the `ro.product.vendor.device` prop.
#
#   TARGET_PLATFORM
#     String containing the target device platform, it must match the `ro.product.board` prop.
#
#   TARGET_ASSERT_MODEL
#     If defined, the zip package will use the provided model numbers with the value in the `ro.boot.em.model` prop
#     to ensure if it is compatible with the device it is currently being installed in, by default TARGET_CODENAME
#     is checked instead.
#
#     Example:
#       `TARGET_ASSERT_MODEL=("SM-A528B" "SM-A528N")`
#
#   TARGET_OS_FILE_SYSTEM
#     String containing the target device firmware file system.
#     Using a value different than stock will require patching the device fstab file in vendor and kernel ramdisk.
#
#   TARGET_BOOT_DEVICE_PATH
#     String containing the path to the target device folder containing its block devices.
#     Defaults to "/dev/block/bootdevice/by-name".
#
#   TARGET_KEEP_ORIGINAL_SIGN
#     If set to true, the original AVB/Samsung signature footer is kept in the target device kernel images.
#     Defaults to false.
#
#   TARGET_SUPER_PARTITION_SIZE
#     Integer containing the size in bytes of the target device super partition size, which can be checked using the lpdump tool.
#     Notice this must be bigger than TARGET_SUPER_GROUP_SIZE.
#
#   [SOURCE/TARGET]_SUPER_GROUP_NAME
#     String containing the super partition group name the device uses.
#     When TARGET_SUPER_GROUP_NAME is not set, the value in SOURCE_SUPER_GROUP_NAME is used by default.
#
#   TARGET_SUPER_GROUP_SIZE
#     Integer containing the size in bytes of the target device super group size, which can be checked using the lpdump tool.
#     Notice this must be smaller than TARGET_SUPER_PARTITION_SIZE.
#
#   [SOURCE/TARGET]_HAS_SYSTEM_EXT
#     Boolean which describes whether the device has a separate system_ext partition.
#
#   [SOURCE/TARGET]_HAS_QHD_DISPLAY
#     Boolean which describes whether the device has a WQHD(+) display.
#     It can be checked in the following ways:
#       - `FW_DYNAMIC_RESOLUTION_CONTROL` in the `com.samsung.android.rune.CoreRune` class inside `framework.jar` is set to true
#       - "SEC_FLOATING_FEATURE_COMMON_CONFIG_DYN_RESOLUTION_CONTROL" in floating_feature.xml is set
{
    echo "# Automatically generated by scripts/internal/gen_config_file.sh"
    GET_BUILD_VAR "ROM_VERSION"
    GET_BUILD_VAR "ROM_BUILD_TIMESTAMP" "$(date +%s)"
    GET_BUILD_VAR "SOURCE_FIRMWARE"
    if [ "${#SOURCE_EXTRA_FIRMWARES[@]}" -ge 1 ]; then
        echo "SOURCE_EXTRA_FIRMWARES=\"$(IFS=":"; printf '%s' "${SOURCE_EXTRA_FIRMWARES[*]}")\""
    else
        echo "SOURCE_EXTRA_FIRMWARES=\"\""
    fi
    GET_BUILD_VAR "TARGET_NAME"
    GET_BUILD_VAR "TARGET_CODENAME"
    GET_BUILD_VAR "TARGET_PLATFORM"
    if [ "${#TARGET_ASSERT_MODEL[@]}" -ge 1 ]; then
        echo "TARGET_ASSERT_MODEL=\"$(IFS=":"; printf '%s' "${TARGET_ASSERT_MODEL[*]}")\""
    else
        echo "TARGET_ASSERT_MODEL=\"\""
    fi
    GET_BUILD_VAR "TARGET_FIRMWARE"
    if [ "${#TARGET_EXTRA_FIRMWARES[@]}" -ge 1 ]; then
        echo "TARGET_EXTRA_FIRMWARES=\"$(IFS=":"; printf '%s' "${TARGET_EXTRA_FIRMWARES[*]}")\""
    else
        echo "TARGET_EXTRA_FIRMWARES=\"\""
    fi
    GET_BUILD_VAR "TARGET_OS_FILE_SYSTEM"
    GET_BUILD_VAR "TARGET_BOOT_DEVICE_PATH" "/dev/block/bootdevice/by-name"
    GET_BUILD_VAR "TARGET_KEEP_ORIGINAL_SIGN" "false"
    GET_BUILD_VAR "TARGET_SUPER_PARTITION_SIZE"
    GET_BUILD_VAR "SOURCE_SUPER_GROUP_NAME"
    GET_BUILD_VAR "TARGET_SUPER_GROUP_NAME" "$SOURCE_SUPER_GROUP_NAME"
    GET_BUILD_VAR "TARGET_SUPER_GROUP_SIZE"
    GET_BUILD_VAR "SOURCE_HAS_SYSTEM_EXT"
    GET_BUILD_VAR "TARGET_HAS_SYSTEM_EXT"
    GET_BUILD_VAR "SOURCE_HAS_QHD_DISPLAY"
    GET_BUILD_VAR "TARGET_HAS_QHD_DISPLAY"
} > "$OUT_DIR/config.sh"

exit 0
