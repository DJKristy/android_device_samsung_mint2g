#
# Copyright (C) 2013 The CyanogenMod Project
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
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

## (2) Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/mint2g/mint2g-vendor.mk)

# Use the Dalvik VM specific for devices with 512 MB of RAM
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# Inherit common aspects of board
$(call inherit-product, device/samsung/sprd-common/common.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/mint2g/overlay

LOCAL_PATH := device/samsung/mint2g

# Softlink sh
$(shell mkdir -p $(LOCAL_PATH)/../../../out/target/product/mint/recovery/root/system/bin)
$(shell ln -sf -t $(LOCAL_PATH)/../../../out/target/product/mint/recovery/root/system/bin ../../sbin/sh)

# Init Files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.sp8810.rc:root/init.sp8810.rc \
    $(LOCAL_PATH)/rootdir/init.sp8810.usb.rc:root/init.sp8810.usb.rc \
    $(LOCAL_PATH)/rootdir/fstab.sp8810:root/fstab.sp8810 \
    $(LOCAL_PATH)/rootdir/fstab.swap:root/fstab.swap \
    $(LOCAL_PATH)/rootdir/init.swap.rc:root/init.swap.rc \
    $(LOCAL_PATH)/rootdir/ueventd.sp8810.rc:root/ueventd.sp8810.rc \
    $(LOCAL_PATH)/rootdir/bin/charge:root/bin/charge \
    $(LOCAL_PATH)/rootdir/modem_control:root/modem_control \
    $(LOCAL_PATH)/rootdir/bin/poweroff_alarm:root/bin/poweroff_alarm \
    $(LOCAL_PATH)/rootdir/bin/vcharged:root/bin/vcharged \
    $(LOCAL_PATH)/rootdir/bin/rawdatad:root/bin/rawdatad

    
# Idc
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc

# Keylayout
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/sprd-keypad.kl:system/usr/keylayout/sprd-keypad.kl

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072 \


# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=180

#Wifi
PRODUCT_PACKAGES += \
	dhcpcd.conf \
	wpa_supplicant \
	hostapd \
	wpa_supplicant.conf
	
# CPUFreq driver by @psych.half

    

# Hw params
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/audio_para:system/etc/audio_para \
     $(LOCAL_PATH)/codec_pga.xml:system/etc/codec_pga.xml\
     $(LOCAL_PATH)/tiny_hw.xml:system/etc/tiny_hw.xml
     
     
# Hw params
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
     $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml



# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false \
    wifi.interface=wlan0 \
    ro.zygote.disable_gl_preload=true \
    persist.msms.phone_count=2 \
    persist.radio.multisim.config=dsds \
    ro.telephony.call_ring.multiple=0 \
    dalvik.vm.heapgrowthlimit=46m \
    dalvik.vm.heapsize=92m \
    ro.telephony.ril_class=SamsungMint2GRIL
    ro.telephony.call_ring=0 


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=adb,mtp \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1

    
# ART device props
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dex2oat-Xms=8m \
	dalvik.vm.dex2oat-Xmx=96m \
	dalvik.vm.dex2oat-flags=--no-watch-dog \
	dalvik.vm.dex2oat-filter=interpret-only \
	dalvik.vm.image-dex2oat-Xms=48m \
	dalvik.vm.image-dex2oat-Xmx=48m \
	dalvik.vm.image-dex2oat-filter=speed
    
# Force use old camera api
PRODUCT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1
    
PRODUCT_TAGS += dalvik.gc.type-precise 


# Boot animation
TARGET_SCREEN_HEIGHT := 320
TARGET_SCREEN_WIDTH := 240
