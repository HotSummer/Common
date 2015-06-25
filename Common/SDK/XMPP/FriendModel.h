//
//  FriendModel.h
//  Common
//
//  Created by summer.zhu on 25/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

/*
 available 上线
 away 离开
 do not disturb 忙碌
 unavailable 下线
 */
typedef enum {
    Unavailable = 0,//下线
    Available,//上线
    Away,//离开
    DoNotDisturb//忙碌
}FriendState;

@interface FriendModel : NSObject

@property(nonatomic, strong) XMPPJID *jid;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *subScription;
@property(nonatomic, strong) NSArray *groups;
@property(nonatomic) FriendState state;
@property(nonatomic, strong) NSString *stateName;

@end
