//
//  AFNetWorkRequest.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigRequestProtocol.h"

@interface AFNetWorkRequest : NSObject
<
NetConfigRequestProtocol
>

- (void)request:(NSString *)url method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

- (void)request:(NSString *)url sign:(NSString *)sign method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

- (void)request:(NSString *)url sign:(NSString *)sign ssl:(BOOL)ssl method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

@end
