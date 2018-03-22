//
//  PILoginField.m
//  Parking
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginField.h"

@implementation PILoginField

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.borderStyle = UITextBorderStyleLine;
        self.layer.borderColor = UIColorFromRGB(0xcdcdcd).CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = YES;
        self.tintColor = PIMainColor;
        UIView *leftView = [UIView new];
        leftView.size = CGSizeMake(8, self.height);
        leftView.backgroundColor = [UIColor whiteColor];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

@end
