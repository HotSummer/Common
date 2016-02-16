//
//  NetConfigRequestProtocol.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(int code, NSString *message, id content, NSError *error);

@protocol NetConfigRequestProtocol <NSObject>

/**
 *  NetConfig网络请求的协议
 *
 *  @param url     请求的url
 *  @param method  请求的方法
 *  @param request 请求的参数
 *  @param res     返回的数据
 */
- (void)request:(NSString *)url method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

/**
 *  NetConfig网络请求的协议
 *
 *  @param url     请求的url
 *  @param sign    请求的签名
 *  @param method  请求的方法
 *  @param request 请求的参数
 *  @param res     返回的数据
 */
- (void)request:(NSString *)url sign:(NSString *)sign method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

/**
 *  NetConfig网络请求的协议
 *
 *  @param url     请求的url
 *  @param sign    请求的签名
 *  @param ssl     是否需要身份认证
 *  @param method  请求的方法
 *  @param request 请求的参数
 *  @param res     返回的数据
 */
- (void)request:(NSString *)url sign:(NSString *)sign ssl:(BOOL)ssl method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;


@end
