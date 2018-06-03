### Build Configuration ###

# Default variables
GAME_VERSION ?= GOLD
DEBUG        ?= 0
COMPARE      ?= 0

# Version
ifeq ($(GAME_VERSION), GOLD)
	BUILD_NAME := gold
else
ifeq ($(GAME_VERSION), SILVER)
	BUILD_NAME := silver
else
	$(error unknown version $(GAME_VERSION))
endif
endif

# Debug
ifeq ($(DEBUG), 1)
	BUILD_NAME := $(BUILD_NAME)_debug
endif
