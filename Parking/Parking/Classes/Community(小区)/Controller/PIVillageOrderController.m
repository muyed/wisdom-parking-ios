//
//  PIVillageOrderController.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//  预约车位

#import "PIVillageOrderController.h"
#import "PIVillageCommnViewCell.h"
#import "PIVillageSelectCell.h"
#import "PIVillageTypeCell.h"
#import "PIVillageFieldCell.h"
#import "PIBottomBtn.h"

@interface PIVillageOrderController ()<UITableViewDelegate, UITableViewDataSource>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 数据源
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation PIVillageOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"小区名称", @"为自己预约", @"为访客预约", @"车牌号码", @"开始时间", @"结束时间"];
    [self setupTableView];
    
}

- (void)setupTableView {
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"公共车位", @"小区预约"]];
    seg.size = CGSizeMake(200, 30);
    seg.tintColor = [UIColor whiteColor];
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    
    CGFloat cellH = 60 * Scale_Y;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight + 20 * Scale_Y, SCREEN_WIDTH, self.dataArr.count * cellH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = cellH;
    self.tableView.scrollEnabled = NO;
    //self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    //self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[PIVillageFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIVillageFieldCell class])];
    
    [self.tableView registerClass:[PIVillageSelectCell class] forCellReuseIdentifier:NSStringFromClass([PIVillageSelectCell class])];
    
    [self.tableView registerClass:[PIVillageTypeCell class] forCellReuseIdentifier:NSStringFromClass([PIVillageTypeCell class])];
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = CGRectGetMaxY(self.tableView.frame) + 20 * Scale_Y;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50 * Scale_Y;
    bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"预约" forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bottomBtnClick {
    
    NSLog(@"-----------------");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 5) {
        
        PIVillageSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIVillageSelectCell class])];
        
        cell.titleStr = self.dataArr[indexPath.row];
        
        if (indexPath.row == 0) {
            
            cell.contentStr = @"请选择小区";
        }else if (indexPath.row == 4) {
            
            cell.contentStr = @"请选择开始时间";
        }else {
            
            cell.contentStr = @"请选择结束时间";
        }
        
        return cell;
        
    }else if (indexPath.row == 1 || indexPath.row == 2) {
        
        PIVillageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIVillageTypeCell class])];
        
        cell.titleStr = self.dataArr[indexPath.row];
        
        return cell;
    }
    
    PIVillageFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIVillageFieldCell class])];
    
    cell.titleStr = self.dataArr[indexPath.row];
    
    return cell;
}


- (void)selectSegment:(UISegmentedControl *)segment {
    
    if (segment.selectedSegmentIndex == 0) {
        
        NSLog(@"公共车位");
    }else {
        
        NSLog(@"小区预约");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
