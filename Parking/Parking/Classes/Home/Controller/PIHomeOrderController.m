//
//  PIHomeOrderController.m
//  Parking
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeOrderController.h"
#import "PIHomeMainView.h"


@interface PIHomeOrderController ()

///-- 主视图
@property (nonatomic, strong) PIHomeMainView *mainView;

@end

@implementation PIHomeOrderController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"彼得潘实业";
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.mainView];
   
    
    weakself
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(50+ NavBarHeight);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(440 * Scale_Y);
    }];
    
    
}


- (void)getMessage {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
    
    
}

- (void)customerClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
}

- (void)orderBtnClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
#pragma mark -- 懒加载
- (PIHomeMainView *)mainView {
    
    if (!_mainView) {
        
        _mainView = [PIHomeMainView new];
        
    }
    
    return _mainView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
