LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	BatteryService.cpp \
	CorrectedGyroSensor.cpp \
    Fusion.cpp \
    GravitySensor.cpp \
    LinearAccelerationSensor.cpp \
    OrientationSensor.cpp \
    RotationVectorSensor.cpp \
    SensorDevice.cpp \
    SensorFusion.cpp \
    SensorInterface.cpp \
    SensorService.cpp

# Legacy virtual sensors used in combination from accelerometer & magnetometer.
LOCAL_SRC_FILES += \
	legacy/SecondOrderLowPassFilter.cpp \
	legacy/LegacyGravitySensor.cpp \
	legacy/LegacyLinearAccelerationSensor.cpp \
	legacy/LegacyRotationVectorSensor.cpp

LOCAL_CFLAGS:= -DLOG_TAG=\"SensorService\"

LOCAL_CFLAGS += -fvisibility=hidden

LOCAL_SHARED_LIBRARIES := \
	libcutils \
	libhardware \
	libhardware_legacy \
	libutils \
	liblog \
	libbinder \
	libui \
	libgui

ifneq ($(BOARD_USE_LEGACY_SENSORS_FUSION),false)
    LOCAL_CFLAGS += -DUSE_LEGACY_SENSORS_FUSION
endif

LOCAL_MODULE:= libsensorservice

include $(BUILD_SHARED_LIBRARY)

#####################################################################
# build executable
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	main_sensorservice.cpp

LOCAL_SHARED_LIBRARIES := \
	libsensorservice \
	libbinder \
	libutils

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE:= sensorservice

include $(BUILD_EXECUTABLE)
