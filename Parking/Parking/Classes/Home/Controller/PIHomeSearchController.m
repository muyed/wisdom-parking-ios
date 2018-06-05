//
//  PIHomeSearchController.m
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeSearchController.h"
#import "PISearchBar.h"
#import "PIAddressModel.h"

@interface PIHomeSearchController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AMapSearchDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) AMapSearchAPI *search;
///-- <#Notes#>
//@property (nonatomic, weak) PISearchBar *searchBar;
@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation PIHomeSearchController
{
    
    CGFloat _desLat;
    CGFloat _desLon;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[UITextField alloc] init];
    self.searchBar.size = CGSizeMake(SCREEN_WIDTH - 100, 35);
    self.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchBar.layer.borderWidth = 1.5;
    self.searchBar.layer.cornerRadius = 17.5;
    self.searchBar.clipsToBounds = YES;
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.textColor = [UIColor whiteColor];
    self.searchBar.placeholder = @"请输入搜索关键字";
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
//    self.searchBar.leftView = leftView;
//    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    UIButton *rightView = [[UIButton alloc] initWithImageName:@"home_search_white"];
    rightView.size = CGSizeMake(35, 35);
    self.searchBar.leftView = rightView;
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    self.searchBar.delegate = self;
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    [self.searchBar setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.searchBar setValue:PISYS_FONT(15) forKeyPath:@"_placeholderLabel.font"];
    self.navigationItem.titleView = self.searchBar;
//    PISearchBar *searchBar = [PISearchBar searchBar];
//    searchBar.width = 280 * Scale_Y;
//    searchBar.height = 30;
    [self.searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    self.navigationItem.titleView = searchBar;
//    self.searchBar = searchBar;
    
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
}

/** 监听文本框的改变 */
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 0) {
        //_searchBar.searchImageView.selected = YES;
    }
    else {
        //_searchBar.searchImageView.selected = NO;
    }
    
    NSString *str = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length) { // 获取搜索结果
        self.addrssKeyWord = str;
    }
    else {
        [_tableView reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSString *str = [self.searchBar.searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if(str.length) { // 搜索中
//        return self.dataArray.count;
//    }

    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellId = NSStringFromClass([self class]);
    PIAddressModel *model;
    NSString *str = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(str.length) { // 搜索中
        model = self.dataArray[indexPath.row];
    }
//    else {
//        model = self.historyArray[indexPath.row];
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.font = PISYS_FONT(15);
    cell.textLabel.text = model.name;
    
    return cell;
}

#pragma mark AMapSearchDelegate
//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0) {
        return;
    }

    NSMutableArray *tempArray = [NSMutableArray array];
    for (AMapTip *tip in response.tips) {
        PIAddressModel *ads = [[PIAddressModel alloc]init];
        ads.uid = tip.uid;
        ads.name = tip.name;
        ads.district = tip.district;
        ads.address = tip.address;
        ads.adcode = tip.adcode;
        ads.latitude = tip.location.latitude;
        ads.longitude = tip.location.longitude;

        [tempArray addObject:ads];
    }
    self.dataArray = [tempArray copy];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIAddressModel *ads = self.dataArray[indexPath.row];
    
    if (self.destinationCoor) {
        
        self.destinationCoor(ads.latitude, ads.longitude);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
//请求失败
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"----> %@",error.domain);
}


-(void)setAddrssKeyWord:(NSString *)addrssKeyWord
{
    _addrssKeyWord = addrssKeyWord;
    
    //发起输入提示搜索
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = addrssKeyWord;
    tipsRequest.city = self.cityName;
    tipsRequest.cityLimit = YES;
    [_search AMapInputTipsSearch: tipsRequest];
}



- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50) style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.rowHeight = 60;
        tableview.separatorColor = sepLineColor;
        tableview.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        //tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView = tableview;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
