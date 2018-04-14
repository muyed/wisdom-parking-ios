//
//  PIVillageListController.m
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageListController.h"
#import "PIVillageListCell.h"
#import "PIVillageListModel.h"
#import "PISelectCitiesController.h"


@interface PIVillageListController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField * searchBar;

@property (nonatomic, strong) UIButton *cityBtn;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *searchArr;

@end

@implementation PIVillageListController
{
    
    NSInteger _pageIndex;
    NSString *_cityName;
    BOOL _isSearch;
    
}

//- (instancetype)init {
//
//    if (self = [super init]) {
//
//        [self setupNav];
//    }
//
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupUI];
    [self setupRefresh];
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
    
   
    
    CGFloat cellH = 80;
    
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
    
   
    [self.tableView registerClass:[PIVillageListCell class] forCellReuseIdentifier:NSStringFromClass([PIVillageListCell class])];
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
    self.searchBar.placeholder = @"搜索小区";
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
    
    [PINotification addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    CGFloat cityBtnX = CGRectGetMaxX(self.searchBar.frame) + 10 * Scale_Y;
    
    self.cityBtn = [[UIButton alloc] initWithTitle:[PIMapManager sharedManager].districtName];
    self.cityBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.cityBtn.frame = CGRectMake(cityBtnX, 22, SCREEN_WIDTH - cityBtnX - 15 * Scale_Y, 35);
    [self.cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav addSubview:self.cityBtn];
    
    [self.cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer= [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   
}

- (void)textChange {
    
    if (self.searchBar.hasText) {
        
        _isSearch = YES;
    }else {
        
        _isSearch = NO;
        
        [self.tableView reloadData];
    }
}

- (void)loadNewData {
    
    _pageIndex = 1;
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNo"] = @(_pageIndex);
    params[@"pageSize"] = @(20);
    
    if (_isSearch) {
        
        params[@"communityName"] = self.searchBar.text.cancelSpace;
        params[@"area"] =  _cityName.length > 0 ? _cityName : [PIMapManager sharedManager].districtName;
    }
   
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];
    
    if (_isSearch) {
        
        if (self.searchArr.count > 0) {
            
            [self.searchArr removeAllObjects];
        }
        
    }else {
        
        if (self.dataArr.count > 0) {
            
            [self.dataArr removeAllObjects];
        }
    }
    
    
    weakself
    [PIHttpTool piGet:urlPath(@"api/community/list") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIVillageListModel *listModel = [PIVillageListModel mj_objectWithKeyValues:response];
        
        if (listModel.code == 200) {
            
            if (_isSearch) {
                
                 [weakSelf.searchArr addObjectsFromArray:listModel.data];
                
            }else {
                
                 [weakSelf.dataArr addObjectsFromArray:listModel.data];
            }
           
            
            [weakSelf.tableView reloadData];
            
        }else {
            
            [MBProgressHUD showMessage:listModel.errMsg];
        }
        
        
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"获取失败!"];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}

- (void)loadMoreData {
    
    [self.tableView.mj_header endRefreshing];
   
    _pageIndex ++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNo"] = @(_pageIndex);
    params[@"pageSize"] = @(20);
    
    // params[@"area"] = _cityName.length > 0 ? _cityName ? [PIMapManager sharedManager].districtName;
    
    [MBProgressHUD showIndeterWithMessage:@"正在加载..."];

    
    weakself
    [PIHttpTool piGet:urlPath(@"api/community/list") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIVillageListModel *listModel = [PIVillageListModel mj_objectWithKeyValues:response];
        
        if (listModel.code == 200) {
            
            [weakSelf.dataArr addObjectsFromArray:listModel.data];
            
            [weakSelf.tableView reloadData];
            
        }else {
            
            _pageIndex -- ;
            [MBProgressHUD showMessage:listModel.errMsg];
        }
        
        [weakSelf.tableView.mj_footer endRefreshing];
       
    } failure:^(NSError *error) {
        
        _pageIndex -- ;
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"获取失败!"];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if (textField.text.cancelSpace.length > 0) {
        
        _isSearch = YES;
        [self loadNewData];
        
    }else {
        
        _isSearch = NO;
    }
   
    
    
    return YES;
}
- (void)cityBtnClick {
    
    PISelectCitiesController *select = [PISelectCitiesController new];
    
    weakself
    [select setSelectCityName:^(NSString *cityName) {
        
        [weakSelf.cityBtn setTitle:cityName forState:UIControlStateNormal];
        _cityName = cityName;
    }];
    
    [self.navigationController pushViewController:select animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _isSearch ? self.searchArr.count : self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIVillageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIVillageListCell class])];
    
    cell.model = _isSearch ? self.searchArr[indexPath.row] : self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIVillageDataModel *model = _isSearch ? self.searchArr[indexPath.row] : self.dataArr[indexPath.row];
    
    if (self.villageID) {
        
        self.villageID(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (NSMutableArray *)searchArr {
    
    if (!_searchArr) {
        
        _searchArr = [NSMutableArray array];
    }
    
    return _searchArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
