//
//  NetConfigReflectProtocol.h
//  NetConfigRequest
//
//  Created by summer.zhu on 22/1/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigModel.h"

@protocol NetConfigReflectProtocol <NSObject>

/**
 *  根据配制数据（configModel）和对象（requestObj， 请求数据的来源）生成请求数据（NSDictionary）
 *
 *  @param configModel 配制数据
 *  @param requestObj  对象
 *
 *  @return 请求数据
 */
- (NSDictionary *)requestDataFromConfig:(NetConfigModel *)configModel requestObject:(NSObject *)requestObj;

/**
 *  根据配制数据（configModel）和对象数组（requestObj， 请求数据的来源）生成请求数据（NSDictionary）
 *
 *  @param configModel 配制数据
 *  @param requestObjs 对象数组
 *
 *  @return 请求数据的数据字典
 */
- (NSDictionary *)requestDataFromConfig:(NetConfigModel *)configModel requestObjects:(NSArray *)requestObjs;

/**
 *  根据配制数据（configModel）,数据（contentData） 和对象（responseObject， 返回数据的对象）填充返回对象
 *
 *  @param configModel    配制数据
 *  @param contentData    数据
 *  @param responseObject 对象
 *
 */
- (void)responseObjectFromConfig:(NetConfigModel *)configModel contentData:(id)contentData responseObject:(NSObject *)responseObject;

/**
 *  根据配制数据（configModel）,数据（contentData） 和对象（responseObject， 返回数据的对象）填充返回对象
 *
 *  @param configModel    配制数据
 *  @param contentData    数据
 *  @param responseObject 对象
 *  @param classNameInArray 当responseObject为NSMutableArray时，需要通过classNameInArray指定数组里面数据的类名
 *
 */
- (void)responseObjectFromConfig:(NetConfigModel *)configModel contentData:(id)contentData responseObject:(NSObject *)responseObject classNameInArray:(NSString *)className;

/**
 *  根据配制数据（configModel）,数据（contentData） 和对象数组（responseObject， 返回数据的对象）填充返回对象数组
 *
 *  @param configModel     配制数据
 *  @param contentData     数据
 *  @param responseObjects 对象数组
 */
- (void)responseObjectFromConfig:(NetConfigModel *)configModel contentData:(id)contentData responseObjects:(NSArray *)responseObjects;


@end
