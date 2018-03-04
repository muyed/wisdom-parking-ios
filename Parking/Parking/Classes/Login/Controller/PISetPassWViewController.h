//
//  PISetPassWViewController.h
//  Parking
//
//  Created by apple on 2018/2/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

@interface PISetPassWViewController : PIBaseViewController

///-- 手机号
@property (nonatomic, copy) NSString *phoneNum;
///-- 验证码
@property (nonatomic, copy) NSString *verifCode;
@end
