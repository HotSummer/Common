//
//  CommonDefine.h
//  Common
//
//  Created by summer.zhu on 8/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

//#ifndef Common_CommonDefine_h
//#define Common_CommonDefine_h

#define NSMethodLog(msg) NSLog(@"Line:%d,Func:%s,%@",__LINE__,__func__,msg)

#define ResizableImage(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageFromBundle(name,top,left,bottom,right) [[UIImage imageWithContentsOfFile:IMAGEURL(name)] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageWithMode(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]
#define ALERT(title,msg,cancel,delegate) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancel otherButtonTitles:nil] show]

//GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//Device
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] intValue]==7)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]==8)

#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>6)
#define isAfterIOS7 ([[[UIDevice currentDevice] systemVersion] intValue]>=7)
#define isAfterIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]>=8)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPadClient UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

#define appDelegate (AppDelegate *)[UIApplication sharedApplication].delegate

//log
#ifdef DEBUG
#define VSLog(...) NSLog(__VA_ARGS__)
#else
#define VSLog(...){};
#endif

//SINGLETON
#define DECLARE_AS_SINGLETON(interfaceName)               \
+ (interfaceName*)ShareInstance;                        \

#define DEFINE_SINGLETON(interfaceName)                     \
static interfaceName* interfaceName##Instance = nil;             \
+ (interfaceName*)ShareInstance                          \
{                                                          \
static dispatch_once_t onceToken;                           \
dispatch_once(&onceToken, ^{                                \
if (nil == interfaceName##Instance) {                 \
interfaceName##Instance = [[interfaceName alloc] init];        \
}         \
});                \
return interfaceName##Instance;            \
}

//#endif
