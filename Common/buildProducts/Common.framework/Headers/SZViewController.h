//
//  SZViewController.h
//  Common
//
//  Created by zbq on 15-8-23.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RightBlock)();
typedef void(^LeftBlock)();

@interface SZViewController : UIViewController

/**
 *  UIViewController右上角按钮
 *
 *  @param content 按钮内容
 *  @param block   按钮点击事件
 */
- (void)showRightBarItem:(id)content rightBlock:(RightBlock)block;

/**
 *  UIViewController左上角按钮
 *
 *  @param content 按钮内容
 *  @param block   按钮点击事件
 */
- (void)showLeftBarItem:(id)content leftBlock:(LeftBlock)block;

/**
 *  是否显示navbar
 *
 *  @param showBar YES or NO
 */
- (void)showNavBar:(BOOL)showBar;

/**
 *  显示nav的titleView
 *
 *  @param content titleView
 */
- (void)showNavTitle:(id)content;

@end
