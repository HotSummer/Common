//
//  JSONModel+VSWMJSONModel.h
//  NetConfigRequest
//
//  Created by summer.zhu on 18/9/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "JSONModel.h"

@interface JSONModel (VSWMJSONModel)

/**
 *  是否有某个属性
 *
 *  @param propertyName 属性名
 *
 *  @return YES or NO
 */
- (BOOL)hasProperty:(NSString *)propertyName;

@end
