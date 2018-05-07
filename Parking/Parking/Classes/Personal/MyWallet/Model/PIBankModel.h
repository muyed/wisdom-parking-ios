//
//  PIBankModel.h
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIBankModel : NSObject

///-- 银行名字
@property (nonatomic, copy) NSString *bank_name;
///-- 银行代码
@property (nonatomic, copy) NSString *bank_code;
///-- 银行logo
@property (nonatomic, copy) NSString *bank_logo;

@end
