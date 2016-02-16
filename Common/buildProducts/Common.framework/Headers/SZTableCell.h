//
//  SZTableCell.h
//  Common
//
//  Created by Summer.zhu on 16/2/9.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZUIInitProtocol.h"

@protocol SZTableCellProtocol <NSObject>

@optional
/**
 *  返回cell高度
 *
 *  @param model        数据
 *  @param t_superWidth cell父试图（tableview）宽度
 *
 *  @return 高度
 */
+ (CGFloat)sz_cellHeightWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth;

/**
 *  更新cell数据
 *
 *  @param model        数据
 *  @param t_superWidth cell父试图（tableview）宽度
 *  @param indexPath    位置
 *  @param delegate     代理
 */
- (void)sz_updateCellInfoWithModel:(id)model withSuperWidth:(CGFloat)t_superWidth indexPath:(NSIndexPath*)indexPath del:(id)delegate;
@end

@interface SZTableCell : UITableViewCell
<
SZUIInitProtocol,
SZTableCellProtocol
>

@end
