#import "FlutterUniversaladPlugin.h"
#if __has_include(<flutter_universalad/flutter_universalad-Swift.h>)
#import <flutter_universalad/flutter_universalad-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_universalad-Swift.h"
#endif

@implementation FlutterUniversaladPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUniversaladPlugin registerWithRegistrar:registrar];
}
@end
