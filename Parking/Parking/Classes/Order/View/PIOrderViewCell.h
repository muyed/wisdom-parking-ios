//
//  PIOrderViewCell.h
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PIOrderModel.h"

@class PIMyVillageDataModel;

@interface PIOrderViewCell : UITableViewCell

///-- <#Notes#>
@property (nonatomic, strong) PIMyVillageDataModel *model;
///-- <#Notes#>
@property (nonatomic, strong) PIOrderListData *listModel;

@end
