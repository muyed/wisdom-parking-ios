//
//  PIHomeSearchCarPortController.m
//  Parking
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeSearchCarPortController.h"
#import "PIHomeSearchCarPortCell.h"
#import "PICarportModel.h"

@interface PIHomeSearchCarPortController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField * searchBar;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *searchArr;
///-- <#Notes#>
@property (nonatomic, strong) PICarportModel *dataModel;
@end

@implementation PIHomeSearchCarPortController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


- (void)setupUI {
    
    CGFloat cellH = 160;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = sepLineColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.tableView.scrollEnabled = NO;
    self.tableView.estimatedRowHeight = cellH;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PIHomeSearchCarPortCell class] forCellReuseIdentifier:NSStringFromClass([PIHomeSearchCarPortCell class])];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    
    NSString *lon = [NSString stringWithFormat:@"%lf", self.lon];
    NSString *lat = [NSString stringWithFormat:@"%lf", self.lat];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%d", urlPath(@"api/share/loadByDistance"), lon, lat, 20];
    
    weakself
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
         weakSelf.dataModel = [PICarportModel mj_objectWithKeyValues:response];
        
        if (weakSelf.dataModel.code == 200) {
            
            [weakSelf.tableView reloadData];
            
        }else {
            
            [MBProgressHUD showMessage:weakSelf.dataModel.errMsg];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}
- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    
    CGFloat top = NavBarHeight - 39;
    
    UIButton *btn = [[UIButton alloc] initWithImageName:@"navgation-back"];
    btn.x =  15;
    btn.y = top;
    btn.width = 25;
    btn.height = 25;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:btn];
    
    
    self.searchBar = [[UITextField alloc] init];
    self.searchBar.frame = CGRectMake(25 + 20 * Scale_Y, 22, SCREEN_WIDTH - 130, 35);
    self.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchBar.layer.borderWidth = 1.5;
    self.searchBar.layer.cornerRadius = 17.5;
    self.searchBar.clipsToBounds = YES;
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.textColor = [UIColor whiteColor];
    self.searchBar.placeholder = @"请输入搜索关键字";
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
    self.searchBar.leftView = leftView;
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    UIButton *rightView = [[UIButton alloc] initWithImageName:@"home_search_white"];
    rightView.size = CGSizeMake(35, 35);
    self.searchBar.rightView = rightView;
    self.searchBar.rightViewMode = UITextFieldViewModeAlways;
    self.searchBar.delegate = self;
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    [self.searchBar setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchBar setValue:PISYS_FONT(15) forKeyPath:@"_placeholderLabel.font"];
    [nav addSubview:self.searchBar];
    
    //[PINotification addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    CGFloat cityBtnX = CGRectGetMaxX(self.searchBar.frame) + 10 * Scale_Y;
    
    self.cityBtn = [[UIButton alloc] initWithTitle:@"地图"];
    self.cityBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.cityBtn.frame = CGRectMake(cityBtnX, 22, SCREEN_WIDTH - cityBtnX - 15 * Scale_Y, 35);
    [self.cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav addSubview:self.cityBtn];
    
    [self.cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)cityBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIHomeSearchCarPortCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIHomeSearchCarPortCell class])];
    
    cell.dataModel = self.dataModel.data[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
