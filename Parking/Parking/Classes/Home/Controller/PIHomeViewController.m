//
//  PIHomeViewController.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeViewController.h"
#import "PILoginViewController.h"

#import "PIHomeItemView.h"
#import "PIHomeMainView.h"
#import "PIHomeBottomView.h"
#import "PIHomeOrderController.h"
#import "PICodeViewController.h"
#import "PINavigationController.h"
#import "PIComCertifiController.h"
#import "PIAddCarController.h"
#import "PIVillageOrderController.h"
#import "PIPayTool.h"
#import "PIBaseModel.h"
#import "PIMineViewController.h"
#import "PIHomeSearchController.h"
#import "PIPublishOrderController.h"
#import "PIPayForCashController.h"
#import "PIWXPayModel.h"
#import "PIHomeSearchCarPortController.h"
#import "PICustomAnnotation.h"
#import "PICustomAnnotationView.h"
#import "PICarpotOrderView.h"
#import "PICarportModel.h"
#import "PIHomeNaviDriveController.h"
#import "PIMatchCarportController.h"


@interface PIHomeViewController ()<MAMapViewDelegate,PIHomeBottomDelegate>

///-- 地图
@property (nonatomic, weak) MAMapView *mapView;
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

///-- 个人中心
@property (nonatomic, strong) UIButton *locationBtn;

@property (nonatomic, strong) PICarpotOrderView *carpotOrderView;

@end

@implementation PIHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self setupNav];
    //[self setupTopBtn];
    
   
    //[self setupMap];
    PIMapManager *mapManager = [PIMapManager sharedManager];
    
    mapManager.mapController = self;
    [mapManager initMapView];
    mapManager.mapView.delegate = self;
    self.mapView = mapManager.mapView;

    [self setupUI];
    
    self.carpotOrderView = [PICarpotOrderView carportOrderView];
    
    weakself
    [self.carpotOrderView setBeginNavToCarport:^(PICarportDataModel *dataModel) {
        
        NSLog(@"----> %@", dataModel.communityName);
        PIHomeNaviDriveController *naviDrive = [PIHomeNaviDriveController new];
        naviDrive.startCoor = weakSelf.mapView.userLocation.coordinate;
        
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(29.383783, 120.151287);
        naviDrive.destinationCoor = coor;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController pushViewController:naviDrive animated:YES];
        });
        
    }];
    
    [self.carpotOrderView setBeginMatchCarport:^(PICarportDataModel *dataModel) {
        
        PIMatchCarportController *matchVC = [PIMatchCarportController new];
        matchVC.dataModel = dataModel;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController pushViewController:matchVC animated:YES];
        });
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat lon = self.mapView.userLocation.location.coordinate.longitude;
        CGFloat lat = self.mapView.userLocation.location.coordinate.latitude;
        
        [self loadDataWithLat:lat lon:lon];
        
    });
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
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
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
    
//    UIButton *leftBtn = [[UIButton alloc] initWithTitle:@"+"];
//    leftBtn.x = 20;
//    leftBtn.y = top;
//    leftBtn.width = 25;
//    leftBtn.height = 25;
//    [leftBtn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
//    [nav addSubview:leftBtn];
    
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
    
//    PIVillageOrderController *village = [PIVillageOrderController new];
//    
//    [self.navigationController pushViewController:village animated:YES];
}

- (void)publish {
    
    PIPayForCashController *publish = [PIPayForCashController new];
    
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)setupUI {
    
    //[self.view addSubview:self.mainView];
    [self.view addSubview:self.customBtn];
    [self.view addSubview:self.orderBtn];
    [self.view addSubview:self.tipBtn];
    [self.view addSubview:self.personBtn];
    [self.view addSubview:self.locationBtn];
    
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
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.view).offset(-20 * Scale_X);
        make.bottom.equalTo(weakSelf.orderBtn.mas_top).offset(-20 );
        make.height.and.width.mas_equalTo(btnW);
    }];
    
    self.customBtn.layer.cornerRadius = btnW * 0.5;
    self.customBtn.clipsToBounds = YES;
    
    self.tipBtn.layer.cornerRadius = btnW * 0.5;
    self.tipBtn.clipsToBounds = YES;
    
    self.personBtn.layer.cornerRadius = btnW * 0.5;
    self.personBtn.clipsToBounds = YES;
    
    self.locationBtn.layer.cornerRadius = btnW * 0.5;
    self.locationBtn.clipsToBounds = YES;
    
    [self.customBtn addTarget:self action:@selector(customerClick) forControlEvents:UIControlEventTouchUpInside];

    [self.orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tipBtn addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.personBtn addTarget:self action:@selector(personBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.locationBtn addTarget:self action:@selector(locationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.bottomView = [PIHomeBottomView new];
//    self.bottomView.x = 0;
//    self.bottomView.y = SCREEN_HEIGHT - 150 - TabBarHeight;
//    self.bottomView.width = SCREEN_WIDTH;
//    self.bottomView.height = 200;
//    self.bottomView.delegate = self;
//    [self.view addSubview:self.bottomView];
}

- (void)loadDataWithLat:(CGFloat)lat lon:(CGFloat)lon {
    
    NSString *lonStr = [NSString stringWithFormat:@"%lf", lon];
    NSString *latStr = [NSString stringWithFormat:@"%lf", lat];
//    NSString *lon = [NSString stringWithFormat:@"%lf", self.mapView.userLocation.location.coordinate.longitude];
//    NSString *lat = [NSString stringWithFormat:@"%lf", self.mapView.userLocation.location.coordinate.latitude];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%d", urlPath(@"api/share/loadByDistance"), lonStr, latStr, 20];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    if (dataArr.count > 0) {
        
        [self.mapView removeAnnotations:dataArr];
        [dataArr removeAllObjects];
    }
    
    weakself
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        PICarportModel *model = [PICarportModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            for (PICarportDataModel *dataModel in model.data) {
                
                CLLocationCoordinate2D coor ;
                coor.latitude = dataModel.lat;
                coor.longitude = dataModel.lon;
                
                PICustomAnnotation *pointAnnotation = [[PICustomAnnotation alloc] init];
                
                pointAnnotation.coordinate = coor;
                pointAnnotation.icon = @"park_da";
                pointAnnotation.model = dataModel;
                [dataArr addObject:pointAnnotation];
            }
            
            [weakSelf.mapView addAnnotations:dataArr];
            //[weakSelf.mapView showAnnotations:dataArr animated:YES];
            [weakSelf.mapView showAnnotations:dataArr edgePadding:UIEdgeInsetsMake(10, 10, 10, 10) animated:YES];
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
}


/**自定义大头针*/

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    // 自定义大头针
    if ([annotation isKindOfClass:[PICustomAnnotation class]]) {
        PICustomAnnotationView *annoView = [PICustomAnnotationView annotationViewWithMap:mapView];
        //        annoView.canShowCallout= YES;
        //        annoView.draggable = YES;
        annoView.annotation = annotation;
        return annoView;
    }
    return nil;
    
}

/*点击大头针*/
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    
    if ([view isKindOfClass:[PICustomAnnotationView class]]) {
        
        PICustomAnnotationView *annotationView = (PICustomAnnotationView *)view;
        
        self.carpotOrderView.dataModel = annotationView.dataModel;
        
        [self.carpotOrderView show];
        
        //NSLog(@"%lf", view.annotation.coordinate.latitude);
    }
    
}


- (void)getMessage {
    
    //[MBProgressHUD showMessage:@"正在努力建设中...."];
    
//    PIHomeOrderController *order = [PIHomeOrderController new];
//
//    [self.navigationController pushViewController:order animated:YES];
    
//    PIComCertifiController *comCer = [PIComCertifiController new];
//
//    [self.navigationController pushViewController:comCer animated:YES];
    
//    PIAddCarController *addCar = [PIAddCarController new];
//
//    [self.navigationController pushViewController:addCar animated:YES];
    
    
    PIHomeSearchController *search = [PIHomeSearchController new];
    search.cityName = [PIMapManager sharedManager].cityName;
    
    weakself
    [search setDestinationCoor:^(CGFloat lat, CGFloat lon) {
        
    
        [weakSelf loadDataWithLat:lat lon:lon];
    }];
    
//    PIHomeSearchCarPortController *carPot = [PIHomeSearchCarPortController new];
//
//    carPot.lon = self.mapView.userLocation.location.coordinate.longitude;
//    carPot.lat = self.mapView.userLocation.location.coordinate.latitude;
    
    [self.navigationController pushViewController:search animated:YES];
    
}

- (void)customerClick {
    
    [PIPayTool withdrawCashWithBankCardID:@"2" success:^(id response) {
        
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        NSLog(@"%@", model.errMsg);
        
        if (model.code == 200) {
            
            [MBProgressHUD showMessage:@"提现成功"];
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
            
        }
        
        
    } failue:^(NSError *error) {
        
        
    }];
    
    
    //[MBProgressHUD showMessage:@"正在努力建设中...."];
//    [MBProgressHUD showIndeterWithMessage:@"请稍等..."];
    
//    [PIHttpTool piGet:urlPath(@"api/account/payCash") params:nil success:^(id response) {
//
//        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
//
//        if (model.code == 24) {
//
//            [PINotification postNotificationName:PIPayForCashNotifation object:nil];
//        }
//        NSLog(@"%@", model.errMsg);
//
//    } failure:^(NSError *error) {
//
//
//    }];
    
//    [PIPayTool payForAcountCash:^(NSString *orderNum) {
//
//        [PIPayTool WXpayForOrderWithOrderNum:orderNum];
//
////        [PIPayTool WXpayForOrderWithOrderNum:orderNum success:^(id response) {
////
////          // PIWXPayModel *model = [PIWXPayModel mj_objectWithKeyValues:response];
////
////
////        } failue:^(NSError *error) {
////
////
////        }];
//    }];
    
    
//
//    [PIPayTool AlipayForOrderWithOrderNum:@"CD20180401223909773229" success:^(id response) {
//
//        [MBProgressHUD hideHUD];
//
//        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
//
//        if (model.code == 200) {
//
//            [[AlipaySDK defaultService] payOrder:model.data fromScheme:@"wisdompark" callback:^(NSDictionary *resultDic) {
//
//                NSLog(@"%@", resultDic);
//
//            }];
//
//        }else {
//
//            [MBProgressHUD showMessage:model.errMsg];
//        }
//
//    } failue:^(NSError *error) {
//
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showMessage:@"支付失败"];
//    }];

    
}

- (void)tipBtnClick {
    
   // [MBProgressHUD showMessage:@"正在努力建设中...."];
    
   
    [PILoginTool loginOut];
}

- (void)locationBtnClick {
    
     [PINotification postNotificationName:@"ScrollToUserLoaction" object:nil];
}

- (void)personBtnClick {
    
    //[MBProgressHUD showMessage:@"正在努力建设中...."];
    
    //[PILoginTool loginOut];
    
    PIMineViewController *mineView = [PIMineViewController new];
    
    [self.navigationController pushViewController:mineView animated:YES];
}
     
- (void)orderBtnClick {
    
    
    PIHomeOrderController *order = [PIHomeOrderController new];
    
    [self.navigationController pushViewController:order animated:YES];
    
//    PICodeViewController *code = [[PICodeViewController alloc] init];
//    code.errorString = @"请您扫描有效的二维码哦！";
//    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:code];
//
//
//    code.codeBlock = ^(NSString *code) {
//        //        self.codeView.textF.text = code;
//
//    };
//    [self.navigationController presentViewController:nac animated:YES completion:nil];
    
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

- (UIButton *)locationBtn {
    
    if (!_locationBtn) {
        
        _locationBtn = [[UIButton alloc] init];
        [_locationBtn setImage:[UIImage imageNamed:@"home_location"] forState:UIControlStateNormal];
        
        _locationBtn.backgroundColor = [UIColor whiteColor];
        _locationBtn.layer.borderColor = sepLineColor.CGColor;
        _locationBtn.layer.borderWidth = 0.5;
    }
    
    return _locationBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
