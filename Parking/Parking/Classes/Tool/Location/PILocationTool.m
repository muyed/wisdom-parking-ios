//
//  PILocationTool.m
//  Parking
//
//  Created by apple on 2018/3/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILocationTool.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface PILocationTool ()<AMapLocationManagerDelegate>

@property (nonatomic,strong) AMapLocationManager *locactionManager;

@end
@implementation PILocationTool

- (void)dealloc
{
    
    [self stopUpdataingLocation];
    
}

+ (instancetype)shareCoreLoaction {

    static PILocationTool *locationTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationTool = [[PILocationTool alloc] init];
    });
    
    return locationTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locactionManager = [[AMapLocationManager alloc] init];
        _locactionManager.delegate = self;
        _locactionManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locactionManager.distanceFilter = 0.5f;
        //        [self startUpdataingLocation];
    }
    return self;
}

- (void)startUpdataingLocation{
    
    [self.locactionManager startUpdatingLocation];
}

- (void)stopUpdataingLocation{
    [self.locactionManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    _location = location;
    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", _location.coordinate.latitude, _location.coordinate.longitude, _location.horizontalAccuracy);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error: %@",error);
}


@end
