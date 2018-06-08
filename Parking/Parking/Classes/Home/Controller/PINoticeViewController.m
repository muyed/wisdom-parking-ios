//
//  PINoticeViewController.m
//  Parking
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PINoticeViewController.h"
#import "PINoticeModel.h"

@interface PINoticeViewController ()

///-- 标题
@property (nonatomic, strong) UILabel *titleLabel;
///-- 内容
@property (nonatomic, strong) UITextView *bodyView;

@end

@implementation PINoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.bodyView];
    
    weakself
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(15);
        make.right.equalTo(weakSelf.view).offset(-15);
        make.top.equalTo(weakSelf.view).offset(15 + NavBarHeight);
    }];
    
    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.view).offset(10);
        make.right.equalTo(weakSelf.view).offset(-10);
        make.bottom.equalTo(weakSelf.view).offset(-(TabBarHeight - 50 ) - 10);
    }];
    
    self.titleLabel.text = self.noticeData.title;
    self.bodyView.text = self.noticeData.body;
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFont:20 textColor:txtMainColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UITextView *)bodyView {
    
    if (!_bodyView) {
        
        _bodyView = [[UITextView alloc] init];
        _bodyView.font = PISYS_FONT(18);
        _bodyView.textColor = txtMainColor;
        _bodyView.editable = NO;
    }
    
    return _bodyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
