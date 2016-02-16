//
//  NetConfigModelProtocol.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-4.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigModel.h"

@protocol NetConfigModelProtocol <NSObject>

- (NetConfigModel *)getModel:(NSString *)modelKey;

@end
