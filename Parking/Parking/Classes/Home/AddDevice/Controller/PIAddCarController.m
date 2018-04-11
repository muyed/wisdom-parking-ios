//
//  PIAddCarController.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddCarController.h"
#import "PIAddCarView.h"
#import "PIBottomBtn.h"
#import "PIBaseModel.h"

@interface PIAddCarController ()

@property (nonatomic, strong) PIAddCarView *addCarView;
///-- 背景
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;
///-- 底部按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIAddCarController
{
    
    NSString *_carNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加车牌";
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.addCarView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.bottomBtn];
    
    weakself
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(10 * Scale_X + NavBarHeight);
        make.height.mas_equalTo(250 * Scale_X);
        make.width.mas_equalTo(SCREEN_WIDTH);
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backView).offset(16 * Scale_X);
        make.left.equalTo(weakSelf.backView).offset(15 * Scale_X);
        make.right.equalTo(weakSelf.backView).offset(-15 * Scale_X);
    }];
    
    [self.addCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.backView).offset(60 * Scale_X);
        make.height.mas_equalTo(50 * Scale_X);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView).offset(btnBorderM);
        make.right.equalTo(weakSelf.backView).offset(-btnBorderM);
        make.bottom.equalTo(weakSelf.backView).offset(-btnBorderM);
        make.height.mas_equalTo(50 * Scale_X);
    }];
    
    self.bottomBtn.layer.cornerRadius = 50 * Scale_X * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)bottomBtnClick {
    
    if (_carNum.length < 7) {
        
        [MBProgressHUD showMessage:@"请输入正确的车牌"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"license"] = _carNum;
    
    [MBProgressHUD showIndeterWithMessage:@"正在添加..."];
    
    [PIHttpTool piPost:urlPath(@"api/carLicense/add") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"添加成功"];
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
       
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        
    }];
}
- (PIAddCarView *)addCarView
{
    if (!_addCarView)
    {
        _addCarView = [[PIAddCarView alloc] init];
       // __weak typeof(self) weakSelf = self;
        _addCarView.completionBlock = ^(NSString *password) {
            //__strong typeof(weakSelf) strongSelf = weakSelf;
//            if ([strongSelf.delegate respondsToSelector:@selector(didPasswordInputFinished:)])
//            {
//                [strongSelf.delegate didPasswordInputFinished:password];
//            }
            
            _carNum = password;
            
            NSLog(@"%@", password);
            
        };
    }
    return _addCarView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = txtMainColor;
        _titleLabel.font = PISYS_FONT(16);
        _titleLabel.text = @"车牌号：";
    }
    return _titleLabel;
}
- (UIView *)backView {
    
    if (!_backView) {
        
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backView;
}

- (PIBottomBtn *)bottomBtn {
    
    if (!_bottomBtn) {
        
        _bottomBtn = [PIBottomBtn new];
        _bottomBtn.backgroundColor = PIMainColor;
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    return _bottomBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
