# Remove Device Care
DELETE_FROM_WORK_DIR "system" "system/priv-app/SmartManager_v5"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.lool.xml"

# Add Smart Manager China
SET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_SMARTMANAGER_CONFIG_PACKAGE_NAME" "com.samsung.android.sm_cn"

cp -a --preserve=all "$SRC_DIR/platform/exynos982x/mods/smartmanager/smali/system/priv-app/SecSettings/SecSettings.apk/res" "$APKTOOL_DIR/system/priv-app/SecSettings/SecSettings.apk/"
