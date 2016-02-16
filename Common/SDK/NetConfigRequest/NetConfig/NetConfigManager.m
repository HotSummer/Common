//
//  NetConfigManager.m
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "NetConfigManager.h"
#import "NetConfigDefine.h"

#ifdef UserDefault
#import "NetConfigInput.h"
#import "AFNetWorkRequest.h"
#import "NetConfigDefaultReflect.h"
#import "NetConfigModelDefaultManager.h"
#import "NetConfigRequestDataDefaultManager.h"
#import "NetConfigDefaultSign.h"
#else
#endif

@interface NetConfigManager ()

@end

@implementation NetConfigManager

+ (instancetype)shareInstance{
    static NetConfigManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[NetConfigManager alloc] init];
    });
    return manager;
}

- (id)init{
    if (self = [super init]) {
#ifdef UserDefault
        _netConfigInput = [[NetConfigInput alloc] init];
        _request = [[AFNetWorkRequest alloc] init];
        _netConfigReflect = [[NetConfigDefaultReflect alloc] init];
        _netConfigModel = [[NetConfigModelDefaultManager alloc] init];
        _netConfigRequestData = [[NetConfigRequestDataDefaultManager alloc] init];
        _netConfigSign = [[NetConfigDefaultSign alloc] init];
#else
        
#endif
    }
    return self;
}

- (void)request:(NSString *)modelKey requestObject:(NSObject *)req responseArray:(NSMutableArray *)resArr classNameInArray:(NSString *)className response:(ResponseBlock)resblock{
    NetConfigModel *model = [_netConfigModel getModel:modelKey];
    
    //在body中的签名
    NSString *signBody = [_netConfigSign signString:[_netConfigInput dicSign]];
    //请求参数
    NSDictionary *dicRequest = [_netConfigReflect requestDataFromConfig:model requestObject:req];
    NSMutableDictionary *mutableDicRequest = [NSMutableDictionary dictionaryWithDictionary:dicRequest];
    if (signBody.length > 0) {
        [mutableDicRequest setObject:signBody forKey:@"apiSign"];
    }
    
    //url
    NSString *url = [_netConfigRequestData urlByModel:model];
    //是否身份验证
    BOOL ssl = [_netConfigRequestData sslByModel:model];
    
    //header签名
    NSString *signHeader = [_netConfigSign headerSignString:[_netConfigInput dicHeaderSign]];
    
    //请求
    [_request request:url sign:signHeader ssl:ssl method:model.method requestParmers:mutableDicRequest response:^(int code, NSString *message, id content, NSError *error) {
        [_netConfigReflect responseObjectFromConfig:model contentData:content responseObject:resArr classNameInArray:className];
        resblock(code, message, content, error);
    }];
}

- (void)request:(NSString *)modelKey requestObject:(NSObject *)req responseObject:(NSObject *)res
       response:(ResponseBlock)resblock{
    NetConfigModel *model = [_netConfigModel getModel:modelKey];
    
    //在body中的签名
    NSString *signBody = [_netConfigSign signString:[_netConfigInput dicSign]];
    //请求参数
    NSDictionary *dicRequest = [_netConfigReflect requestDataFromConfig:model requestObject:req];
    NSMutableDictionary *mutableDicRequest = [NSMutableDictionary dictionaryWithDictionary:dicRequest];
    if (signBody.length > 0) {
        [mutableDicRequest setObject:signBody forKey:@"apiSign"];
    }
    
    //url
    NSString *url = [_netConfigRequestData urlByModel:model];
    //是否身份验证
    BOOL ssl = [_netConfigRequestData sslByModel:model];
    
    //header签名
    NSString *signHeader = [_netConfigSign headerSignString:[_netConfigInput dicSign]];
    
    //请求
    [_request request:url sign:signHeader ssl:ssl method:model.method requestParmers:mutableDicRequest response:^(int code, NSString *message, id content, NSError *error) {
        [_netConfigReflect responseObjectFromConfig:model contentData:content responseObject:res];
        resblock(code, message, content, error);
    }];
}

- (void)request:(NSString *)modelKey requestObjects:(NSArray *)reqs responseObjects:(NSArray *)ress response:(ResponseBlock)resblock{
    NetConfigModel *model = [_netConfigModel getModel:modelKey];
    
    //请求参数
    NSDictionary *dicRequest = [_netConfigReflect requestDataFromConfig:model requestObjects:reqs];
    NSMutableDictionary *mutableDicRequest = [NSMutableDictionary dictionaryWithDictionary:dicRequest];
    
    //在body中的签名
    NSString *signBody = [_netConfigSign signString:[_netConfigInput dicSign]];
    [mutableDicRequest setObject:signBody forKey:@"apiSign"];
    
    //url
    NSString *url = [_netConfigRequestData urlByModel:model];
    //是否身份验证
    BOOL ssl = [_netConfigRequestData sslByModel:model];
    
    //header签名
    NSString *signHeader = [_netConfigSign headerSignString:[_netConfigInput dicHeaderSign]];
    
    //请求
    [_request request:url sign:signHeader ssl:ssl method:model.method requestParmers:mutableDicRequest response:^(int code, NSString *message, id content, NSError *error) {
        [_netConfigReflect responseObjectFromConfig:model contentData:content responseObjects:ress];
        resblock(code, message, content, error);
    }];
}

- (void)request:(NSString *)modelKey requestObject:(NSObject *)req responseClass:(NSString *)className response:(ResponseBlock)resblock{
    NSObject *object = [[NSClassFromString(className) alloc] init];
    [self request:modelKey requestObject:req responseObject:object response:resblock];
}

@end
