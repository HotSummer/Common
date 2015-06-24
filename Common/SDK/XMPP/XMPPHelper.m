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
@property (nonatomic, strong) XMPPvCardCoreDataStorage *xmppvCardStorage;
@property (nonatomic, strong) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;

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
    _xmppMessageArchivingModule = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage];
    [_xmppMessageArchivingModule setClientSideMessageArchivingOnly:YES];
    [_xmppMessageArchivingModule activate:_xmppStream];
    [_xmppMessageArchivingModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
//    _xmppRoster.autoFetchRoster = YES;
//    _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
//    
//    // Setup vCard support
//    //
//    // The vCard Avatar module works in conjuction with the standard vCard Temp module to download user avatars.
//    // The XMPPRoster will automatically integrate with XMPPvCardAvatarModule to cache roster photos in the roster.
//    
//    _xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
//    _xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:_xmppvCardStorage];
//    
//    _xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_xmppvCardTempModule];
//    
//    // Setup capabilities
//    //
//    // The XMPPCapabilities module handles all the complex hashing of the caps protocol (XEP-0115).
//    // Basically, when other clients broadcast their presence on the network
//    // they include information about what capabilities their client supports (audio, video, file transfer, etc).
//    // But as you can imagine, this list starts to get pretty big.
//    // This is where the hashing stuff comes into play.
//    // Most people running the same version of the same client are going to have the same list of capabilities.
//    // So the protocol defines a standardized way to hash the list of capabilities.
//    // Clients then broadcast the tiny hash instead of the big list.
//    // The XMPPCapabilities protocol automatically handles figuring out what these hashes mean,
//    // and also persistently storing the hashes so lookups aren't needed in the future.
//    //
//    // Similarly to the roster, the storage of the module is abstracted.
//    // You are strongly encouraged to persist caps information across sessions.
//    //
//    // The XMPPCapabilitiesCoreDataStorage is an ideal solution.
//    // It can also be shared amongst multiple streams to further reduce hash lookups.
//    
//    _xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
//    _xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:_xmppCapabilitiesStorage];
//    
//    _xmppCapabilities.autoFetchHashedCapabilities = YES;
//    _xmppCapabilities.autoFetchNonHashedCapabilities = NO;
//    
//    // Activate xmpp modules
//    
//    [_xmppReconnect         activate:_xmppStream];
//    [_xmppRoster            activate:_xmppStream];
//    [_xmppvCardTempModule   activate:_xmppStream];
//    [_xmppvCardAvatarModule activate:_xmppStream];
//    [_xmppCapabilities      activate:_xmppStream];
//    
//    // Add ourself as a delegate to anything we may be interested in
//    
//    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    
//    // Optional:
//    //
//    // Replace me with the proper domain and port.
//    // The example below is setup for a typical google talk account.
//    //
//    // If you don't supply a hostName, then it will be automatically resolved using the JID (below).
//    // For example, if you supply a JID like 'user@quack.com/rsrc'
//    // then the xmpp framework will follow the xmpp specification, and do a SRV lookup for quack.com.
//    //
//    // If you don't specify a hostPort, then the default (5222) will be used.
//    
//    //	[xmppStream setHostName:@"talk.google.com"];
//    //	[xmppStream setHostPort:5222];	
//    
//    
//    // You may need to alter these settings depending on the server you're connecting to
////    _customCertEvaluation = YES;
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
