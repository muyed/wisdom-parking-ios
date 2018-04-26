//
//  PIParkingLotAuthCell.h
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIMyVillageCarportModel;

@interface PIParkingLotAuthCell : UITableViewCell

///-- <#Notes#>
@property (nonatomic, strong) PIMyVillageCarportModel *model;
///-- 地址
@property (nonatomic, copy) NSString *address;
@end

