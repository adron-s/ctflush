#запомним исходный путь
ORIG_LOCAL_PATH := $(call my-dir)

#нужно для компиляции libnetfliner_conntrack
TARGET_OUT_INTERMEDIATES := ${ORIG_LOCAL_PATH}

#подключаем модули динамических библиотек
include ./libnfnetlink/Android.mk
include ./libnetfilter_conntrack/Android.mk

#наш модуль
LOCAL_PATH := $(ORIG_LOCAL_PATH)
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := ${ORIG_LOCAL_PATH}/libnetfilter_conntrack/include \
                    ${ORIG_LOCAL_PATH}/libnfnetlink/include
LOCAL_SHARED_LIBRARIES := libnetfilter_conntrack libnfnetlink
#module name
LOCAL_MODULE := ctflush
#src файлы
LOCAL_SRC_FILES := ctflush.c
#борьба с багом линкера unsupported flags DT_FLAGS_1=0x8000001
ifeq ($(APP_ABI),arm64-v8a)
	LOCAL_LDFLAGS += -fuse-ld=gold
endif

#build executable
include $(BUILD_EXECUTABLE)
