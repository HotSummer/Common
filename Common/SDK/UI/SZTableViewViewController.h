//
//  SZTableViewViewController.h
//  Common
//
//  Created by Summer.zhu on 16/2/9.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZViewController.h"

@interface SZTableViewViewController : SZViewController
<
UITableViewDataSource,
UITableViewDelegate
>

@property(nonatomic, strong) UITableView *tableview;

@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSArray *cellClass;

@property(nonatomic, strong) NSArray *sectionViewDataSource;
@property(nonatomic, strong) NSArray *sectionClass;

@end
