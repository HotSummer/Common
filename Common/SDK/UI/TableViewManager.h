//
//  TableViewManager.h
//  Common
//
//  Created by Summer on 16/6/1.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTableDataSource.h"
#import "SZTableViewDelegate.h"

@interface TableViewManager : NSObject

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *cellClass;
@property (nonatomic, weak) id<UITableViewDelegate> target;

@property(nonatomic, strong) SZTableDataSource *dataSourceTarget;
@property(nonatomic, strong) SZTableViewDelegate *tableDelegateTarget;


- (id)initWithDataSource:(NSArray *)data cellTypes:(NSArray *)cellClass tableDelegateTarget:(id<UITableViewDelegate>)target;

- (void)updateDataSource:(NSArray *)data cellTypes:(NSArray *)cellClass;

@end
