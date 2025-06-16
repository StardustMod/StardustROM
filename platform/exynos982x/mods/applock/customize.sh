if [ -f "$WORK_DIR/system/system/priv-app/AppLock/AppLock.apk" ]; then
    mv -f "$WORK_DIR/system/system/priv-app/AppLock/AppLock.apk" "$WORK_DIR/system/system/priv-app/AppLock/SAppLock.apk"
    sed -i "s/AppLock.apk/SAppLock.apk/g" "$WORK_DIR/configs/fs_config-system"
    sed -i "s/AppLock\\\.apk/SAppLock\\\.apk/g" "$WORK_DIR/configs/file_context-system"
fi

if [ -d "$WORK_DIR/system/system/priv-app/AppLock" ]; then
    mv -f "$WORK_DIR/system/system/priv-app/AppLock" "$WORK_DIR/system/system/priv-app/SAppLock"
    sed -i "s/priv-app\/AppLock/priv-app\/SAppLock/g" "$WORK_DIR/configs/fs_config-system"
    sed -i "s/priv-app\/AppLock/priv-app\/SAppLock/g" "$WORK_DIR/configs/file_context-system"
fi
