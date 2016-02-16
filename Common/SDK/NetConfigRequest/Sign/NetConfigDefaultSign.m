//
//  NetConfigDefaultSign.m
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "NetConfigDefaultSign.h"

@implementation NetConfigDefaultSign

//给body中的参数使用
- (NSString *)signString:(NSDictionary *)dic{
    return @"";
}
//给header中的参数使用
- (NSString *)headerSignString:(NSDictionary *)dic{
    return @"";
}

@end
