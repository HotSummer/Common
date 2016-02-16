//
//  WMAFNetWorkRequest.h
//  NetConfigRequest
//
//  Created by summer.zhu on 4/2/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfigRequestProtocol.h"

@interface WMAFNetWorkRequest : NSObject
<
NetConfigRequestProtocol
>

- (void)request:(NSString *)url method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

- (void)request:(NSString *)url sign:(NSString *)sign method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

- (void)request:(NSString *)url sign:(NSString *)sign ssl:(BOOL)ssl method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res;

@end
