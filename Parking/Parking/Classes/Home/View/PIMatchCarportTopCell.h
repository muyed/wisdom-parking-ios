//
//  PIMatchCarportTopCell.h
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIMatchCarportTopCell : UITableViewCell

///-- 颜色
@property (nonatomic, strong) UIColor *tipColor;
///-- 提示文字
@property (nonatomic, copy) NSString *tipStr;
///-- 内容
@property (nonatomic, copy) NSString *contentStr;
@end
