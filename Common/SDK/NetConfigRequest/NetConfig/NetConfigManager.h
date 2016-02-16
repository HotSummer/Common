//
//  NetConfigManager.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigModel.h"
#import "NetConfigSignProtocol.h"
#import "NetConfigModelProtocol.h"
#import "NetConfigInputProtocol.h"
#import "NetConfigReflectProtocol.h"
#import "NetConfigRequestProtocol.h"
#import "NetConfigRequestDataProtocol.h"

@interface NetConfigManager : NSObject

@property(nonatomic, strong) id<NetConfigInputProtocol> netConfigInput;
@property(nonatomic, strong) id<NetConfigRequestProtocol> request;
@property(nonatomic, strong) id<NetConfigReflectProtocol> netConfigReflect;
@property(nonatomic, strong) id<NetConfigModelProtocol> netConfigModel;
@property(nonatomic, strong) id<NetConfigRequestDataProtocol> netConfigRequestData;
@property(nonatomic, strong) id<NetConfigSignProtocol> netConfigSign;

+ (instancetype)shareInstance;

/**
 *  网络请求
 *
 *  @param modelKey 请求的配制model
 *  @param req      请求对象
 *  @param res      返回对象
 *  @param resblock 回调
 */
- (void)request:(NSString *)modelKey requestObject:(NSObject *)req responseObject:(NSObject *)res
       response:(ResponseBlock)resblock;

/**
 *  网络请求
 *
 *  @param modelKey 请求的配制model
 *  @param req      请求对象
 *  @param resArr   返回对象
 *  @param className   返回对象
 *  @param resblock 回调
 */
- (void)request:(NSString *)modelKey requestObject:(NSObject *)req responseArray:(NSMutableArray *)resArr  classNameInArray:(NSString *)className response:(ResponseBlock)resblock;

/**
 *  网络请求
 *
 *  @param modelKey 请求的配制model
 *  @param reqs     请求的对象数组
 *  @param ress     返回的对象数组
 *  @param resblock 回调
 */
- (void)request:(NSString *)modelKey requestObjects:(NSArray *)reqs responseObjects:(NSArray *)ress response:(ResponseBlock)resblock;

/**
 *  网络请求
 *
 *  @param modelKey  请求的配制model
 *  @param req       请求对象
 *  @param className 返回对象类名
 *  @param resblock  回调
 */
- (void)request:(NSString *)modelKey requestObject:(NSObject *)req responseClass:(NSString *)className response:(ResponseBlock)resblock;

@end
