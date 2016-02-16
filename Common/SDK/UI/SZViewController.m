//
//  SZViewController.m
//  Common
//
//  Created by zbq on 15-8-23.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import "SZViewController.h"
#import "objc/runtime.h"

static NSString *LeftBlockString = @"LeftBlockString";
static NSString *RightBlockString = @"RightBlockString";

@interface SZViewController ()

@property(nonatomic, copy) RightBlock rightBlock;
@property(nonatomic, copy) LeftBlock leftBlock;

@end

@implementation SZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showNavBar:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showRightBarItem:(id)content rightBlock:(RightBlock)block{
    _rightBlock = block;
    
    UIBarButtonItem *rightBarItem = nil;
    if ([content isKindOfClass:[NSString class]]) {
        rightBarItem = [self barWithString:(NSString *)content selector:@selector(didPressedBtnRight)];
    }else if ([content isKindOfClass:[UIImage class]]){
        rightBarItem = [self barWithImage:(UIImage *)content selector:@selector(didPressedBtnRight)];
    }else if ([content isKindOfClass:[UIView class]]){
        rightBarItem = [self barWithCustomerView:(UIView *)content];
    }
    if (rightBarItem) {
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)didPressedBtnRight{
    if (_rightBlock != nil) {
        _rightBlock();
    }
}

- (void)showLeftBarItem:(id)content leftBlock:(LeftBlock)block{
    _leftBlock = block;
    UIBarButtonItem *leftBarItem = nil;
    if ([content isKindOfClass:[NSString class]]) {
        leftBarItem = [self barWithString:(NSString *)content selector:@selector(didPressedBtnleft)];
    }else if ([content isKindOfClass:[UIImage class]]){
        leftBarItem = [self barWithImage:(UIImage *)content selector:@selector(didPressedBtnleft)];
    }else if ([content isKindOfClass:[UIView class]]){
        leftBarItem = [self barWithCustomerView:(UIView *)content];
    }
    if (leftBarItem) {
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)didPressedBtnleft{
    if (_leftBlock != nil) {
        _leftBlock();
    }
}

- (void)showNavBar:(BOOL)showBar{
    self.navigationController.navigationBarHidden = showBar;
}

- (void)showNavTitle:(id)content{
    if ([content isKindOfClass:[NSString class]]) {
        self.title = (NSString *)content;
    }else if([content isKindOfClass:[UIView class]]){
        self.navigationItem.titleView = (UIView *)content;
    }
}

#pragma mark - 创建BarButtonItem三种方式
- (UIBarButtonItem *)barWithString:(NSString *)message selector:(SEL)selector{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:message style:UIBarButtonItemStylePlain target:self action:selector];
    [item setTintColor:[UIColor whiteColor]];
    return item;
}

- (UIBarButtonItem *)barWithImage:(UIImage *)image selector:(SEL)selector{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:selector];
    [item setTintColor:[UIColor whiteColor]];
    return item;
}

- (UIBarButtonItem *)barWithCustomerView:(UIView *)customerView{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customerView];
    return item;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
