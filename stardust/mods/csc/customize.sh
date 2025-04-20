# SET_CSC_FEATURE_CONFIG "<config>" "<value>"
# Sets the supplied config to the desidered value.
# "-d" or "--delete" can be passed as value to delete the config.

SET_CSC_FEATURE_CONFIG()
{
    local CONFIG="$1"
    local VALUE="$2"

    if grep -q "$CONFIG" "$FILE"; then
        if [[ "$VALUE" == "-d" ]] || [[ "$VALUE" == "--delete" ]]; then
            sed -i "/$CONFIG/d" "$FILE"
        else
            sed -i "/$CONFIG/c\    <$CONFIG>$VALUE<\/$CONFIG>" "$FILE"
        fi
    elif [[ "$VALUE" != "-d" ]] && [[ "$VALUE" != "--delete" ]]; then
        if ! grep -q "Added by " "$FILE"; then
            sed -i "/<\/FeatureSet>/i \    <!-- Added by stardust/mods/csc/customize.sh -->" "$FILE"
        fi
        sed -i "/<\/FeatureSet>/i \    <$CONFIG>$VALUE</$CONFIG>" "$FILE"
    fi

    return 0
}

echo "Patching CSC Features"
while read -r FILE; do
    # Decode XML
    ! grep -q 'CscFeature' "$FILE" && $TOOLS_DIR/bin/omcdecoder --decode --in-place "$FILE"

    # Tweaks
    SET_CSC_FEATURE_CONFIG "CscFeature_VoiceCall_ConfigRecording" "RecordingAllowed"
    SET_CSC_FEATURE_CONFIG "CscFeature_Setting_SupportRealTimeNetworkSpeed" "TRUE"
    SET_CSC_FEATURE_CONFIG "CscFeature_Setting_EnableHwVersionDisplay" "TRUE"
    SET_CSC_FEATURE_CONFIG "CscFeature_Setting_SupportMenuSmartTutor" "FALSE"
    SET_CSC_FEATURE_CONFIG "CscFeature_Common_DisableBixby" --delete

    # Encode XML
    $TOOLS_DIR/bin/omcdecoder --encode --in-place "$FILE"
done <<< "$(find "$WORK_DIR/product" -type f -name "cscfeature.xml")"
