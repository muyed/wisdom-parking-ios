//
//  PIVerificationBtn.h
//  Parking
//
//  Created by apple on 2018/2/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VerifBtnClick) (void);

@interface PIVerificationBtn : UIButton

///-- 点击事件
@property (nonatomic, copy) VerifBtnClick verifClick;

///-- 开启定时器
- (void)startTimer;

@end
