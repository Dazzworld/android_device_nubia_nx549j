LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE        := NubiaCamera
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := APPS
LOCAL_MODULE_OWNER  := nubia
LOCAL_MODULE_SUFFIX := .apk
LOCAL_SRC_FILES     := NubiaCamera.apk
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true

#PRODUCT_COPY_FILES += \
#    $(call find-copy-subdir-files,*.so,$(LOCAL_PATH)/lib/arm64-v8a,$(TARGET_OUT_APPS)/$(LOCAL_MODULE)/lib/arm64)

copy_files := $(subst $(LOCAL_PATH)/,, \
	$(filter-out %.mk,\
	$(patsubst ./%,%, \
	$(shell find $(LOCAL_PATH)/lib/arm64-v8a -type f -name "*" -and -not -name ".*"  -exec basename {} \; | sort) \
	)))

AV_LIBS := libnubia_delay_recorder.so
AV_SYMLINKS := $(addprefix $(TARGET_OUT_APPS_PRIVILEGED)/$(LOCAL_MODULE)/lib/arm64/,$(notdir $(AV_LIBS)))

$(AV_SYMLINKS):
	@mkdir -p $(dir $@)
	ln -sf /system/lib64/$(notdir $@) $@

AV_LIBS := libnubia_delay_recorder.so

LOCAL_ADDITIONAL_DEPENDENCIES := $(AV_SYMLINKS)

$(foreach file,$(copy_files),\
$(shell cp $(LOCAL_PATH)/lib/arm64-v8a/$(file) $(TARGET_OUT_APPS_PRIVILEGED)/$(LOCAL_MODULE)/lib/arm64/$(file)))

include $(BUILD_PREBUILT)



#PRODUCT_COPY_FILES += $(foreach file,$(copy_files),\
#    $(LOCAL_PATH)/$(file):$(TARGET_OUT_APPS)/$(LOCAL_MODULE)/lib/arm64/$(file))
