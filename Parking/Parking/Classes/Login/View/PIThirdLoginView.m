//
//  PIThirdLoginView.m
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIThirdLoginView.h"


@implementation PIThirdLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20 * Scale_X);
    label.text = @"----- 其它方式登录 -----";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = PISmallFont;
    label.textColor = txtSeconColor;
    [self addSubview:label];
    
    CGFloat marginB = 60 * Scale_X;
    CGFloat margin = 30 * Scale_X;
    CGFloat bottonWH = (SCREEN_WIDTH - 2 * marginB - 2 * margin) / 3;
    
    for (NSInteger i  = 0; i < 3; i++) {
        
        UIButton *button = [UIButton new];
        button.x = marginB + i * (bottonWH + margin);
        button.y = CGRectGetMaxY(label.frame) + 20 * Scale_X;
        button.width = bottonWH;
        button.height = bottonWH;
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"share%lu", i]] forState:UIControlStateNormal];
        [self addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick:(UIButton *)sender {
    
    NSLog(@"%lu", sender.tag);
}
@end
