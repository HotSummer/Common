//
//  SZView.m
//  Common
//
//  Created by Summer.zhu on 16/2/9.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import "SZView.h"

@implementation SZView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self sz_setInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self sz_setInit];
    }
    return self;
}

- (void)wy_setInit
{
    
}

@end
