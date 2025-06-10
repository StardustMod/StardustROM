# Set Build Display ID
SET_PROP "system" "ro.build.display.id" "StardustROM-$ROM_VERSION-$DEVICE_CODENAME-`date +"%Y%m%d"` ($(GET_PROP "system" "ro.build.display.id"))"

# Disable FRP
SET_PROP "vendor" "ro.frp.pst" ""
