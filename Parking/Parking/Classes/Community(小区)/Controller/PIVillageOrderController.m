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
#import "PGDatePickManager.h"

@interface PIVillageOrderController ()<UITableViewDelegate, UITableViewDataSource, PGDatePickerDelegate>

///-- 列表
@property (nonatomic, strong) UITableView *tableView;
///-- 数据源
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation PIVillageOrderController
{
    
    NSString *_beginTime;
    NSString *_endTime;
    NSInteger _selectIndex;
    
}
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
            
           
            cell.contentStr = _beginTime.length == 0 ? @"请选择开始时间" : _beginTime;
        }else {
            
            cell.contentStr = _endTime.length == 0 ? @"请选择结束时间" : _endTime;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath.row;
    
    if (indexPath.row == 4 || indexPath.row == 5) {
        
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.isShadeBackgroud = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType2;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinute;
        datePicker.lineBackgroundColor = PIMainColor;
        //设置选中行的字体颜色
        datePicker.textColorOfSelectedRow = PIMainColor;
        //设置确定按钮的字体颜色
        datePickManager.confirmButtonTextColor = PIMainColor;
        [self presentViewController:datePickManager animated:YES completion:nil];
        
    }
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    
    NSString *str = [NSString stringWithFormat:@"%lu-%lu-%lu %lu:%lu:00", dateComponents.year, dateComponents.month, dateComponents.day, dateComponents.hour, dateComponents.minute];
    
    if (_selectIndex == 4) {
        
        _beginTime = str;
    }else if (_selectIndex == 5) {
        
        _endTime = str;
    }
    
    [self.tableView reloadData];
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
