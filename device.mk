#
# Copyright (C) 2012 The Android Open-Source Project
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

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/google/steelhead/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel \
	device/google/steelhead/init.steelhead.rc:root/init.steelhead.rc \
	device/google/steelhead/init.steelhead.usb.rc:root/init.steelhead.usb.rc \
        device/google/steelhead/fstab.steelhead:root/fstab.steelhead \
	device/google/steelhead/ueventd.steelhead.rc:root/ueventd.steelhead.rc \
	device/google/steelhead/media_profiles.xml:system/etc/media_profiles.xml \
	device/google/steelhead/media_codecs.xml:system/etc/media_codecs.xml \
	device/google/steelhead/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

PRODUCT_PACKAGES := \
        make_ext4fs \
	com.android.future.usb.accessory

PRODUCT_PROPERTY_OVERRIDES := \
	wifi.interface=wlan0 \
	hwui.render_dirty_regions=false

PRODUCT_CHARACTERISTICS := tablet,nosdcard

DEVICE_PACKAGE_OVERLAYS := \
    device/google/steelhead/overlay

#HWC Hal
#PRODUCT_PACKAGES += \
#    hwcomposer.omap4

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# Audio
PRODUCT_PACKAGES += \
	audio.primary.steelhead \
	audio.a2dp.default

PRODUCT_COPY_FILES += \
	device/google/steelhead/audio/audio_policy.conf:system/etc/audio_policy.conf

PRODUCT_PACKAGES += \
	dhcpcd.conf \
	TQS_D_1.7.ini \
	calibrator

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs

# BlueZ test tools
PRODUCT_PACKAGES += \
	hciconfig \
	hcitool

PRODUCT_PACKAGES += send_bug
PRODUCT_COPY_FILES += \
	system/extras/bugmailer/bugmailer.sh:system/bin/bugmailer.sh \
	system/extras/bugmailer/send_bug:system/bin/send_bug

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160

$(call inherit-product-if-exists, vendor/google/steelhead/device-vendor.mk)
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
$(call inherit-product, hardware/ti/omap4xxx/omap4.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/ti-omap4-vendor.mk)
$(call inherit-product-if-exists, vendor/ti/proprietary/omap4/ti-omap4-vendor.mk)
DUCATI_TGZ := device/google/steelhead/ducati_steelhead.tgz
PRODUCT_PACKAGES += ducati-m3.bin
