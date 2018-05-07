//
//  PIMyWalletHeaderView.m
//  Parking
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyWalletHeaderView.h"

@interface PIMyWalletHeaderView ()

///-- 顶部视图
@property (nonatomic, strong) UIView *topView;
///-- 余额
@property (nonatomic, strong) UILabel *moneyLabel;
///-- 明细按钮
@property (nonatomic, strong) UIButton *detailBtn;
///-- 底部
@property (nonatomic, strong) UIView *bottomView;
///-- 选中按钮
@property (nonatomic, weak) UIButton *selectBtn;
///-- 输入框
@property (nonatomic, strong) UITextField *textField;
@end

@implementation PIMyWalletHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    CGFloat topViewH = 120 * Scale_Y;
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topViewH)];
    self.topView.backgroundColor = PIMainColor;
    [self addSubview:self.topView];
    
    CGFloat btnH = 40 * Scale_Y;
    CGFloat btnW = 100 * Scale_Y;
    CGFloat margin = 15 * Scale_Y;
    
    self.detailBtn = [[UIButton alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"收支明细"];
    self.detailBtn.frame = CGRectMake(SCREEN_WIDTH - btnW - margin, 35 * Scale_Y, btnW, btnH);
    self.detailBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.detailBtn.layer.borderWidth = 1.0;
    self.detailBtn.layer.cornerRadius = 2.0;
    self.detailBtn.clipsToBounds = YES;
    [self.topView addSubview:self.detailBtn];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMinY(self.detailBtn.frame), SCREEN_WIDTH - btnW - 40 * Scale_Y, btnH)];
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:30];
    self.moneyLabel.textColor = [UIColor whiteColor];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2lf", [PILoginTool defaultTool].balance];
    [self.topView addSubview:self.moneyLabel];
    
   
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.frame = CGRectMake(0, topViewH, SCREEN_WIDTH, 350 * Scale_Y - topViewH);
    //self.bottomView.backgroundColor = [UIColor redColor];
    [self addSubview:self.bottomView];
    
    [self setupButton];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20 * Scale_Y, 350 * Scale_Y - 70 * Scale_Y, SCREEN_WIDTH - 40 * Scale_Y, 50 * Scale_Y)];
    
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.layer.cornerRadius = 5.0;
    self.textField.clipsToBounds = YES;
    self.textField.placeholder = @"输入其他金额";
    self.textField.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.textField];
}

- (void)setupButton {
    
    NSArray *arr = @[@"50元", @"100元", @"200元", @"500元", @"1000元"];
    
    CGFloat marginB = 20 * Scale_Y;
    CGFloat margin = 15 * Scale_Y;
    CGFloat btnW = (SCREEN_WIDTH - 2 * margin - 2 * marginB) / 3;
    CGFloat btnH = 50 * Scale_Y;
    int maxCols = 3;
    
    
    for (int i = 0; i < arr.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        
        int row = i / maxCols;
        int col = i % maxCols;
        
        button.y = margin + row * (btnH + margin);
        button.x = marginB + col * (btnW + margin);
        button.width = btnW;
        button.height = btnH;
        
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateDisabled];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [button setTitleColor:txtMainColor forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:PIMainColor] forState:UIControlStateDisabled];
        button.layer.cornerRadius = 5.0;
        button.clipsToBounds = YES;
        button.tag = i;
        
        if (i == 0) {
            
            button.enabled = NO;
            self.selectBtn = button;
        }
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:button];
    }
}

- (void)titleClick:(UIButton *)sender {
    
    // -- 修改按钮状态
    self.selectBtn.enabled = YES;
    sender.enabled = NO;
    self.selectBtn = sender;
    
    
}
@end
