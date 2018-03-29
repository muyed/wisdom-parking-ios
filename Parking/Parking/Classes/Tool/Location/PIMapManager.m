//
//  PIMapManager.m
//  Parking
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMapManager.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface PIMapManager ()<MAMapViewDelegate, AMapLocationManagerDelegate>

@property (nonatomic,strong) AMapLocationManager *locactionManager;

@end

@implementation PIMapManager

+ (instancetype)sharedManager {
    
    static PIMapManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[PIMapManager alloc] init];
    });
    
    return manager;
}

- (void)initMapView {
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, NavBarHeight + 60, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight)];
    self.mapController.view.backgroundColor = [UIColor whiteColor];
    [self.mapController.view insertSubview:self.mapView atIndex:0];
    [AMapServices sharedServices].enableHTTPS = YES;

    [self.mapView setZoomLevel:17.3 animated:YES];
    ///-- 设置精准度
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 5.0f;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    //self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
    
}

- (void)setupLocation {
    
    self.locactionManager = [[AMapLocationManager alloc] init];
    self.locactionManager.delegate = self;
    self.locactionManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locactionManager.locationTimeout = 2.0;
    self.locactionManager.reGeocodeTimeout = 2.0;
    [self.locactionManager startUpdatingLocation];
    [self.locactionManager startUpdatingHeading];
    
}

- (void)setPi_showUserLocation:(BOOL)pi_showUserLocation {
    
    _pi_showUserLocation = pi_showUserLocation;
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}
#pragma mark 定位更新回调
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        self.currentLocation = [userLocation.location copy];
        self.mapView.centerCoordinate = self.currentLocation.coordinate;
    }
    
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    
   // self.mapView.centerCoordinate = location.coordinate;
}
@end
