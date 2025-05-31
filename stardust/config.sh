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

# Configuration file for StardustROM
ROM_VERSION="v1.0"
ROM_VERSION+="-$(git rev-parse --short HEAD)"

# Source ROM firmware
case "$1" in
    "beyond0lte")
        # Galaxy S10e
        DEVICE_NAME="Galaxy S10e (Exynos)"
        DEVICE_MODEL=("SM-G970F")
        FIRMWARE="SM-G970F/BTU/351585114819407"
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyond0lteks")
        # Galaxy S10e (Korean)
        DEVICE_NAME="Galaxy S10e Korean (Exynos)"
        DEVICE_MODEL=("SM-G970N")
        FIRMWARE="SM-G970N/KOO/352599100901524"
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyond1lte")
        # Galaxy S10
        DEVICE_NAME="Galaxy S10 (Exynos)"
        DEVICE_MODEL=("SM-G973F")
        FIRMWARE="SM-G973F/BTU/356127103241981"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyond1lteks")
        # Galaxy S10 (Korean)
        DEVICE_NAME="Galaxy S10 Korean (Exynos)"
        DEVICE_MODEL=("SM-G973N")
        FIRMWARE="SM-G973N/KOO/354552101246447"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyond2lte")
        # Galaxy S10+
        DEVICE_NAME="Galaxy S10+ (Exynos)"
        DEVICE_MODEL=("SM-G975F")
        FIRMWARE="SM-G975F/BTU/356262101234561"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyond2lteks")
        # Galaxy S10+ (Korean)
        DEVICE_NAME="Galaxy S10+ Korean (Exynos)"
        DEVICE_MODEL=("SM-G975N")
        FIRMWARE="SM-G975N/KOO/352675100520660"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyondx")
        # Galaxy S10+
        DEVICE_NAME="Galaxy S10 5G (Exynos)"
        DEVICE_MODEL=("SM-G977F")
        FIRMWARE="SM-G977F/BTU/356151100345173"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "beyondxks")
        # Galaxy S10+ (Korean)
        DEVICE_NAME="Galaxy S10 5G Korean (Exynos)"
        DEVICE_MODEL=("SM-G977N")
        FIRMWARE="SM-G977N/KOO/355006100130671"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "d1")
        # Galaxy Note10
        DEVICE_NAME="Galaxy Note10 (Exynos)"
        DEVICE_MODEL=("SM-N970F")
        FIRMWARE="SM-N970F/BTU/359013100001650"
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "d1xks")
        # Galaxy Note10 5G (Korean)
        DEVICE_NAME="Galaxy Note10 5G Korean (Exynos)"
        DEVICE_MODEL=("SM-N971N")
        FIRMWARE="SM-N971N/KOO/358777104947420"
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "d2s")
        # Galaxy Note10+
        DEVICE_NAME="Galaxy Note10+ (Exynos)"
        DEVICE_MODEL=("SM-N975F")
        FIRMWARE="SM-N975F/BTU/358780109886445"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "d2x")
        # Galaxy Note10+ 5G
        DEVICE_NAME="Galaxy Note10+ 5G (Exynos)"
        DEVICE_MODEL=("SM-N976B")
        FIRMWARE="SM-N976B/BTU/358782101711779"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    "d2xks")
        # Galaxy Note10+ 5G (Korean)
        DEVICE_NAME="Galaxy Note10+ 5G Korean (Exynos)"
        DEVICE_MODEL=("SM-N976N")
        FIRMWARE="SM-N976N/KOO/358592108973789"
        HAS_QHD_DISPLAY=true
        DEVICE_PLATFORM="exynos982x"
        BOOT_DEVICE_PATH="/dev/block/platform/13d60000.ufs/by-name"
        ;;
    *)
        LOGE "\"$1\" is not a valid model"
        return 1
        ;;
esac

# Universal configuration
EXTRA_FIRMWARES=()
OS_FILE_SYSTEM="ext4"
SUPER_PARTITION_SIZE=0
HAS_SYSTEM_EXT=false
SUPER_GROUP_NAME="none"
SUPER_GROUP_SIZE=0
