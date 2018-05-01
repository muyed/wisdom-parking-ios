//
//  PIMineViewCell.m
//  Parking
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMineViewCell.h"
#import "PITopImageBtn.h"
#import "PIOrderViewController.h"
#import "PIAddDeviceController.h"
#import "PIMyParkingLotController.h"
#import "PIAddCarController.h"
#import "PIMyVillageController.h"
#import "PIComCertifiController.h"
#import "PIMyParkingController.h"
#import "PICarsListController.h"

@interface PIMineViewCell ()

///-- 我的车
@property (nonatomic, strong) PITopImageBtn *carBtn;
///-- 我的订单
@property (nonatomic, strong) PITopImageBtn *orderBtn;
///-- 我的设备
@property (nonatomic, strong) PITopImageBtn *deviceBtn;
///-- 我的客服
@property (nonatomic, strong) PITopImageBtn *customerBtn;

@end

@implementation PIMineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.carBtn];
    [self.contentView addSubview:self.orderBtn];
    [self.contentView addSubview:self.deviceBtn];
    [self.contentView addSubview:self.customerBtn];
    
    weakself
    
    CGFloat btnW = SCREEN_WIDTH * 0.25;
    
    [self.carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.top.and.bottom.equalTo(weakSelf.contentView);
        
        make.width.mas_equalTo(btnW);
    }];
    
    [self.customerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.and.top.and.bottom.equalTo(weakSelf.contentView);
        
        make.width.mas_equalTo(btnW);
    }];
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.carBtn.mas_right);
        make.width.mas_equalTo(btnW);
    }];
    
    [self.deviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.orderBtn.mas_right);
        make.width.mas_equalTo(btnW);
    }];
    
    [self.orderBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.deviceBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.customerBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.carBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)buttonClick:(UIButton *)sender {
    
    
    if (sender.tag == 1) {
        
        PIOrderViewController *order = [PIOrderViewController new];
        
        [self.parentController.navigationController pushViewController:order animated:YES];
        
    }else if (sender.tag == 2) {
        
        PIMyVillageController *myVillage = [PIMyVillageController new];
        
        [self.parentController.navigationController pushViewController:myVillage animated:YES];
        
    }else if (sender.tag == 3) {
        
        
        //PIMyParkingLotController *lot = [PIMyParkingLotController new];
        
        PIMyParkingController *com = [PIMyParkingController new];
        
        [self.parentController.navigationController pushViewController:com animated:YES];
        
    }else {
        
        PICarsListController *carsList = [PICarsListController new];
        
        [self.parentController.navigationController pushViewController:carsList animated:YES];
    }
   
}
- (PITopImageBtn *)carBtn {
    
    if (!_carBtn) {
        
        
        _carBtn = [PITopImageBtn new];
        _carBtn.tag = 0;
        [_carBtn setTitle:@"我的车辆" forState:UIControlStateNormal];
        _carBtn.titleLabel.font = PISYS_FONT(15);
        [_carBtn setImage:[UIImage imageNamed:@"mine_car"] forState:UIControlStateNormal];
        
    }
    
    return _carBtn;
}

- (PITopImageBtn *)orderBtn {
    
    if (!_orderBtn) {
        
        _orderBtn = [PITopImageBtn new];
        [_orderBtn setTitle:@"我的订单" forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = PISYS_FONT(15);
        _orderBtn.tag = 1;
        [_orderBtn setImage:[UIImage imageNamed:@"mine_order"] forState:UIControlStateNormal];
        
    }
    
    return _orderBtn;
}

- (PITopImageBtn *)deviceBtn {
    
    if (!_deviceBtn) {
        
        _deviceBtn = [PITopImageBtn new];
        _deviceBtn.tag = 2;
        [_deviceBtn setTitle:@"我的小区" forState:UIControlStateNormal];
        _deviceBtn.titleLabel.font = PISYS_FONT(15);
        [_deviceBtn setImage:[UIImage imageNamed:@"mine_device"] forState:UIControlStateNormal];
        
    }
    
    return _deviceBtn;
}

- (PITopImageBtn *)customerBtn {
    
    if (!_customerBtn) {
        
        _customerBtn = [PITopImageBtn new];
        _customerBtn.tag = 3;
        [_customerBtn setTitle:@"我的车位" forState:UIControlStateNormal];
        _customerBtn.titleLabel.font = PISYS_FONT(15);
        [_customerBtn setImage:[UIImage imageNamed:@"mine_park"] forState:UIControlStateNormal];
        
    }
    
    return _customerBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
