//
//  PIBankListController.h
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"

@class PIBankModel;

typedef void(^BankInfo)(PIBankModel *bankModel);

@interface PIBankListController : PIBaseTableViewController

///-- <#Notes#>
@property (nonatomic, copy) BankInfo bankInfo;
@end
