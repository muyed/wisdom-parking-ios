//
//  PIVillageCommnViewCell.h
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIVillageCommnViewCell : UITableViewCell

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;

///-- 标题
@property (nonatomic, copy) NSString *titleStr;

- (void)setupUI;
@end
