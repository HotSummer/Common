//
//  SZUIInitProtocol.h
//  Common
//
//  Created by Summer.zhu on 16/2/9.
//  Copyright © 2016年 VIP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SZUIInitProtocol <NSObject>

@optional
+ (instancetype)initializeUI;//初始化

- (void)sz_setInit;     //设置ui样式

- (void)sz_updateUIWithModel:(id)model; //根据数据模型更新ui

@end
