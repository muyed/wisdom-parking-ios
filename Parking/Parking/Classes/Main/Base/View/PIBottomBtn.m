//
//  PIBottomBtn.m
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBottomBtn.h"

@implementation PIBottomBtn

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = PIMainColor;
        self.titleLabel.font = PIBigFont;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return self;
}

@end
