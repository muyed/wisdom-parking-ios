//
//  PICarpotOrderView.h
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PICarpotOrderView : UIView

+ (instancetype)carportOrderView;

- (void)show;

- (void)dismiss;
///-- <#Notes#>
@property (nonatomic, assign) CGFloat lat;
@end
