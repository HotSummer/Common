//
//  XMPPHelper.h
//  Common
//
//  Created by summer.zhu on 16/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "XMPPDefine.h"

@interface XMPPHelper : NSObject

@property(nonatomic, strong) NSMutableArray *friends;

DECLARE_AS_SINGLETON(XMPPHelper);

//初始化XMPP
- (void)setupStream;

/**
 *  XMPP链接
 *
 *  @param userId          用户标识
 *  @param password        用户密码
 *  @param willConnect     将要链接的block
 *  @param didConnect      已经链接的block
 *  @param didAuthenticate 验证通过block
 *  @param receiveIQ       接收到好友信息
 *
 *  @return 是否连接成功
 */
- (BOOL)connect:(NSString *)userId
       password:(NSString *)password
    willConnect:(XMPPStreamBlock)willConnect
     didConnect:(XMPPStreamBlock)didConnect
didAuthenticate:(XMPPStreamBlock)didAuthenticate
      receiveIQ:(XMPPStreamBlock)receiveIQ;


/**
 *  中断长链接
 */
- (void)teardownStream;

/**
 *  上线
 */
- (void)goOnline;

/**
 *  下线
 */
- (void)goOffline;


@end
