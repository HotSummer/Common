//
//  CommonLocationManager.h
//  Common
//
//  Created by summer.zhu on 8/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import <CoreLocation/CoreLocation.h>

@class CommonLocationManager;

@protocol LocationDelegate <NSObject>

- (void)locationDidSuccesed:(CommonLocationManager *)location;

- (void)locationDidFailed:(CommonLocationManager *)location error:(NSError *)error;

@end

@interface CommonLocationManager : NSObject <CLLocationManagerDelegate>

@property(nonatomic, weak) id <LocationDelegate> delegate;

/*!
 *  省份名
 */
@property(nonatomic, strong, readonly) NSString *province;

/*!
 *  城市名
 */
@property(nonatomic, strong, readonly) NSString *city;

/*!
 *  经纬度
 */
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;

/*!
 *  是否允许定位
 */
@property(nonatomic, assign) BOOL locatingEnabled;

DECLARE_AS_SINGLETON(CommonLocationManager);

/*!
 *  执行定位
 */
- (void)location;

/*!
 *  停止定位 用于定位超过5s的时候停止定位
 */
- (void)stopLocation;

@end
