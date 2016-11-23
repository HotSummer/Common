//
//  SZTableDataSource.h
//  Common
//
//  Created by Summer on 16/6/1.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTableDataSource : NSObject
<
UITableViewDataSource
>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *cellClass;

@end
