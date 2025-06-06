if [[ $DEVICE_PLATFORM == "exynos982x" ]]; then
    echo "Exynos device detected! Adding custom up_param!"
    if [[ $HAS_QHD_DISPLAY == "true" ]]; then
        cp -a "$SRC_DIR/platform/exynos982x/mods/bootlogo/up_param_1440p.bin" "$WORK_DIR/up_param.bin"
    else
        cp -a "$SRC_DIR/platform/exynos982x/mods/bootlogo/up_param_1080p.bin" "$WORK_DIR/up_param.bin"
    fi
else
    echo "Non-Exynos device detected, skipping custom up_param!"
fi
