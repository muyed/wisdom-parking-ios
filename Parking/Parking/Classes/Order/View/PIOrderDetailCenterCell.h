//
//  PIOrderDetailCenterCell.h
//  Parking
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIOrderDetailCenterCell : UITableViewCell

///-- 标题
@property (nonatomic, copy) NSString *titleStr;
///-- 内容
@property (nonatomic, copy) NSString *contentStr;
///-- 是否为价格
@property (nonatomic, assign) BOOL isPrice;
@end
