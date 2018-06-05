//
//  PIMyBankCardsController.h
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"

@class PIMyCardsDataModel;

typedef void(^BankCardInfo)(PIMyCardsDataModel *dataModel);

@interface PIMyBankCardsController : PIBaseTableViewController

///-- 是否为提现
@property (nonatomic, assign) BOOL isPutForward;

///-- 银行卡
@property (nonatomic, copy) BankCardInfo bankCardInfo;

@end
