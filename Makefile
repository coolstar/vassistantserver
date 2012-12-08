include theos/makefiles/common.mk

export GO_EASY_ON_ME=1

TOOL_NAME = VAssistantServer
VAssistantServer_FILES = main.m VAssistantServer.m RegexKitLite.m JSONKit.m  XMLReader.m Plugins/Conversation/*.m Plugins/WordNik/*.m Plugins/Device/*.m Plugins/Calculator/*.m Plugins/GeoCode/*.m Plugins/GeoPlanet/*.m Plugins/Weather/*.m Plugins/DisplayPicture/*.m
VAssistantServer_FRAMEWORKS = Foundation CoreFoundation
VAssistantServer_LDFLAGS = -licucore
VAssistantServer_PRIVATE_FRAMEWORKS = AppSupport MobileTimer
VAssistantServer_CODESIGN_FLAGS="-SEntitlements.plist"

include $(THEOS_MAKE_PATH)/tool.mk
