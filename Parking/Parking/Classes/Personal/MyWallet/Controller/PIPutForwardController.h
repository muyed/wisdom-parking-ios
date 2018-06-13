//
//  PIPutForwardController.h
//  Parking
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"

@class PIMyParkDataModel;

@interface PIPutForwardController : PIBaseTableViewController

///-- 是否为押金
@property (nonatomic, assign) BOOL isCash;

@property (nonatomic, assign) BOOL isCarportCash;

///-- 车锁ID
@property (nonatomic, strong) PIMyParkDataModel *dataModel;

@end
