//
//  NSObject+Runtime.m
//  Common
//
//  Created by Summer.zhu on 16/2/15.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

- (BOOL)hasKey:(NSString *)propertyName{
    NSString* selectorName = [NSString stringWithFormat:@"%@", propertyName];
    SEL selector = NSSelectorFromString(selectorName);
    
    BOOL foundCustomTransformer = NO;
    if ([self respondsToSelector:selector]) {
        foundCustomTransformer = YES;
    } else {
        //try for hidden transformer
        selectorName = [NSString stringWithFormat:@"__%@",selectorName];
        selector = NSSelectorFromString(selectorName);
        if ([self respondsToSelector:selector]) {
            foundCustomTransformer = YES;
        }
    }
    
    return foundCustomTransformer;
}

@end
