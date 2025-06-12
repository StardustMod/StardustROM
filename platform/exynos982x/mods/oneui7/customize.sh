# Remove *.prof Files
DELETE_FROM_WORK_DIR "system" "system/app/Weather_SEP12.0/Weather_SEP12.0.apk.prof"
DELETE_FROM_WORK_DIR "system" "system/priv-app/Finder/Finder.apk.prof"
DELETE_FROM_WORK_DIR "system" "system/priv-app/SamsungContacts/SamsungContacts.apk.prof"
DELETE_FROM_WORK_DIR "system" "system/priv-app/SamsungDialer/SamsungDialer.apk.prof"
DELETE_FROM_WORK_DIR "system" "system/priv-app/SamsungGallery2018/SamsungGallery2018.apk.prof"
DELETE_FROM_WORK_DIR "system" "system/priv-app/SamsungMessages/SamsungMessages.apk.prof"

# Replace Apps Resources
DECODE_APK "system" "system/app/ClockPackage/ClockPackage.apk"
cp -a --preserve=all "$SRC_DIR/platform/exynos982x/mods/oneui7/smali/system/app/ClockPackage/ClockPackage.apk" "$APKTOOL_DIR/system/app/ClockPackage/"
DECODE_APK "system" "system/priv-app/SamsungCamera/SamsungCamera.apk"
cp -a --preserve=all "$SRC_DIR/platform/exynos982x/mods/oneui7/smali/system/priv-app/SamsungCamera/SamsungCamera.apk" "$APKTOOL_DIR/system/priv-app/SamsungCamera/"
DECODE_APK "system" "system/priv-app/SecSettings/SecSettings.apk"
cp -a --preserve=all "$SRC_DIR/platform/exynos982x/mods/oneui7/smali/system/priv-app/SecSettings/SecSettings.apk/res" "$APKTOOL_DIR/system/priv-app/SecSettings/SecSettings.apk/"
DECODE_APK "system" "system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk"
cp -a --preserve=all "$SRC_DIR/platform/exynos982x/mods/oneui7/smali/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk/res" "$APKTOOL_DIR/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk/"
