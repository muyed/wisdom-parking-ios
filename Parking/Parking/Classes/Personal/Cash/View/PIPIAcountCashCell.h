//
//  PIPIAcountCashCell.h
//  Parking
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PIMyParkModel.h"

@protocol PIAcountCashCellDelegate <NSObject>

- (void)clickButtonWithIndex:(NSInteger)index;

@end

@interface PIPIAcountCashCell : UITableViewCell

///-- tag
@property (nonatomic, assign) NSInteger index;
///-- 数据源
@property (nonatomic, strong) PIMyParkDataModel *dataModel;
///-- 代理
@property (nonatomic, weak) id<PIAcountCashCellDelegate>delegate;

@end
