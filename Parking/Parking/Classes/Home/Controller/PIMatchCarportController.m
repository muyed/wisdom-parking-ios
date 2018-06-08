//
//  PIMatchCarportController.m
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMatchCarportController.h"
#import "PICarportModel.h"
#import "PIBaseDetailCell.h"
#import "PIMatchCarportTopCell.h"
#import "PIBaseFieldCell.h"
#import "PGDatePickManager.h"
#import "PIBottomBtn.h"
#import "PICarsListController.h"
#import "PIOrderModel.h"
#import "PIOrderDetailController.h"

@interface PIMatchCarportController ()<PGDatePickerDelegate, PIBaseFieldCellDelegate>

///-- 数据源
@property (nonatomic, strong) PIOrderListData *listData;

@end

@implementation PIMatchCarportController
{
    
    NSString *_beginTime;
    NSString *_endTime;
    NSInteger _selectIndex;
    NSString *_phoneNum;
    NSString *_carNum;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"匹配订单";
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight - NavBarHeight + 50)];
    
    self.tableView.scrollEnabled = NO;
    
    PIBottomBtn *bottomBtn = [PIBottomBtn new];
    
    bottomBtn.x = btnBorderM;
    bottomBtn.y = SCREEN_HEIGHT - 70 * Scale_Y;
    bottomBtn.width = SCREEN_WIDTH - 2 * btnBorderM;
    bottomBtn.height = 50 * Scale_Y;
    bottomBtn.layer.cornerRadius = 50 * Scale_Y * 0.5;
    bottomBtn.clipsToBounds = YES;
    [bottomBtn setTitle:@"立即匹配" forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[PIBaseDetailCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseDetailCell class])];
    
    [self.tableView registerClass:[PIBaseFieldCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseFieldCell class])];
    
    [self.tableView registerClass:[PIMatchCarportTopCell class] forCellReuseIdentifier:NSStringFromClass([PIMatchCarportTopCell class])];
}

- (void)bottomBtnClick {
    
    if (_carNum.length == 0) {
        
        [MBProgressHUD showMessage:@"请选择车牌号"];
        return;
    }
    
    if (_phoneNum.cancelSpace.length == 0) {
        
        [MBProgressHUD showMessage:@"请输入手机号"];
        return;
    }
    
    if (![_phoneNum isPhoneNum]) {
        
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    
    if (_beginTime.length == 0) {
        
        [MBProgressHUD showMessage:@"请选择预约开始时间"];
        return;
    }
    
    if (_endTime.length == 0) {
        
        [MBProgressHUD showMessage:@"请选择预约结束时间"];
        return;
    }
    
    NSLog(@"%@", self.dataModel.parkingTicketId);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parkingShareId"] = self.dataModel.ID;
    params[@"appointmentStartTime"] = _beginTime;
    params[@"appointmentEndTime"] = _endTime;
    params[@"carLicense"] = _carNum;
    params[@"phone"] = _phoneNum;
    
    [MBProgressHUD showIndeterWithMessage:@"正在匹配"];
    
    weakself
    [PIHttpTool piPost:urlPath(@"api/ticket/matching") params:params success:^(id response) {
        
        [MBProgressHUD hideHUD];
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (model.code != 200) {
            
            [MBProgressHUD showMessage:model.errMsg];
        }else {
            
            weakSelf.listData = [PIOrderListData mj_objectWithKeyValues:response[@"data"]];
            
            [MBProgressHUD showMessage:@"匹配成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                PIOrderDetailController *orderVC = [PIOrderDetailController new];
                
                orderVC.listData = weakSelf.listData;
                [weakSelf.navigationController pushViewController:orderVC animated:YES];
            });
        }
        
    
        
        
    } failure:^(NSError *error) {
        
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"匹配失败"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 4;
    }else if (section == 3) {
        
        return 1;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            
            if (!cell) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH);
            
            cell.textLabel.text = self.dataModel.carportNum;
            cell.textLabel.font = [UIFont systemFontOfSize:18 weight:2];
            
            return cell;
        }else {
            
            PIMatchCarportTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIMatchCarportTopCell class])];
            
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH);
            
            if (indexPath.row == 1) {
                
                cell.tipColor = PIYellowColor;
                cell.tipStr = @"时";
                cell.contentStr = [NSString stringWithFormat:@"可停至 %@ %@", self.dataModel.stopDay ,self.dataModel.stopHour];
            }if (indexPath.row == 2) {
                
                cell.tipColor = PIMainColor;
                cell.tipStr = @"场";
                cell.contentStr = self.dataModel.communityName;
            }else if(indexPath.row == 3){
                
                cell.tipColor = PIGreenColor;
                cell.tipStr = @"地";
                cell.contentStr = self.dataModel.addr;
            }
            return cell;
            
        }
        
    }else {
        
        PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
        
        cell.titleLabel.textColor = txtSeconColor;
        cell.contentColor = txtMainColor;
        
        cell.commentLabel.textAlignment = NSTextAlignmentRight;
        
        if (indexPath.section == 1) {
            
            
            if (indexPath.row == 1) {
                
                 PIBaseFieldCell *fieldCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseFieldCell class])];
                fieldCell.pi_delegate = self;
                fieldCell.textField.textAlignment = NSTextAlignmentRight;
                fieldCell.titleString =  @"手机号码:";
                fieldCell.titleLabel.textColor = txtSeconColor;
                fieldCell.placeString = @"请输入手机号";
                
                return fieldCell;
            }else {
                
                cell.titleString =  @"车牌号:";
               
                
                if (_carNum.length == 0) {
                    
                    cell.contentString = @"请选择车牌号";
                    cell.contentColor = txtSeconColor;
                    
                }else {
                    
                    cell.contentString = _carNum;
                    cell.contentColor = txtMainColor;
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            
        }else if (indexPath.section == 2) {
            
            cell.titleString = indexPath.row == 0 ? @"开始时间" : @"结束时间";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 0) {
                
                if (_beginTime.length == 0) {
                    
                    cell.contentString = @"请选择开始时间";
                    cell.contentColor = txtPlaceColor;
                }else {
                    
                    cell.contentString = _beginTime;
                    cell.contentColor = txtMainColor;
                }
            }else {
                
                
                if (_endTime.length == 0) {
                    
                    cell.contentString = @"请选择结束时间";
                    cell.contentColor = txtPlaceColor;
                }else {
                    
                    cell.contentString = _endTime;
                    cell.contentColor = txtMainColor;
                }
                
            }
            
        }else {
            
            cell.titleString = @"当前单价:";
            
            cell.contentString = [NSString stringWithFormat:@"%@ 元/小时", self.dataModel.price];
        }
        
        return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        return 40;
    }else {
        
        return 60 * Scale_Y;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        PICarsListController *carList = [PICarsListController new];
        carList.isMatch = YES;
        weakself
        [carList setCarNum:^(NSString *carNum) {
            
            _carNum = carNum;
            
            [weakSelf.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:carList  animated:YES];
    }
    if (indexPath.section == 2) {
        
        _selectIndex = indexPath.row;
        
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

- (void)pi_textFieldEndEidting:(UITextField *)textField index:(NSInteger)index {
    
    _phoneNum = textField.text.cancelSpace;
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



@end
