//
//  CommonLocationManager.m
//  Common
//
//  Created by summer.zhu on 8/6/15.
//  Copyright (c) 2015年 VIP. All rights reserved.
//

#import "CommonLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface CommonLocationManager ()
{
    double _timeLocationBegin;
}

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CommonLocationManager

DEFINE_SINGLETON(CommonLocationManager);

- (void)dealloc
{
    [_locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000;
    }
    return self;
}

- (void)location
{
    
    // 启用GPS埋点
    //    [VSStartupManager sharedInstance].configure.isUploadTimeWithGPS = YES;
    _timeLocationBegin = CFAbsoluteTimeGetCurrent();
    [_locationManager startUpdatingLocation];
}

- (BOOL)locatingEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

- (void)stopLocation
{
    [_locationManager stopUpdatingLocation];
}

#pragma mark -  CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self finishLocation];
    
    _coordinate = newLocation.coordinate;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks)
        {
            _province = placemark.administrativeArea;
            _city = placemark.locality ;
        }
        
        if (_province == nil)
        {
            _province = @"广东省";
            _city = @"广州市";
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationDidSuccesed:)]) {
            [self.delegate locationDidSuccesed:self];
        }
        
    }];
    
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f",newLocation.coordinate.latitude];
    NSString *longitude = [[NSString alloc] initWithFormat:@"%f",newLocation.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [_locationManager stopUpdatingLocation];
    
    [self finishLocation];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationDidFailed:error:)])
    {
        [self.delegate locationDidFailed:self error:error];
    }
}

#pragma mark -- LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    switch (status)
    {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
            }
            
            break;
            
        default:
            
            break;
            
    }
    
    
}

- (void)finishLocation
{
    //    double currentTime = CFAbsoluteTimeGetCurrent();
    //    [VSStartupManager sharedInstance].configure.timeByLocation = (currentTime - _timeLocationBegin) * 1000;
    
    
}

@end
