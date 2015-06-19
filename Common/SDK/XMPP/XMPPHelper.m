//
//  XMPPHelper.m
//  Common
//
//  Created by summer.zhu on 16/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import "XMPPHelper.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "XMPPConfig.h"
#import "DDLog.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface XMPPHelper ()

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, copy) XMPPStreamBlock willConnectBlock;
@property (nonatomic, copy) XMPPStreamBlock didConnectBlock;
@property (nonatomic, copy) XMPPStreamBlock didAuthenticateBlock;

@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong) XMPPRoster *xmppRoster;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;

@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchivingModule;

@end

@implementation XMPPHelper

DEFINE_SINGLETON(XMPPHelper);

- (void)setupStream{
    _xmppStream = [[XMPPStream alloc]init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    _xmppReconnect = [[XMPPReconnect alloc]init];
    [_xmppReconnect activate:self.xmppStream];
    
    _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc]init];
    _xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:_xmppRosterStorage];
    [_xmppRoster activate:self.xmppStream];
    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    _xmppMessageArchivingModule = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage];
    [_xmppMessageArchivingModule setClientSideMessageArchivingOnly:YES];
    [_xmppMessageArchivingModule activate:_xmppStream];
    [_xmppMessageArchivingModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (BOOL)connect:(NSString *)userId
       password:(NSString *)password
    willConnect:(XMPPStreamBlock)willConnect
     didConnect:(XMPPStreamBlock)didConnect
didAuthenticate:(XMPPStreamBlock)didAuthenticate{
    if (userId.length == 0) {
        return NO;
    }
    self.userId = userId;
    self.password = password;
    _willConnectBlock = willConnect;
    _didConnectBlock = didConnect;
    _didAuthenticateBlock = didAuthenticate;
    
    [[self xmppStream] setHostName:XMPPServerIP];
    [[self xmppStream] setHostPort:[XMPPPort integerValue]];
    
    XMPPJID *myjid = [XMPPJID jidWithString:userId];
    NSError *error ;
    [_xmppStream setMyJID:myjid];
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        DDLogInfo(@"my connected error :");
        return NO;
    }else{
        DDLogInfo(@"发送连接请求成功");
    }
    return YES;
}

#pragma mark - XMPPStreamDelegate

- (void)xmppStreamWillConnect:(XMPPStream *)sender
{
    _willConnectBlock(nil, sender);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    _didConnectBlock(nil, sender);
    //    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPS]) {
    //登录
    NSError *error ;
    if (![self.xmppStream authenticateWithPassword:self.password error:&error]) {
        NSLog(@"error authenticate : %@",error.description);
    }
    //    }
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidRegister");
//    _isRegistration = YES;
    
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPS]) {
//        NSError *error ;
//        if (![self.xmppStream authenticateWithPassword:[[NSUserDefaults standardUserDefaults]objectForKey:kPS] error:&error]) {
//            NSLog(@"error authenticate : %@",error.description);
//        }
//    }
}
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error
{
    NSLog(@"didNotRegister:%@", error.description);
//    [self showAlertView:@"当前用户已经存在,请直接登录"];
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    _didAuthenticateBlock(nil, sender);
    NSLog(@"xmppStreamDidAuthenticate");
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    _didAuthenticateBlock(error.description, sender);
}

- (NSString *)xmppStream:(XMPPStream *)sender alternativeResourceForConflictingResource:(NSString *)conflictingResource
{
    NSLog(@"alternativeResourceForConflictingResource: %@",conflictingResource);
    return @"XMPPIOS";
}

- (void)xmppStreamWasToldToDisconnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamWasToldToDisconnect");
}
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    NSLog(@"xmppStreamConnectDidTimeout");
}
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    _didConnectBlock(error.description, sender);
}


@end
