//
//  PICarportBottomCell.h
//  Parking
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PICarportDataModel;

typedef void(^MatchCarport)(void);
@interface PICarportBottomCell : UITableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableview index:(NSInteger)index;

///-- 数据模型
@property (nonatomic, strong) PICarportDataModel *model;
///-- <#Notes#>
@property (nonatomic, copy) MatchCarport matchCarport;
@end
