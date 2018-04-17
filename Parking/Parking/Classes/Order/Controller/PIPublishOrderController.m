//
//  PIPublishOrderController.m
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPublishOrderController.h"
#import "PIBaseDetailCell.h"
#import "PIBaseFieldCell.h"
#import "PGDatePickManager.h"
#import "PIPublishOrderCell.h"
#import "PITextView.h"
#import "PIBottomBtn.h"

@interface PIPublishOrderController ()<PGDatePickerDelegate>

///-- 标题
@property (nonatomic, copy) NSArray *titleArr;
///-- 立即支付按钮
@property (nonatomic, strong) PIBottomBtn *bottomBtn;

@end

@implementation PIPublishOrderController
{
    
    NSString *_beginTime;
    NSString *_endTime;
    NSInteger _selectIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布共享车位";
    
    
    self.titleArr = @[@{@"title" : @"起租时间", @"content" : @"请选择时间"}, @{@"title" : @"停租时间", @"content" : @"请选择时间"}, @{@"title" : @"出租价格", @"content" : @"请输入价格"}];
    
    [self setupUI];
}

- (void)setupUI {
    
     [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT -  TabBarHeight - NavBarHeight - 60 * Scale_Y)];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.size = CGSizeMake(SCREEN_WIDTH, 160 * Scale_Y);
    self.tableView.tableFooterView = headerView;
    UILabel *titleLabel = [[UILabel alloc] initWithFont:16 textColor:txtPlaceColor text:@"备注"];
    titleLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 40 * Scale_Y);
    [headerView addSubview:titleLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * Scale_Y, SCREEN_WIDTH, 120 * Scale_Y)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    PITextView *textView = [PITextView new];
    textView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 120 * Scale_Y);
    textView.placeholder = @"请输入车位位置、租用提醒等备注内容";
    textView.placeholderColor = txtPlaceColor;
    
    [bgView addSubview:textView];
    [headerView addSubview:bgView];
    
    self.bottomBtn = [[PIBottomBtn alloc] initWithTitle:@"立即发布"];
    
    self.bottomBtn.x = 30;
    self.bottomBtn.y = CGRectGetMaxY(self.tableView.frame) + 20 * Scale_Y;
    self.bottomBtn.width = SCREEN_WIDTH - 60;
    self.bottomBtn.height = 50;
    self.bottomBtn.layer.cornerRadius = 50 * 0.5;
    self.bottomBtn.clipsToBounds = YES;
    
    [self.bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomBtn];
    
    [self.tableView registerClass:[PIBaseDetailCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseDetailCell class])];
    
    [self.tableView registerClass:[PIBaseFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    [self.tableView registerClass:[PIPublishOrderCell class] forCellReuseIdentifier:NSStringFromClass([PIPublishOrderCell class])];
}

- (void)buttonClick {
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (indexPath.row != 2) {
            
            PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
            
            cell.titleString = self.titleArr[indexPath.row][@"title"];
            
            if (indexPath.row == 0) {
                
                if (_beginTime.length == 0) {
                    
                    cell.contentString = self.titleArr[indexPath.row][@"content"];
                    cell.contentColor = txtPlaceColor;
                }else {
                    
                    cell.contentString = _beginTime;
                    cell.contentColor = txtMainColor;
                }
            }else {
                
                
                if (_endTime.length == 0) {
                    
                    cell.contentString = self.titleArr[indexPath.row][@"content"];
                    cell.contentColor = txtPlaceColor;
                }else {
                    
                    cell.contentString = _endTime;
                    cell.contentColor = txtMainColor;
                }
                
            }
           
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
            
        }else {
            
            
            PIBaseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
            
            cell.titleString = self.titleArr[indexPath.row][@"title"];
            cell.placeString = self.titleArr[indexPath.row][@"content"];
            
            return cell;
        }
        
    }else {
        
        
        PIPublishOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIPublishOrderCell class])];
        
        
        return cell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        
        return 55 * Scale_Y;
    }else {
        
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        
        return 60 * Scale_Y;
    }else {
        
        return 130 * Scale_Y;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath.row;
    
    if (indexPath.section) {
        
        if (indexPath.row == 0 || indexPath.row == 1) {
            
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
    
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    
    NSString *str = [NSString stringWithFormat:@"%lu-%lu-%lu %02lu:%02lu:00", dateComponents.year, dateComponents.month, dateComponents.day, dateComponents.hour, dateComponents.minute];
    
    if (_selectIndex == 0) {
        
        _beginTime = str;
    }else if (_selectIndex == 1) {
        
        _endTime = str;
    }

    
    [self.tableView reloadData];
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
