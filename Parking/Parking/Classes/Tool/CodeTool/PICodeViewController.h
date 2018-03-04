//
//  PICodeViewController.h
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

@interface PICodeViewController : PIBaseViewController

@property (copy) void (^codeBlock)(NSString *code);
@property (assign) BOOL isQtCode; //是否二维码
@property (nonatomic, copy) NSString *errorString;

@end
