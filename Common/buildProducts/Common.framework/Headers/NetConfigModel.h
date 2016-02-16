//
//  NetConfigModel.h
//  NetConfigRequest
//
//  Created by summer.zhu on 31/12/14.
//  Copyright (c) 2014年 summer.zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface NetConfigModel : JSONModel

@property(nonatomic,strong)NSString *configkey;
//@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *ssl;
@property(nonatomic,strong)NSString *method;
@property(nonatomic,copy)NSString *serverName;
@property(nonatomic,strong)NSDictionary *reqParam;
@property(nonatomic,strong)NSDictionary *resParam;

@end
