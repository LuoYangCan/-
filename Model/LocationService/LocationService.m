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
        <#statements#>
    }
    return self;
}


-(void)getLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        self.LocationManager = [[CLLocationManager alloc]init];
        self.LocationManager.delegate = self;
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
}

@end
