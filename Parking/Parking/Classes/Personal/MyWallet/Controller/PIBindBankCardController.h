//
//  PIBindBankCardController.h
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseTableViewController.h"

typedef void(^BindSuccess)();
@interface PIBindBankCardController : PIBaseTableViewController

///-- <#Notes#>
@property (nonatomic, copy) BindSuccess bindSuccess;
@end
