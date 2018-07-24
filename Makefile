DEBUG=1
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ApolloOpener
ApolloOpener_FILES = XXXApolloOpener.m
ApolloOpener_INSTALL_PATH = /Library/Opener
ApolloOpener_EXTRA_FRAMEWORKS = Opener

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
