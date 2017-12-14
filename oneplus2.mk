# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Include vendor/vertex configuration
include vendor/vertex/main.mk

DEVICE_PACKAGE_OVERLAYS := device/oneplus/oneplus2/overlay

ifneq ($(TARGET_USES_AOSP),true)
TARGET_USES_NQ_NFC := false
TARGET_USES_QCOM_BSP := true
endif
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

# copy customized media_profiles and media_codecs xmls for 8994
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/oneplus/oneplus2/media/media_profiles.xml:system/etc/media_profiles.xml \
                      device/oneplus/oneplus2/media/media_codecs.xml:system/etc/media_codecs.xml \
                      device/oneplus/oneplus2/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

PRODUCT_COPY_FILES += device/oneplus/oneplus2/whitelistedapps.xml:system/etc/whitelistedapps.xml

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/qcom/common/common64.mk)
#msm8996 platform WLAN Chipset
WLAN_CHIPSET := qca_cld

PRODUCT_NAME := oneplus2
PRODUCT_DEVICE := oneplus2
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := VertexOS for OnePlus 2

PRODUCT_BOOT_JARS += tcmiface
# This jar is needed for MSIM manual provisioning and for other
# telephony related functionalities to work.
PRODUCT_BOOT_JARS += telephony-ext

PRODUCT_PACKAGES += telephony-ext


ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += qcom.fmradio
PRODUCT_BOOT_JARS += WfdCommon
#PRODUCT_BOOT_JARS += extendedmediaextractor
#PRODUCT_BOOT_JARS += security-bridge
#PRODUCT_BOOT_JARS += qsb-port
PRODUCT_BOOT_JARS += oem-services
#PRODUCT_BOOT_JARS += com.qti.dpmframework
#PRODUCT_BOOT_JARS += dpmapi
#PRODUCT_BOOT_JARS += com.qti.location.sdk
endif

# add vendor manifest file
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus2/vintf.xml:system/vendor/manifest.xml

#PRODUCT_BOOT_JARS += qcmediaplayer

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8994/msm8994.mk

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus2/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/oneplus/oneplus2/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/oneplus/oneplus2/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin \
    device/oneplus/oneplus2/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/oneplus/oneplus2/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    device/oneplus/oneplus2/wifi/hostapd.conf:system/etc/hostapd/hostapd_default.conf \
    device/oneplus/oneplus2/wifi/hostapd.accept:system/etc/hostapd/hostapd.accept \
    device/oneplus/oneplus2/wifi/hostapd.deny:system/etc/hostapd/hostapd.deny

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_PACKAGES += \
    wpa_supplicant \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf


ifneq ($(WLAN_CHIPSET),)
PRODUCT_PACKAGES += $(WLAN_CHIPSET)_wlan.ko
endif

# Gralloc
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl

# HW Composer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus2/sensors/hals.conf:system/etc/sensors/hals.conf

# Sensor features
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus2/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml \


# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

#dm-verity Config
#PRODUCT_SUPPORTS_VERITY := true
#PRODUCT_SYSTEM_VERITY_PARTITION :=  /dev/block/bootdevice/by-name/system

PRODUCT_AAPT_CONFIG += xlarge large

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(PRODUCT_PACKAGE_OVERLAYS)

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files
