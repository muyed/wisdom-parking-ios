//
//  PICarportAddressCell.h
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PICarportDataModel;

typedef void(^CarportNav)(void);

@interface PICarportAddressCell : UITableViewCell

///-- 数据源
@property (nonatomic, strong) PICarportDataModel *model;
///-- <#Notes#>
@property (nonatomic, copy) CarportNav carportNav;

@end
