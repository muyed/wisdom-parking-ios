//
//  PIVillageAuthenProgressController.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageAuthenProgressController.h"
#import "PIVillageAuthenProgressView.h"
#import "PIBaseDetailCell.h"

@interface PIVillageAuthenProgressController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) PIVillageAuthenProgressView *authView;
@end

@implementation PIVillageAuthenProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    
   
    self.title = self.authTitle;
    
    CGFloat cellH = 60;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = sepLineColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = cellH;
    
    [self.view addSubview:self.tableView];
    
    self.authView.size = CGSizeMake(SCREEN_WIDTH, 190 * Scale_Y);
    
    self.authView.imageName = self.imageName;
    self.authView.tipTitle = self.tipTitle;
    
    self.tableView.tableHeaderView = self.authView;
    
    [self.tableView registerClass:[PIBaseDetailCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseDetailCell class])];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
    
    
    cell.titleString = self.titleArr[indexPath.row];
    cell.contentString = self.contentArr[indexPath.row];
    cell.commentLabel.textAlignment = NSTextAlignmentRight;
    cell.contentColor = txtSeconColor;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    view.backgroundColor = [UIColor clearColor];
}
- (PIVillageAuthenProgressView *)authView {
    
    if (!_authView) {
        
        _authView = [PIVillageAuthenProgressView new];
        
    }
    
    return _authView;
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
