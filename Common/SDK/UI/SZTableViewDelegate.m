//
//  SZTableViewDelegate.m
//  Common
//
//  Created by Summer on 16/6/1.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "SZTableViewDelegate.h"
#import "SZTableCell.h"

@implementation SZTableViewDelegate

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return self;
    }else if ([self.anotherTarget respondsToSelector:aSelector]){
        return self.anotherTarget;
    }
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [self.anotherTarget respondsToSelector:aSelector];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrDataInSection = self.dataSource[indexPath.section];
    id model = arrDataInSection[indexPath.row];
    
    Class cellClass = self.cellClass[indexPath.section];
    
    SEL selector2 = @selector(sz_cellHeightWithModel:withSuperWidth:);
    
    BOOL flag2 = [((id)cellClass) respondsToSelector:selector2];
    
    if (flag2) {
        return [cellClass sz_cellHeightWithModel:model withSuperWidth:CGRectGetWidth(tableView.frame)];
    }else{
        return 0;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"didSelectRowAtIndexPath");
//}

@end
