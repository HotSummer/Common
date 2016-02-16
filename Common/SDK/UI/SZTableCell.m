//
//  SZTableCell.m
//  Common
//
//  Created by Summer.zhu on 16/2/9.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "SZTableCell.h"

@implementation SZTableCell

- (void)awakeFromNib {
    // Initialization code
    
    if([self respondsToSelector:@selector(sz_setInit)])
    {
        [self sz_setInit];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        if([self respondsToSelector:@selector(sz_setInit)])
        {
            [self sz_setInit];
        }
    }
    return self;
}

@end
