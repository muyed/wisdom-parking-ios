//
//  PICarpotOrderView.h
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PICarportDataModel;
//-- 导航
typedef void(^BeginNavToCarport)(PICarportDataModel *dataModel);
//-- 匹配订单
typedef void(^BeginMatchCarport)(PICarportDataModel *dataModel);

@interface PICarpotOrderView : UIView

+ (instancetype)carportOrderView;

- (void)show;

- (void)dismiss;
///-- <#Notes#>
@property (nonatomic, strong) PICarportDataModel *dataModel;
///-- <#Notes#>
@property (nonatomic, copy) BeginNavToCarport beginNavToCarport;
///-- <#Notes#>
@property (nonatomic, copy) BeginMatchCarport beginMatchCarport;
///-- <#Notes#>
@property (nonatomic, assign) BOOL isShow;
@end
