//
//  PIMyParkingLotCell.h
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIMyVillageCarportModel;

@interface PIMyParkingLotCell : UITableViewCell

///-- <#Notes#>
@property (nonatomic, strong) PIMyVillageCarportModel *model;

///-- 地址
@property (nonatomic, copy) NSString *address;

///-- <#Notes#>
@property (nonatomic, assign) BOOL isCanBind;

@end
