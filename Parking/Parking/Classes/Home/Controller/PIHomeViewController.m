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

@end

@implementation PIHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupUI];
    //[self setupMap];
//    PIMapManager *mapManager = [PIMapManager sharedManager];
//    mapManager.mapController = self;
//    [mapManager initMapView];
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
    //[PIMapManager sharedManager].pi_showUserLocation = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    
    CGFloat top = NavBarHeight - 35;
    
    UIButton *btn = [[UIButton alloc] initWithImageName:@"home_message"];
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

- (void)setupUI {
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.customBtn];
   // [self.view addSubview:self.orderBtn];
    
    weakself
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(50+ NavBarHeight);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(240 * Scale_Y);
    }];
    
    [self.customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.view).offset(-15);
        make.top.equalTo(weakSelf.mainView.mas_bottom).offset(10);
        make.height.and.width.mas_equalTo(30);
    }];
    
//    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(weakSelf.view).offset(30);
//        make.right.equalTo(weakSelf.view).offset(-30);
//        make.top.equalTo(weakSelf.customBtn.mas_bottom).offset(20);
//        make.height.mas_equalTo(49);
//    }];
//    
    [self.customBtn addTarget:self action:@selector(customerClick) forControlEvents:UIControlEventTouchUpInside];

    [self.orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomView = [PIHomeBottomView new];
    self.bottomView.x = 0;
    self.bottomView.y = SCREEN_HEIGHT - 150 - TabBarHeight;
    self.bottomView.width = SCREEN_WIDTH;
    self.bottomView.height = 200;
    self.bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
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
        [_customBtn setBackgroundImage:[UIImage imageNamed:@"home_customer"] forState:UIControlStateNormal];
        
    }
    
    return _customBtn;
}

//- (UIButton *)orderBtn {
//
//    if (!_orderBtn) {
//
//        _orderBtn = [[UIButton alloc] initWithFont:17 titleColor:[UIColor whiteColor] title:@"预约"];
//        _orderBtn.backgroundColor = PIMainColor;
//        _orderBtn.layer.cornerRadius = 10;
//        _orderBtn.clipsToBounds = YES;
//    }
//
//    return _orderBtn;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    PILoginViewController *login = [PILoginViewController new];
//    [self.navigationController pushViewController:login animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
