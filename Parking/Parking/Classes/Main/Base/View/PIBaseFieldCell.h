//
//  PIBaseFieldCell.h
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PIBaseFieldCellDelegate <NSObject>

- (void)pi_textFieldEndEidting:(UITextField *)textField index:(NSInteger)index;

@end

@interface PIBaseFieldCell : UITableViewCell

@property (nonatomic, weak) id <PIBaseFieldCellDelegate> pi_delegate;
/**
 标题
 */
@property (nonatomic, copy) NSString *titleString;

/**
 预留字
 */
@property (nonatomic, copy) NSString *placeString;

/**
 下标
 */
@property (nonatomic, assign) NSInteger index;

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 内容
@property (nonatomic, strong) UITextField *textField;

@end
