//
//  SZNavigationController.m
//  Common
//
//  Created by Summer.zhu on 16/2/15.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "SZNavigationController.h"

@interface SZNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation SZNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        rootViewController.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self popGesture];
}

- (void)popGesture{
    __weak SZNavigationController *weakSelf =  self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled  = YES;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    //        self.interactivePopGestureRecognizer.enabled = NO;
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    //    [self setNavigationBarHidden:NO animated:YES];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    //        self.interactivePopGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count == 1) {
            return NO;
        }
    }
    return YES;
}

@end
