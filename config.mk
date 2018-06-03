### Build Configuration ###

# Default variables
GAME_VERSION ?= GOLD
DEBUG        ?= 1
COMPARE      ?= 1

# For now, only support building Gold Debug.
# Uncomment these to support other ROMs.

## Version
#ifeq ($(GAME_VERSION), GOLD)
	BUILD_NAME := gold
#else
#ifeq ($(GAME_VERSION), SILVER)
#	BUILD_NAME := silver
#else
#	$(error unknown version $(GAME_VERSION))
#endif
#endif
#
## Debug
#ifeq ($(DEBUG), 1)
#	BUILD_NAME := $(BUILD_NAME)_debug
#endif
