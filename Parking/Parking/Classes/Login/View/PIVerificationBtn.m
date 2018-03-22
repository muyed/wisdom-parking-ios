//
//  PIVerificationBtn.m
//  Parking
//
//  Created by apple on 2018/2/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVerificationBtn.h"

@implementation PIVerificationBtn

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = PIMainColor;
        self.titleLabel.font = PISYS_FONT(13);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius= 15.0f;
        [self addTarget:self
                 action:@selector(eventForClick)
       forControlEvents:UIControlEventTouchUpInside];
        
        NSLog(@"-------------");
    }
    
    return self;
}

- (void)eventForClick {
    
    if (self.verifClick) {
        
        self.verifClick();
    }
}

- (void)setupInitialState {
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.backgroundColor = PIMainColor;
    self.userInteractionEnabled = YES;
}

- (void)setupRunningState:(NSString *)timerSec {
    NSString *title = [NSString stringWithFormat:@"%@s后重发",timerSec];
    self.backgroundColor = [UIColor lightGrayColor];
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)startTimer {
    
    self.userInteractionEnabled = NO;
    
    //-- 倒计时时间
    __block int timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //--  创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeOut <= 0) {
            
            //-- 关闭倒计时
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupInitialState];
            });
            
        }else {
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setupRunningState:strTime];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}
@end
