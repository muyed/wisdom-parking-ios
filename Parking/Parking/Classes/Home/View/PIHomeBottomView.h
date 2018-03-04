//
//  PIHomeBottomView.h
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PIHomeBottomDelegate  <NSObject>

- (void)buttonStateChanged:(BOOL)change;

@end

@interface PIHomeBottomView : UIView

///-- 代理
@property (nonatomic, weak) id<PIHomeBottomDelegate>delegate;
@end
