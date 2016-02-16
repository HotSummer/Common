//
//  WMNetConfigInput.m
//  NetConfigRequest
//
//  Created by summer.zhu on 4/2/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "WMNetConfigInput.h"

#define API_ROOT                        @"http://weimei-api.vip.com/"

//生产环境开关
//#define PRODUCT_ENVIRONMENT_SWITCH

#ifndef PRODUCT_ENVIRONMENT_SWITCH

//开发测试环境
//登陆Url
#define SESSION_URL                     @"http://weimei-sapi.vip.com/"
#define API_KEY                         @"f612a68e01194a17b1a4f3ed0e4dd923"
#define API_SCERET                      @"4198c6b75f36417cacdd5cd2b77cebec"
#define API_PAY_SERVERAPPNAME           @"vsmei_iphone"

#else

//生产环境
//登陆Url
#define SESSION_URL                     @"https://weimei-sapi.vip.com/"
#define API_KEY                         @"616df486d5334f4d8df8e9a4a7490082"
#define API_SCERET                      @"4b8512ad7481409c9831cdf528822d5b"
#define API_PAY_SERVERAPPNAME           @"weimei_iphone"

#endif

@implementation WMNetConfigInput

+ (WMNetConfigInput *)shareInstance{
    static WMNetConfigInput *netConfigInput = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        netConfigInput = [[WMNetConfigInput alloc] init];
    });
    return netConfigInput;
}

- (NSString *)urlHttp{
    return API_ROOT;
}

- (NSString *)urlHttps{
    return SESSION_URL;
}

- (NSString *)userToken{
    return @"D29416097E5DBCFE595A6198937F80888E42A33C";
}

- (NSString *)userSecret{
    return @"c15d48dc70184e3a6a977f91aaa81a07";
}

- (NSString *)userId{
    return @"";
}

- (NSString *)apiKey{
    return API_KEY;
}

- (NSString *)apiSecrect{
    return API_SCERET;
}

- (NSString *)source{
    return @"weimei_iphone";
}

- (NSString *)appName{
    return @"vsmei_iphone";
}

- (NSString *)appVersion{
    return @"1.0.0";
}

- (NSString *)warehouse{
    return @"VIP_SH";
}

- (NSString *)vipChannel{
    return @"te";
}

- (NSString *)timestamp{
    NSInteger inteval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",(long)inteval];
}

- (NSDictionary *)dicHeaderSign{
    return @{@"apiKey":self.apiKey, @"appName":self.appName, @"appVersion":self.appVersion, @"timestamp":self.timestamp, @"userToken":self.userToken, @"userSecret":self.userSecret, @"apiSecrect":self.apiSecrect};
}

- (NSDictionary *)dicSign{
    return nil;
}

@end
