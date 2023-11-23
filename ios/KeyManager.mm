#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(KeyManager, NSObject)

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

RCT_EXTERN_METHOD(SetKey:(NSString *)alias withKey:(NSString *)key
                withResolver:(RCTPromiseResolveBlock)resolve
                withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(UpdateKey:(NSString *)alias withKey:(NSString *)key
                withResolver:(RCTPromiseResolveBlock)resolve
                withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(GetKey:(NSString *)alias
                withResolver:(RCTPromiseResolveBlock)resolve
                withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(DeleteKey:(NSString *)alias
                withResolver:(RCTPromiseResolveBlock)resolve
                withRejecter:(RCTPromiseRejectBlock)reject)

@end
