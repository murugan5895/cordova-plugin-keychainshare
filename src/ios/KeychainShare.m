#import "KeychainShare.h"

@implementation KeychainShare


- (void)keyAdd:(CDVInvokedUrlCommand*)command
    {
        
        NSString *appIdentifierPrefix =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppIdentifierPrefix"];
        
        NSString *username = [[command arguments] objectAtIndex:0];
        NSString *password = [[command arguments] objectAtIndex:1];
        NSString *keychainAccessGroupName =[NSString stringWithFormat:@"%@KeychainGroup1",appIdentifierPrefix];
        
        NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
        
        NSLog(@"AppIdentifierPrefix- %@ %@", appIdentifierPrefix,keychainAccessGroupName);

        CDVPluginResult* pluginResult = nil;
        
        NSString *msgResult = nil;
        
        NSDictionary *addquery = @{(id)kSecClass:(id)kSecClassGenericPassword,
                                   (id)kSecAttrAccount:username,
                                   (id)kSecValueData:data,
                                   (id)kSecAttrAccessible : (id)kSecAttrAccessibleWhenUnlocked,
                                   (id)kSecAttrAccessGroup : keychainAccessGroupName
                                   };
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)addquery, NULL);
        if (status != errSecSuccess) {
            
            NSLog(@"Error saving to Keychain");
            msgResult=@"Error saving to Keychain";
            [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgResult];
             [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            return;
        }
        
        NSDictionary *getquery = @{ (id)kSecClass: (id)kSecClassGenericPassword,
                                    (id)kSecAttrAccount:username,
                                    (id)kSecReturnData: (id)kCFBooleanTrue,
                                    (id)kSecMatchLimit: (id)kSecMatchLimitOne,
                                    (id)kSecAttrAccessGroup : keychainAccessGroupName
                                    };
        SecKeyRef key = NULL;
        OSStatus status1 = SecItemCopyMatching((__bridge CFDictionaryRef)getquery,
                                               (CFTypeRef *)&key);
        
        
        
        if (status1!=errSecSuccess) {
            msgResult=@"Error";
            NSLog(@"%@",msgResult);
            [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgResult];
        }
        else                       {
            NSData *data =  (__bridge NSData *)key;
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",result);
            msgResult=@"Success";
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgResult];
        }
        
         [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

    - (void)keyFind:(CDVInvokedUrlCommand*)command
    {
        
        NSString *appIdentifierPrefix =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppIdentifierPrefix"];
        
        NSString *username = [[command arguments] objectAtIndex:0];
        NSString *keychainAccessGroupName =[NSString stringWithFormat:@"%@KeychainGroup1",appIdentifierPrefix];

        NSLog(@"AppIdentifierPrefix- %@ %@", appIdentifierPrefix,keychainAccessGroupName);
        
        NSDictionary *getquery = @{ (id)kSecClass: (id)kSecClassGenericPassword,
                                    (id)kSecAttrAccount:username,
                                    (id)kSecReturnData: (id)kCFBooleanTrue,
                                    (id)kSecMatchLimit: (id)kSecMatchLimitOne,
                                    (id)kSecAttrAccessGroup : keychainAccessGroupName
                                    };
        SecKeyRef key = NULL;
        OSStatus status1 = SecItemCopyMatching((__bridge CFDictionaryRef)getquery,
                                               (CFTypeRef *)&key);
        
        CDVPluginResult* pluginResult = nil;
        
        NSString *msgResult = nil;
        
        if (status1!=errSecSuccess) {
            msgResult=@"Not Found";
            NSLog(@"%@",msgResult);
            [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msgResult];
        }
        else                       {
            NSData *data =  (__bridge NSData *)key;
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",result);
            msgResult=@"Success";
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msgResult];
        }
         [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }
    


@end
