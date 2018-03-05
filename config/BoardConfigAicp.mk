# Charger
ifeq ($(WITH_Havoc_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.havoc
endif
