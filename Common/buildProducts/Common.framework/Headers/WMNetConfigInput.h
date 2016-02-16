//
//  WMNetConfigInput.h
//  NetConfigRequest
//
//  Created by summer.zhu on 4/2/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigInputProtocol.h"

@interface WMNetConfigInput : NSObject<NetConfigInputProtocol>

+ (WMNetConfigInput *)shareInstance;

- (NSString *)urlHttp;
- (NSString *)urlHttps;
- (NSString *)userToken;
- (NSString *)userSecret;
- (NSString *)userId;
- (NSString *)apiKey;
- (NSString *)apiSecrect;
- (NSString *)source;
- (NSString *)appName;
- (NSString *)appVersion;
- (NSString *)warehouse;
- (NSString *)vipChannel;
- (NSString *)timestamp;
- (NSDictionary *)dicHeaderSign;
- (NSDictionary *)dicSign;

@end
