//
//  TableViewManager.m
//  Common
//
//  Created by Summer on 16/6/1.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "TableViewManager.h"

@interface TableViewManager ()

@end

@implementation TableViewManager

- (id)initWithDataSource:(NSArray *)data cellTypes:(NSArray *)cellClass tableDelegateTarget:(id<UITableViewDelegate>)target{
    if (self = [super init]) {
        self.dataSource = data;
        self.cellClass = cellClass;
        self.target = target;
        
        self.dataSourceTarget = [[SZTableDataSource alloc] init];
        self.dataSourceTarget.dataSource = data;
        self.dataSourceTarget.cellClass = cellClass;
        
        self.tableDelegateTarget = [[SZTableViewDelegate alloc] init];
        self.tableDelegateTarget.dataSource = data;
        self.tableDelegateTarget.cellClass = cellClass;
        self.tableDelegateTarget.anotherTarget = target;
    }
    return self;
}

- (void)updateDataSource:(NSArray *)data cellTypes:(NSArray *)cellClass{
    self.dataSourceTarget.dataSource = data;
    self.dataSourceTarget.cellClass = cellClass;
    
    self.tableDelegateTarget.dataSource = data;
    self.tableDelegateTarget.cellClass = cellClass;
}

@end
