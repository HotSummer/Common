//
//  WMNetConfigSign.h
//  NetConfigRequest
//
//  Created by summer.zhu on 4/2/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigSignProtocol.h"

@interface WMNetConfigSign : NSObject
<
NetConfigSignProtocol
>

//给body中的参数使用
- (NSString *)signString:(NSDictionary *)dic;
//给header中的参数使用
- (NSString *)headerSignString:(NSDictionary *)dic;

@end
