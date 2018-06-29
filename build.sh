#!/bin/sh

#ARCH=arm
ARCH=arm64

#for android 7.1.1
API=24

#for android 5.1
#API=22
#CLEAN_DT_ENTRYS="true"

export PATH=/home/prog/android/ndk/android-ndk-r16b:$PATH
export NDK_PROJECT_PATH=.
#собирать только для 32-х битного арма а не для вообще всех возможных
[ ${ARCH} = "arm" ] && APP_ABI=armeabi-v7a
#собирать только для 64-х битного арма а не для вообще всех возможных
[ ${ARCH} = "arm64" ] && APP_ABI=arm64-v8a
BUILD_ARGS="APP_BUILD_SCRIPT=Android.mk APP_PLATFORM=android-$API APP_ABI=$APP_ABI"
ndk-build clean $BUILD_ARGS
ndk-build $BUILD_ARGS

#если при запуске android ругается вот так:
#WARNING: linker: ./test: unused DT entry: type 0x6ffffffe arg 0x438
#WARNING: linker: ./test: unused DT entry: type 0x6fffffff arg 0x1
#включи тут очистку от unused DT entry's
if [ "$CLEAN_DT_ENTRYS" = "true" ]; then
	for ad in $(ls ./libs/); do
		file="./libs/${ad}/mstp_rules_wd"
		[ -f ${file} ] && \
			/home/prog/android/ndk/android-elf-cleaner/android-elf-cleaner ${file}
	done
fi

[ "${1}" = "nc" ] || exit 0
[ -x ./libs/${APP_ABI}/mstp_rules_wd ] && {
	echo "Running nc"
	cat ./libs/${APP_ABI}/mstp_rules_wd | nc -l -p 1111 -q 1
}
