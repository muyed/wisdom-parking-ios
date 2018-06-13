//
//  PIPayForCashController.h
//  Parking
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"
#import "PIMyParkModel.h"

@interface PIPayForCashController : PIBaseTableViewController

///-- 账户押金
@property (nonatomic, assign) BOOL isCarportCash;
///-- <#Notes#>
@property (nonatomic, copy) NSString *orderNum;

///-- <#Notes#>
@property (nonatomic, strong) PIMyParkDataModel *dataModel;

@end
