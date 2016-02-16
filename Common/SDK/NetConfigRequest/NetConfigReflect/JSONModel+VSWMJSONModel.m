//
//  JSONModel+VSWMJSONModel.m
//  NetConfigRequest
//
//  Created by summer.zhu on 18/9/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "JSONModel+VSWMJSONModel.h"

@implementation JSONModel (VSWMJSONModel)

- (BOOL)hasProperty:(NSString *)propertyName{
    SEL selector = NSSelectorFromString(propertyName);
    return [self respondsToSelector:selector];
}


@end
