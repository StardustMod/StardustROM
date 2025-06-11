# Set Build Display ID
SET_PROP "system" "ro.build.display.id" "StardustROM-$ROM_VERSION-$DEVICE_CODENAME-`date +"%Y%m%d"` ($(GET_PROP "system" "ro.build.display.id"))"

# Disable FRP
SET_PROP "vendor" "ro.frp.pst" ""

# Use GPU Composition
SET_PROP "system" "debug.composition.type" "gpu"

# Disable OEM Unlock Toggle
SET_PROP "system" "ro.oem_unlock_supported" "0"

# Set ROM Version
SET_PROP "system" "ro.build.version.stardust" "$ROM_VERSION"
