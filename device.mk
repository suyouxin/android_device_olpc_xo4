#
# Copyright 2013 The Android Open-Source Project
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

TARGET_KERNEL_SOURCE := kernel
TARGET_KERNEL_CONFIG := xo_4_android_defconfig

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/olpc/xo4-kernel/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

KERNEL_EXTERNAL_MODULES:
	cd vendor/marvell/generic/sd8787/wlan_src; \
	make ARCH="arm" CROSS_COMPILE="arm-linux-gnueabi-" KERNELDIR=$(KERNEL_OUT)
	mv vendor/marvell/generic/sd8787/wlan_src/mlan.ko $(KERNEL_MODULES_OUT)
	mv vendor/marvell/generic/sd8787/wlan_src/sd8xxx.ko $(KERNEL_MODULES_OUT)/sd8787.ko
	cd vendor/marvell/generic/sd8787/mbtc_src; \
	make ARCH="arm" CROSS_COMPILE="arm-linux-gnueabi-" KERNELDIR=$(KERNEL_OUT)
	mv vendor/marvell/generic/sd8787/mbtc_src/mbt8xxx.ko $(KERNEL_MODULES_OUT)

TARGET_KERNEL_MODULES := KERNEL_EXTERNAL_MODULES

# PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel

PRODUCT_CHARACTERISTICS := tablet,nosdcard

$(call inherit-product-if-exists, vendor/olpc/xo4/device-vendor.mk)
