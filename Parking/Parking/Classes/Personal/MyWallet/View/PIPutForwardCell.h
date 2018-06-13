//
//  PIPutForwardCell.h
//  Parking
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIMyParkDataModel;

@interface PIPutForwardCell : UITableViewCell

///-- 提现金额
@property (nonatomic, strong) UITextField *moneyField;
///-- 是否为押金
@property (nonatomic, assign) BOOL isCash;
///-- 数据源
@property (nonatomic, strong) PIMyParkDataModel *dataModel;

@end
