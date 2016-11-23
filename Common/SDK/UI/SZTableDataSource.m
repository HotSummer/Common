//
//  SZTableDataSource.m
//  Common
//
//  Created by Summer on 16/6/1.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "SZTableDataSource.h"
#import "SZTableCell.h"
#import "FileHelper.h"

@implementation SZTableDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arrDataInSection = self.dataSource[section];
    return arrDataInSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class t_cellClass = self.cellClass[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(t_cellClass)];
    
    if(!cell)
    {
        Class t_cellClass   = nil;
        if (self.cellClass.count > 0) {
            t_cellClass             = self.cellClass[indexPath.section];
        }
        else
        {
            return nil;
        }
        
        NSString *t_xibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(t_cellClass) ofType:@"nib"];
        if(t_xibPath && [[FileHelper shareIntance] fileExistsAtPath:t_xibPath])
        {
            NSArray *cells = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(t_cellClass) owner:nil options:nil];
            if([cells count] <= 0)
            {
                cell = [[t_cellClass alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:self.cellClass[indexPath.section]];
            }
            else
            {
                cell = cells[0];
            }
        }
        else
        {
            cell = [[t_cellClass alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:self.cellClass[indexPath.section]];
        }
    }
    
    NSArray *arrDataInSection = self.dataSource[indexPath.section];
    id model = arrDataInSection[indexPath.row];
    if ([cell isKindOfClass:[SZTableCell class]]) {
        SZTableCell *szCell = (SZTableCell *)cell;
        if ([szCell respondsToSelector:@selector(sz_updateCellInfoWithModel:withSuperWidth:indexPath:)]) {
            [szCell sz_updateCellInfoWithModel:model withSuperWidth:tableView.frame.size.width indexPath:indexPath];
        }
    }
    
    return cell;
}

@end
