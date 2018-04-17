//
//  PIBaseDetailCell.h
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIBaseDetailCell : UITableViewCell

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 内容
@property (nonatomic, strong) UILabel *commentLabel;

/**
 标题
 */
@property (nonatomic, copy) NSString *titleString;
/**
 内容
 */
@property (nonatomic, copy) NSString *contentString;

@property (nonatomic, strong) UIColor *contentColor;


@end
