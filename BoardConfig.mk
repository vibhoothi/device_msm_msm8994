# config.mk
#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := msm8994
TARGET_BOOTLOADER_BOARD_NAME := msm8994

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
ifneq ($(TARGET_USES_AOSP), true)
TARGET_2ND_CPU_VARIANT := cortex-a53
else
TARGET_2ND_CPU_VARIANT := cortex-a9
endif

TARGET_CPU_CORTEX_A53 := true

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_NO_BOOTLOADER := true
BOOTLOADER_GCC_VERSION := arm-eabi-4.8
BOOTLOADER_PLATFORM := msm8994 # use msm8994 LK configuration
TARGET_NO_KERNEL := false
TARGET_KERNEL_APPEND_DTB := true
include device/msm/msm8994/BoardConfigVendor.mk

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/qcom/common

USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true

VENDOR_EDIT := yes
WITH_DEXPREOPT := false
COMMON_GLOBAL_CFLAGS := $(COMMON_GLOBAL_CFLAGS) -DVENDOR_EDIT
COMMON_GLOBAL_CPPFLAGS := $(COMMON_GLOBAL_CPPFLAGS) -DVENDOR_EDIT
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
#TARGET_USES_OVERLAY := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 2048
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true


BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 boot_cpus=0-5

BOARD_EGL_CFG := device/qcom/$(TARGET_BOARD_PLATFORM)/egl.cfg
#BOARD_KERNEL_SEPARATED_DT := false

BOARD_SECCOMP_POLICY := device/qcom/$(TARGET_BOARD_PLATFORM)/seccomp

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_USES_UNCOMPRESSED_KERNEL := false
TARGET_COMPILE_WITH_MSM_KERNEL := true

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

BOARD_USES_GENERIC_AUDIO := true
TARGET_NO_RPC := true

USE_CLANG_PLATFORM_BUILD := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

#Add NON-HLOS files for ota upgrade
ADD_RADIO_FILES := true
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_msm

# Force camera module to be compiled only in 32-bit mode on 64-bit systems
# Once camera module can run in the native mode of the system (either
# 32-bit or 64-bit), the following line should be deleted
BOARD_QTI_CAMERA_32BIT_ONLY := true

# Added to indicate that protobuf-c is supported in this build
PROTOBUF_SUPPORTED := false

#Enable HW based full disk encryption
TARGET_HW_DISK_ENCRYPTION := false

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
  ifeq ($(WITH_DEXPREOPT),)
    WITH_DEXPREOPT := true
    WITH_DEXPREOPT_PIC := true
    ifneq ($(TARGET_BUILD_VARIANT),user)
      # Retain classes.dex in APK's for non-user builds
      DEX_PREOPT_DEFAULT := nostripping
    endif
  endif
endif

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

BOARD_HAL_STATIC_LIBRARIES := libhealthd.msm

TARGET_USES_IMS := true
