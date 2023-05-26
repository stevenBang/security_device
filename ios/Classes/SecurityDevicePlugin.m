#import "SecurityDevicePlugin.h"
#if __has_include(<security_device/security_device-Swift.h>)
    #import <security_device/security_device-Swift.h>
#else
    // Support project import fallback if the generated compatibility header
    // is not copied when this plugin is created as a library.
    // https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
    #import "security_device-Swift.h"
#endif

@implementation SecurityDevicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSecurityDevicePlugin registerWithRegistrar:registrar];
}
@end