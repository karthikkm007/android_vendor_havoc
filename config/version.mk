# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell date +"%s")

HAVOC_BRANCH=oreo

# HAVOC RELEASE VERSION
HAVOC_VERSION_MAJOR = 13
HAVOC_VERSION_MINOR = 1
HAVOC_VERSION_MAINTENANCE =

VERSION := $(HAVOC_VERSION_MAJOR).$(HAVOC_VERSION_MINOR)$(HAVOC_VERSION_MAINTENANCE)

ifndef HAVOC_BUILDTYPE
    ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^HAVOC_||g')
        HAVOC_BUILDTYPE := $(RELEASE_TYPE)
    else
        HAVOC_BUILDTYPE := UNOFFICIAL
    endif
endif

ifdef HAVOC_BUILDTYPE
    ifeq ($(HAVOC_BUILDTYPE), RELEASE)
       HAVOC_VERSION := $(TARGET_PRODUCT)_$(HAVOC_BRANCH)-$(VERSION)-RELEASE-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(HAVOC_BUILDTYPE), NIGHTLY)
        HAVOC_VERSION := $(TARGET_PRODUCT)_$(HAVOC_BRANCH)-$(VERSION)-NIGHTLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(HAVOC_BUILDTYPE), WEEKLY)
        HAVOC_VERSION := $(TARGET_PRODUCT)_$(HAVOC_BRANCH)-$(VERSION)-WEEKLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(HAVOC_BUILDTYPE), EXPERIMENTAL)
        HAVOC_VERSION := $(TARGET_PRODUCT)_$(HAVOC_BRANCH)-$(VERSION)-EXPERIMENTAL-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(HAVOC_BUILDTYPE), UNOFFICIAL)
        HAVOC_VERSION := $(TARGET_PRODUCT)_$(HAVOC_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
    endif
else
#We reset back to UNOFFICIAL
        HAVOC_VERSION := $(TARGET_PRODUCT)_$(HAVOC_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
endif



PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(HAVOC_VERSION) \
    ro.havoc.version=$(VERSION)-$(HAVOC_BUILDTYPE)

# needed for statistics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.havoc.branch=$(HAVOC_BRANCH) \
    ro.romstats.url=http://stats.havoc-rom.com/ \
    ro.romstats.name=havoc \
    ro.romstats.buildtype=$(HAVOC_BUILDTYPE) \
    ro.romstats.version=$(VERSION) \
    ro.romstats.tframe=1 \
    ro.romstats.askfirst=1 \
    ro.romstats.ga=UA-48128535-2

# Camera shutter sound property
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.camera-sound=1
