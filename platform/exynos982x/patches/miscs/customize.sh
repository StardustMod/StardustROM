# Set to Release Keys
SET_PROP "system" "ro.build.keys" "release-keys"
sed -i 's/"test"/"release"/' $WORK_DIR/system/system/etc/ramdisk/build.prop
