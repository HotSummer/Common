//
//  NetConfigModelDefaultManager.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-4.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigModelProtocol.h"

@interface NetConfigModelDefaultManager : NSObject
<
NetConfigModelProtocol
>

/**
 *  根据指定的key获取对应的model
 *
 *  @param configModel 映射model对应的key
 *
 *  @return 映射model
 */
- (NetConfigModel *)getModel:(NSString *)modelKey;

@end
