//
//  PICarportTimeCell.h
//  Parking
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PICarportDataModel;

@interface PICarportTimeCell : UITableViewCell

///-- 数据源
@property (nonatomic, strong) PICarportDataModel *model;

@end
