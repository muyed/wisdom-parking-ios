//
//  PIVillageAuthenProgressController.h
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

@interface PIVillageAuthenProgressController : PIBaseViewController

@property (nonatomic, copy) NSArray *titleArr;
///-- 地址
@property (nonatomic, copy) NSArray *contentArr;
///-- 标题
@property (nonatomic, copy) NSString *authTitle;
///-- 提示标题
@property (nonatomic, copy) NSString *tipTitle;
///-- 提示图片
@property (nonatomic, copy) NSString *imageName;
@end
