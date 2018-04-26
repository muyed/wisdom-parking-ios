//
//  PIMapManager.m
//  Parking
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMapManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "PICustomAnnotation.h"
#import "PICustomAnnotationView.h"
#import "PICarpotOrderView.h"

@interface PIMapManager ()<MAMapViewDelegate, AMapLocationManagerDelegate, AMapSearchDelegate>

@property (nonatomic,strong) AMapLocationManager *locactionManager;
///-- 搜索
@property (nonatomic, strong) AMapSearchAPI *search;
///-- <#Notes#>
@property (nonatomic, strong) PICarpotOrderView *carpotOrderView;

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

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setupLocation];
    }
    
    return self;
}

- (void)initMapView {
    
    [self setupLocation];
    
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
    self.mapView.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [self loadData];
        
    });
   
    self.carpotOrderView = [PICarpotOrderView carportOrderView];
    
    [PINotification addObserver:self selector:@selector(scrollToUserLoaction) name:@"ScrollToUserLoaction" object:nil];
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

- (void)startUpdateLocation {
    
    [self.locactionManager startUpdatingLocation];
}

- (void)stopUpdateLocation {
    
    [self.locactionManager stopUpdatingLocation];
    [self.locactionManager stopUpdatingHeading];
}

- (void)setPi_showUserLocation:(BOOL)pi_showUserLocation {
    
    _pi_showUserLocation = pi_showUserLocation;
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
}

#pragma mark --标记添加大头针
-(void)addAnomationWithCoor:(CLLocationCoordinate2D)coor{
    //地理坐标反编码为文字
    AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc] init];
    request.location =[AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
    [_search AMapReGoecodeSearch:request];

}

#pragma 反地理编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    
    self.cityName = response.regeocode.addressComponent.city;
    self.districtName = response.regeocode.addressComponent.district;
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
    
    _beginLocation = location;
    
    
//    if (!_isFirst) {
//
//        [self loadData];
//
//        _isFirst = YES;
//    }
    
    _search = [[AMapSearchAPI alloc] init];
    
    AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc] init];
    request.location =[AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    _search.delegate = self;
    [_search AMapReGoecodeSearch:request];
    
}

- (void)loadData {
    
    NSString *lon = [NSString stringWithFormat:@"%lf", self.mapView.userLocation.location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%lf", self.mapView.userLocation.location.coordinate.latitude];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%d", urlPath(@"api/share/loadByDistance"), lon, lat, 20];
    
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        CLLocationCoordinate2D coor ;
        
        coor.latitude = 29.403598;
        
        coor.longitude = 120.261369;
        
        CLLocationCoordinate2D coors;
        coors.latitude = 29.423598;
        
        coors.longitude = 120.281369;
        
        PICustomAnnotation *pointAnnotation = [[PICustomAnnotation alloc] init];
        
        
        pointAnnotation.coordinate = coor;
        pointAnnotation.icon = @"park_da";
        
        PICustomAnnotation *pointAnnotations = [[PICustomAnnotation alloc] init];
        
         pointAnnotations.coordinate = coors;
        pointAnnotations.icon = @"park_da";
        //设置地图的定位中心点坐标
        
        
        //self.mapView.centerCoordinate = coor;
        
        //将点添加到地图上，即所谓的大头针
        
        NSArray *arr = @[pointAnnotation, pointAnnotations];
        
        [self.mapView addAnnotations:arr];
       
        
    
        
    } failure:^(NSError *error) {
        
        
    }];
}

/**自定义大头针*/

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    NSLog(@"-------------");
    
    // 自定义大头针
    if ([annotation isKindOfClass:[PICustomAnnotation class]]) {
        PICustomAnnotationView *annoView = [PICustomAnnotationView annotationViewWithMap:mapView];
//        annoView.canShowCallout= YES;
//        annoView.draggable = YES;
        annoView.annotation = annotation;
        return annoView;
    }
    return nil;
    
}

/*点击大头针*/
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
   
    if ([view isKindOfClass:[PICustomAnnotationView class]]) {
        
        [self.carpotOrderView show];
        
        self.carpotOrderView.lat = view.annotation.coordinate.latitude;
        
         //NSLog(@"%lf", view.annotation.coordinate.latitude);
    }
    
}


- (void)scrollToUserLoaction {
    
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
    
    [self.locactionManager stopUpdatingLocation];
    [self.locactionManager stopUpdatingHeading];
}
@end
