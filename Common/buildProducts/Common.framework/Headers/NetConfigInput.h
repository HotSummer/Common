//
//  NetConfigInput.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigInputProtocol.h"

/*
 给默认的数据源()提供数据
 */
@interface NetConfigInput : NSObject<NetConfigInputProtocol>

+ (NetConfigInput *)shareInstance;

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
- (NSString *)timestamp;
- (NSString *)vipChannel;
- (NSDictionary *)dicSign;
- (NSDictionary *)dicHeaderSign;

@end
