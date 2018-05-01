//
//  PICarsListController.h
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"

typedef void(^CarNum)(NSString *carNum);
@interface PICarsListController : PIBaseTableViewController

///-- <#Notes#>
@property (nonatomic, copy) CarNum carNum;

///-- <#Notes#>
@property (nonatomic, assign) BOOL isMatch;
@end
