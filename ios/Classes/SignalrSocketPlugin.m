#import "SignalrSocketPlugin.h"
#if __has_include(<signalr_socket/signalr_socket-Swift.h>)
#import <signalr_socket/signalr_socket-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "signalr_socket-Swift.h"
#endif

@implementation SignalrSocketPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSignalrSocketPlugin registerWithRegistrar:registrar];
}
@end
