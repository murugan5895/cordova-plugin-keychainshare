#import <Cordova/CDV.h>

@interface KeychainShare : CDVPlugin

- (void) keyAdd:(CDVInvokedUrlCommand*)command;
- (void) keyFind:(CDVInvokedUrlCommand*)command;

@end