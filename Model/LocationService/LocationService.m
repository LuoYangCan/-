//
//  LocationService.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/11/10.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationService ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *LocationManager;        /**< 定位  */
@end
@implementation LocationService

-(instancetype)init{
    if (self = [super init]) {
        [self getLocation];
    }
    return self;
}


-(void)getLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        self.LocationManager = [[CLLocationManager alloc]init];
        self.LocationManager.delegate = self;
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.LocationManager requestWhenInUseAuthorization];
        [self.LocationManager startUpdatingHeading];
    }
}

#pragma mark -CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations[0];
    
    CLGeocoder *Geocoder = [[CLGeocoder alloc]init];
    
    [Geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            self.cityName = city;
        }else if (error == nil && [placemarks count] == 0){
            
            NSLog(@"No results were returned.");
            
        }else if (error != nil){
            
            NSLog(@"An error occurred = %@", error.description);
            
        }
        [manager stopUpdatingLocation];
    }];
}



-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"调用失败了 原因是：%@\n",error);
}

@end
