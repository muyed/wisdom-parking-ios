//
//  PIParkingLotAuthController.h
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"

@class PIMyVillageCarportModel;

@interface PIParkingLotAuthController : PIBaseTableViewController

///-- <#Notes#>
@property (nonatomic, strong) PIMyVillageCarportModel *model;

///-- 地址
@property (nonatomic, copy) NSString *address;


@end
