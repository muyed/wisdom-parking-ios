//
//  PIHomeViewController.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeViewController.h"
#import "PILoginViewController.h"
#import "PIMapManager.h"
#import "PIHomeItemView.h"
#import "PIHomeMainView.h"
#import "PIHomeBottomView.h"
#import "PIHomeOrderController.h"
#import "PICodeViewController.h"
#import "PINavigationController.h"
#import "PIComCertifiController.h"


@interface PIHomeViewController ()<MAMapViewDelegate, PIHomeBottomDelegate>

///-- 地图
@property (nonatomic, strong) MAMapView *mapView;
///-- 主视图
@property (nonatomic, strong) PIHomeMainView *mainView;
///-- 客服
@property (nonatomic, strong) UIButton *customBtn;
///-- 预约
@property (nonatomic, strong) PIHomeBottomView *bottomView;
///-- 预约
@property (nonatomic, strong) UIButton *orderBtn;
///-- 导航
@property (nonatomic, weak) UIView *navView;
///-- 当前选中的按钮
@property (nonatomic, weak) UIButton *selectButton;
///-- 提醒
@property (nonatomic, strong) UIButton *tipBtn;
///-- 个人中心
@property (nonatomic, strong) UIButton *personBtn;

@end

@implementation PIHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    [self setupTopBtn];
    
   
    //[self setupMap];
    PIMapManager *mapManager = [PIMapManager sharedManager];
    mapManager.mapController = self;
    [mapManager initMapView];
    
     [self setupUI];
//
//    PIHomeItemView *categaryView = [[PIHomeItemView alloc] initWithFrame:CGRectMake(15, NavBarHeight, SCREEN_WIDTH - 30, 54)];
//
//    [self.view addSubview:categaryView];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    ///-- 开启定位功能
    [PIMapManager sharedManager].pi_showUserLocation = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight + 60 )];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    self.navView = nav;
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"彼得潘实业";
    label.font = [UIFont boldSystemFontOfSize:18.0];
    CGFloat top = NavBarHeight - 34;
    label.frame = CGRectMake(0, top, SCREEN_WIDTH, 24);
    
    [nav addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithImageName:@"home_search_white"];
    btn.x = SCREEN_WIDTH - 50;
    btn.y = top;
    btn.width = 25;
    btn.height = 25;
    [btn addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:btn];
    
//    UIBarButtonItem *rightBtn = [UIBarButtonItem itemWithImage:@"home_message" target:self action:@selector(getMessage)];
//
//    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
   // self.navigationController.navigationBar.alpha = 0.0;
}

- (void)setupTopBtn {
    
    CGFloat buttonHeight = 44;
    CGFloat buttonWidth = 100;
    CGFloat buttonMargin = 50;
    CGFloat buttonM = SCREEN_WIDTH - 2 * (buttonMargin + buttonWidth);
    
    NSArray *arr = @[@"公共车位", @"小区预约"];
    
    for (NSInteger i = 0; i < 2; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.height = buttonHeight;
        button.width = buttonWidth;
        button.x = i * (buttonM + buttonWidth) + buttonMargin ;
        button.y = NavBarHeight + 60  - 15 - buttonHeight;
        button.layer.cornerRadius = buttonHeight * 0.5;
        button.clipsToBounds = YES;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageWithColor:secondMainColor] forState:UIControlStateDisabled];
        
         [button setBackgroundImage:[UIImage imageWithColor:PIMainColor] forState:UIControlStateNormal];
        
        button.tag = i;
        
        if (i == 0) {
            
            button.enabled = NO;
            self.selectButton = button;
            // -- 让按钮内部的Label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
           
        }
        
        [self.navView addSubview:button];
    }
}

- (void)titleClick:(UIButton *)sender {
    
    // -- 修改按钮状态
    self.selectButton.enabled = YES;
    sender.enabled = NO;
    self.selectButton = sender;
    
}


- (void)setupUI {
    
    //[self.view addSubview:self.mainView];
    [self.view addSubview:self.customBtn];
    [self.view addSubview:self.orderBtn];
    [self.view addSubview:self.tipBtn];
    [self.view addSubview:self.personBtn];
    
    CGFloat btnW = 50 * Scale_X;
    weakself
//    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(weakSelf.view).offset(50+ NavBarHeight);
//        make.centerX.equalTo(weakSelf.view);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(440 * Scale_Y);
//    }];
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(90);
        make.right.equalTo(weakSelf.view).offset(-90);
        make.bottom.equalTo(weakSelf.view).offset(-(NavBarHeight + 10));
        make.height.mas_equalTo(70);
    }];
    
    [self.customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view).offset(20 * Scale_X);
        make.bottom.equalTo(weakSelf.orderBtn.mas_top).offset(-20 );
        make.height.and.width.mas_equalTo(btnW);
    }];
    
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.customBtn.mas_left);
        make.centerY.equalTo(weakSelf.orderBtn.mas_centerY);
        make.height.and.width.mas_equalTo(btnW);
    }];
    
    [self.personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(weakSelf.view).offset(-20 * Scale_X);
        make.centerY.equalTo(weakSelf.orderBtn.mas_centerY);
        make.height.and.width.mas_equalTo(btnW);
    }];
    
    self.customBtn.layer.cornerRadius = btnW * 0.5;
    self.customBtn.clipsToBounds = YES;
    
    self.tipBtn.layer.cornerRadius = btnW * 0.5;
    self.tipBtn.clipsToBounds = YES;
    
    self.personBtn.layer.cornerRadius = btnW * 0.5;
    self.personBtn.clipsToBounds = YES;
    
    [self.customBtn addTarget:self action:@selector(customerClick) forControlEvents:UIControlEventTouchUpInside];

    [self.orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tipBtn addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.personBtn addTarget:self action:@selector(personBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.bottomView = [PIHomeBottomView new];
//    self.bottomView.x = 0;
//    self.bottomView.y = SCREEN_HEIGHT - 150 - TabBarHeight;
//    self.bottomView.width = SCREEN_WIDTH;
//    self.bottomView.height = 200;
//    self.bottomView.delegate = self;
//    [self.view addSubview:self.bottomView];
}


- (void)getMessage {
    
    //[MBProgressHUD showMessage:@"正在努力建设中...."];
    
//    PIHomeOrderController *order = [PIHomeOrderController new];
//
//    [self.navigationController pushViewController:order animated:YES];
    
    PIComCertifiController *comCer = [PIComCertifiController new];
    
    [self.navigationController pushViewController:comCer animated:YES];
}

- (void)customerClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
}

- (void)tipBtnClick {
    
    [MBProgressHUD showMessage:@"正在努力建设中...."];
}

- (void)personBtnClick {
    
    //[MBProgressHUD showMessage:@"正在努力建设中...."];
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        PINavigationController  *nav = [[PINavigationController alloc] initWithRootViewController:[[PILoginViewController alloc] init]];
        
        [PIUserDefaults removeObjectForKey:SessionId];
        [PIUserDefaults synchronize];
        //重新设置窗口的根视图
        window.rootViewController = nav;
        
        [UIView setAnimationsEnabled:oldState];
        
    } completion:^(BOOL finished) {
        
        
    }];

}
     
- (void)orderBtnClick {
    
    PICodeViewController *code = [[PICodeViewController alloc] init];
    code.errorString = @"请您扫描有效的二维码哦！";
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:code];
    
    
    code.codeBlock = ^(NSString *code) {
        //        self.codeView.textF.text = code;
        
    };
    [self.navigationController presentViewController:nac animated:YES completion:nil];
    
}
- (void)buttonStateChanged:(BOOL)change {
    
    if (change) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.bottomView.y = SCREEN_HEIGHT - TabBarHeight + 25;
        }];
        
    }else {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.bottomView.y =  SCREEN_HEIGHT - 150 - TabBarHeight;
        }];
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    //[self.view endEditing:YES];
//    
//    PIHomeOrderController *order = [PIHomeOrderController new];
//    
//    [self.navigationController pushViewController:order animated:YES];
//}
#pragma mark -- 懒加载
- (PIHomeMainView *)mainView {
    
    if (!_mainView) {
        
        _mainView = [PIHomeMainView new];
        
    }
    
    return _mainView;
}

- (UIButton *)customBtn {
    
    if (!_customBtn) {
        
        _customBtn = [[UIButton alloc] init];
        [_customBtn setImage:[UIImage imageNamed:@"home_customer"] forState:UIControlStateNormal];
        _customBtn.backgroundColor = [UIColor whiteColor];
        _customBtn.layer.borderColor = sepLineColor.CGColor;
        _customBtn.layer.borderWidth = 0.5;
        
    }
    
    return _customBtn;
}

- (UIButton *)orderBtn {

    if (!_orderBtn) {

        _orderBtn = [[UIButton alloc] initWithFont:18 titleColor:[UIColor whiteColor] title:@"立即开锁"];
        [_orderBtn setImage:[UIImage imageNamed:@"home_swap_white"] forState:UIControlStateNormal];
        
        _orderBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _orderBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        _orderBtn.backgroundColor = PIMainColor;
        _orderBtn.layer.cornerRadius = 35;
        _orderBtn.clipsToBounds = YES;
    }

    return _orderBtn;
}

- (UIButton *)tipBtn {
    
    if (!_tipBtn) {
        
        _tipBtn = [[UIButton alloc] init];
        [_tipBtn setImage:[UIImage imageNamed:@"home_rolling"] forState:UIControlStateNormal];
        _tipBtn.backgroundColor = [UIColor whiteColor];
        _tipBtn.layer.borderColor = sepLineColor.CGColor;
        _tipBtn.layer.borderWidth = 0.5;
    }
    
    return _tipBtn;
}

- (UIButton *)personBtn {
    
    if (!_personBtn) {
        
        _personBtn = [[UIButton alloc] init];
        [_personBtn setImage:[UIImage imageNamed:@"home_person_center"] forState:UIControlStateNormal];
        
        _personBtn.backgroundColor = [UIColor whiteColor];
        _personBtn.layer.borderColor = sepLineColor.CGColor;
        _personBtn.layer.borderWidth = 0.5;
    }
    
    return _personBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
