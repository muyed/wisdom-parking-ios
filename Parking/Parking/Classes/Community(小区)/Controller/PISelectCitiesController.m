//
//  PISelectCitiesController.m
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PISelectCitiesController.h"
#import "PIProvonceModel.h"

@interface PISelectCitiesController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<PIProvonceModel *> *provonceArr;

@end

@implementation PISelectCitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市";
    
    [self setupUI];
}

- (void)setupUI {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@".plist"];
    
    self.provonceArr = [PIProvonceModel mj_objectArrayWithFile:path];
    NSLog(@"%lu", self.provonceArr.count);
    
    CGFloat cellH = 70;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = sepLineColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.tableView.scrollEnabled = NO;
    
    self.tableView.rowHeight = cellH;
    [self.view addSubview:self.tableView];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.provonceArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return section == 0 ? 1 : self.provonceArr[section - 1].Cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
  
    cell.textLabel.text = indexPath.section == 0 ? [PIMapManager sharedManager].districtName : self.provonceArr[indexPath.section - 1].Cities[indexPath.row].city;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    return section == 0 ? @"   定位城市" : [NSString stringWithFormat:@"    %@", self.provonceArr[section - 1].State];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *city = indexPath.section == 0 ? [PIMapManager sharedManager].districtName : self.provonceArr[indexPath.section - 1].Cities[indexPath.row].city;
    
    if (self.selectCityName) {
        
        self.selectCityName(city);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableArray *)provonceArr {
    
    if (!_provonceArr) {
        
        _provonceArr = [NSMutableArray array];
    }
    
    return _provonceArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
