//
//  PIHomeNaviDriveController.h
//  Parking
//
//  Created by apple on 2018/4/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

@interface PIHomeNaviDriveController : PIBaseViewController

/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoor;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoor;

@end
