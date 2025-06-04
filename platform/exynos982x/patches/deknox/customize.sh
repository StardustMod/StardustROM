# KnoxGuard
DELETE_FROM_WORK_DIR "system" "system/priv-app/KnoxGuard"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.kgclient.xml"

# DualDAR
DELETE_FROM_WORK_DIR "system" "system/bin/dualdard"
DELETE_FROM_WORK_DIR "system" "system/etc/init/dualdard.rc"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libdualdar.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/hidl_comm_ddar_client.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.tlc.ddar@1.0.so"

# Blockchain
DELETE_FROM_WORK_DIR "system" "system/app/BlockchainBasicKit"

# Payment
# DELETE_FROM_WORK_DIR "system" "system/lib64/hidl_tlc_payment_comm_client.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libtlc_payment_direct_comm.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libtlc_payment_spay.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libtlc_payment_comm.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.tlc.payment@1.0.so"

# MPOS
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.samsung.android.nfc.mpos.xml"
DELETE_FROM_WORK_DIR "system" "system/framework/com.samsung.android.nfc.mpos.jar"

# eSE COS
DELETE_FROM_WORK_DIR "system" "system/bin/sem_daemon"
#DELETE_FROM_WORK_DIR "system" "system/lib64/libsec_sem.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libsec_semRil.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/libsec_semTlc.so"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libspictrl.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.sem@1.0.so"
DELETE_FROM_WORK_DIR "system" "system/priv-app/SEMFactoryApp"

# HDM
DELETE_FROM_WORK_DIR "system" "system/priv-app/HdmApk"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.hdmapp.xml"

# Secure Folder
DELETE_FROM_WORK_DIR "system" "system/priv-app/SecureFolder"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.knox.securefolder.xml"

# WSM
# DELETE_FROM_WORK_DIR "system" "system/etc/public.libraries-wsm.samsung.txt"
# DELETE_FROM_WORK_DIR "system" "system/lib64/libhal.wsm.samsung.so"

# Other Knox APKs
DELETE_FROM_WORK_DIR "system" "system/priv-app/KPECore"
DELETE_FROM_WORK_DIR "system" "system/priv-app/KnoxAIFrameworkApp"
DELETE_FROM_WORK_DIR "system" "system/priv-app/KnoxCore"
DELETE_FROM_WORK_DIR "system" "system/priv-app/KnoxPushManager"
DELETE_FROM_WORK_DIR "system" "system/priv-app/knoxanalyticsagent"
DELETE_FROM_WORK_DIR "system" "system/priv-app/knoxvpnproxyhandler"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.knox.vpn.proxyhandler.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.knox.analytics.uploader.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.knox.attestation.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.knox.containeragent.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.knox.containercore.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/privapp-permissions-com.samsung.android.knox.pushmanager.xml"
