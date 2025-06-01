# https://github.com/3arthur6/BluetoothLibraryPatcher/blob/425bb59da6505c962a38c143137698849b01d470/hexpatch.sh#L12
HEX_PATCH "$WORK_DIR/system/system/lib64/libbluetooth.so" \
    "........f9031f2af3031f2a41" "1f2003d5f9031f2af3031f2a48"
