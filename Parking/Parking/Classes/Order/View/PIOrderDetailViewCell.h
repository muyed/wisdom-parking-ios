//
//  PIOrderDetailViewCell.h
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIOrderListData;

@interface PIOrderDetailViewCell : UITableViewCell

///-- <#Notes#>
@property (nonatomic, strong) PIOrderListData *listData;
///-- 预约码
@property (nonatomic, copy) NSString *orderCode;

@end
