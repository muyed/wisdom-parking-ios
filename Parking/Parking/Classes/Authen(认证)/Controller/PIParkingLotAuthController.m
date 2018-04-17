//
//  PIParkingLotAuthController.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIParkingLotAuthController.h"
#import "PIBaseFieldCell.h"
#import "PIParkingLotAuthCell.h"
#import "PIBottomBtn.h"

@interface PIParkingLotAuthController ()

///-- 立即绑定
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIParkingLotAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加设备";
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    self.tableView.scrollEnabled = NO;
    UIView *footerView = [[UIView alloc] init];
    footerView.size = CGSizeMake(SCREEN_WIDTH, 200);
    
    self.tableView.tableFooterView = footerView;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFont:18 textColor:txtMainColor text:@"温馨提示:"];
    tipLabel.frame = CGRectMake(20, 35, SCREEN_WIDTH - 40, 20);
    
    [footerView addSubview:tipLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFont:16 textColor:txtSeconColor];
    contentLabel.text = @"草在结它的籽，风在摇它的叶子， 我们站着不说话，就十分美好";
    contentLabel.frame = CGRectMake(20, CGRectGetMaxY(tipLabel.frame) + 10, SCREEN_WIDTH - 40, 40);
    contentLabel.numberOfLines = 2;
    [footerView addSubview:contentLabel];
    
    
    self.bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"立即绑定"];
    
    self.bottomBtn.x = 30;
    self.bottomBtn.y = CGRectGetMaxY(self.tableView.frame);
    self.bottomBtn.width = SCREEN_WIDTH - 60;
    self.bottomBtn.height = 50;
    self.bottomBtn.layer.cornerRadius = 50 * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomBtn];
    
    [self.tableView registerClass:[PIBaseFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    [self.tableView registerClass:[PIParkingLotAuthCell class] forCellReuseIdentifier:NSStringFromClass([PIParkingLotAuthCell class])];
}

- (void)buttonClick {
    
    NSLog(@"立即绑定");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        PIBaseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
        
        cell.titleString = @"绑定码";
        cell.placeString = @"请填写绑定码";
        
         return cell;
    }else {
        
        PIParkingLotAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIParkingLotAuthCell class])];
        
        return cell;
    }
   
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        return 80;
    }else {
        
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        return 80;
        
    }else {
        
        return 100;
    }
    
    
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
