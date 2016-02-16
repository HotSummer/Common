//
//  NetConfigRequestDataProtocol.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

//这个代理是为了给请求提供url, ssl信息(可能需要有测试环境，开发环境以及正式环境, 域名环境的实现)

#import <Foundation/Foundation.h>
#import "NetConfigModel.h"

@protocol NetConfigRequestDataProtocol <NSObject>

//url
- (NSString *)urlByModel:(NetConfigModel *)model;
//ssl
- (BOOL)sslByModel:(NetConfigModel *)model;

@end
