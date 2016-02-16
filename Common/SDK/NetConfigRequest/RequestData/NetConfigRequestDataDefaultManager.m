//
//  NetConfigRequestDataDefaultManager.m
//  NetConfigRequest
//
//  Created by zbq on 15-1-4.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "NetConfigRequestDataDefaultManager.h"
#import "NetConfigInput.h"

@implementation NetConfigRequestDataDefaultManager

- (NSString *)urlByModel:(NetConfigModel *)model{
    NSString *url = [[NetConfigInput shareInstance] urlHttp];
    
    return [NSString stringWithFormat:@"%@%@", url, model.serverName];
}

- (BOOL)sslByModel:(NetConfigModel *)model{
    if (model.ssl.length > 0 && [model.ssl isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

@end
