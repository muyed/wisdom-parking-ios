//
//  PIMapManager.h
//  Parking
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIBaseViewController.h"

@interface PIMapManager : NSObject

///-- 控制器
@property (nonatomic, strong) PIBaseViewController *mapController;
///-- 地图对象
@property(nonatomic,strong)MAMapView *mapView;
///-- 当前定位
@property(nonatomic,strong)CLLocation *currentLocation;
///-- 是否显示当前位置
@property (nonatomic, assign) BOOL pi_showUserLocation;
///-- 初始化单例管理员对象
+(instancetype)sharedManager;
///-- 初始化地图
-(void)initMapView;

@end
