#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      [GMSServices provideAPIKey:@"AIzaSyDU4k-7hp3JVM4J5w2O8tsJfe7JX3WC-cA"];

  [GeneratedPluginRegistrant registerWithRegistry:self];

  // Add the following line, with your API key
    [GMSServices provideAPIKey: @"AIzaSyDU4k-7hp3JVM4J5w2O8tsJfe7JX3WC-cA"];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
