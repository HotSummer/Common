//
//  FriendModel.h
//  Common
//
//  Created by summer.zhu on 25/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

@interface FriendModel : NSObject

@property(nonatomic, strong) XMPPJID *jid;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *subScription;
@property(nonatomic, strong) NSArray *groups;

@end
