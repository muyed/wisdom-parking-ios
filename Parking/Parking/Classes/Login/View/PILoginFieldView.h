//
//  PILoginFieldView.h
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PILoginFieldView : UIView

///-- 输入框
@property (nonatomic, strong) UITextField *textField;

///-- 是否为获取验证码
@property (nonatomic, assign) BOOL isVerif;

@end
