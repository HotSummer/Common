//
//  NetConfigInput.m
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "NetConfigInput.h"

@implementation NetConfigInput

+ (NetConfigInput *)shareInstance{
    static NetConfigInput *netConfigInput = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        netConfigInput = [[NetConfigInput alloc] init];
    });
    return netConfigInput;
}

- (NSString *)urlHttp{
    return @"http://";
}

- (NSString *)urlHttps{
    return @"https://";
}

- (NSString *)userToken{
    return @"testUserToken";
}

- (NSString *)userSecret{
    return @"testSecret";
}

- (NSString *)userId{
    return @"testUserId";
}

- (NSString *)apiKey{
    return @"testApiKey";
}

- (NSString *)apiSecrect{
    return @"testApiSecrect";
}

- (NSString *)source{
    return @"testSource";
}

- (NSString *)appName{
    return @"testAppName";
}

- (NSString *)appVersion{
    return @"testAppVersion";
}

- (NSString *)warehouse{
    return @"testWarehouse";
}

- (NSString *)timestamp{
    return @"";
}

- (NSString *)vipChannel{
    return @"";
}

- (NSDictionary *)dicSign{
    return nil;
}

- (NSDictionary *)dicHeaderSign{
    return nil;
}

@end
