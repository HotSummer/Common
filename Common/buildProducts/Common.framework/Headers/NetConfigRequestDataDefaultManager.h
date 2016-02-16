//
//  NetConfigRequestDataDefaultManager.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-4.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigRequestDataProtocol.h"

@interface NetConfigRequestDataDefaultManager : NSObject
<
NetConfigRequestDataProtocol
>

/**
 *  获取网络配制model的请求url
 *
 *  @param model 网络配制model
 *
 *  @return 请求url
 */
- (NSString *)urlByModel:(NetConfigModel *)model;

/**
 *  根据网络配制model判断是不是需要证书签名
 *
 *  @param model 网络配制model
 *
 *  @return YES or NO
 */
- (BOOL)sslByModel:(NetConfigModel *)model;


@end
