# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell date +"%s")

Havoc_BRANCH=o

# Havoc RELEASE VERSION
Havoc_VERSION_MAJOR = 13
Havoc_VERSION_MINOR = 1
Havoc_VERSION_MAINTENANCE =

VERSION := $(Havoc_VERSION_MAJOR).$(Havoc_VERSION_MINOR)$(Havoc_VERSION_MAINTENANCE)

ifndef Havoc_BUILDTYPE
    ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^Havoc_||g')
        Havoc_BUILDTYPE := $(RELEASE_TYPE)
    else
        Havoc_BUILDTYPE := UNOFFICIAL
    endif
endif

ifdef Havoc_BUILDTYPE
    ifeq ($(Havoc_BUILDTYPE), RELEASE)
       Havoc_VERSION := $(TARGET_PRODUCT)_$(Havoc_BRANCH)-$(VERSION)-RELEASE-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(Havoc_BUILDTYPE), NIGHTLY)
        Havoc_VERSION := $(TARGET_PRODUCT)_$(Havoc_BRANCH)-$(VERSION)-NIGHTLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(Havoc_BUILDTYPE), WEEKLY)
        Havoc_VERSION := $(TARGET_PRODUCT)_$(Havoc_BRANCH)-$(VERSION)-WEEKLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(Havoc_BUILDTYPE), EXPERIMENTAL)
        Havoc_VERSION := $(TARGET_PRODUCT)_$(Havoc_BRANCH)-$(VERSION)-EXPERIMENTAL-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(Havoc_BUILDTYPE), UNOFFICIAL)
        Havoc_VERSION := $(TARGET_PRODUCT)_$(Havoc_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
    endif
else
#We reset back to UNOFFICIAL
        Havoc_VERSION := $(TARGET_PRODUCT)_$(Havoc_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
endif



PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(Havoc_VERSION) \
    ro.havoc.version=$(VERSION)-$(Havoc_BUILDTYPE)

# needed for statistics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.havoc.branch=$(Havoc_BRANCH) \
    ro.romstats.url=http://stats.havoc-rom.com/ \
    ro.romstats.name=Havoc \
    ro.romstats.buildtype=$(Havoc_BUILDTYPE) \
    ro.romstats.version=$(VERSION) \
    ro.romstats.tframe=1 \
    ro.romstats.askfirst=1 \
    ro.romstats.ga=UA-48128535-2

# Camera shutter sound property
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.camera-sound=1
