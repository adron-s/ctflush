Conntrack flushing tool for Android

libnetfilter_conntrack и libnfnetlink взяты из исходников cm14:
	/media/adron/26dd444b-d271-4c43-ba78-0e5324288650/prog/android/cm14/external
единственная модицикация у этих двух либ это в их Android.mk файлах
строчка include $(BUILD_SHARED_LIBRARY) заменена на include $(BUILD_STATIC_LIBRARY)
чтобы либы собрались как static.
все остальные настройки достигаются объявлением в нашем Android.mk файле нужных переменных и симлинками:
	симлинки KERNEL_OBJ и external нужны для эмуляции среды сборки cm14

Поистине сборочная система Android SDK это чудо. Раньше я собирал ctflush на Orange Pi Zero в его дебиане!
И это был только 32-х битный билд. Для 64-х битного я и начал разбираться с NDK!
