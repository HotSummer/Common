//
//  NetConfigInputProtocol.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-25.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

//数据源代理
#import <Foundation/Foundation.h>

@protocol NetConfigInputProtocol <NSObject>

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
