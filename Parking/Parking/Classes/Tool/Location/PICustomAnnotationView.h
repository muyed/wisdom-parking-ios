//
//  PICustomAnnotationView.h
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "PICustomAnnotation.h"

@class PICarportDataModel;

@interface PICustomAnnotationView : MAAnnotationView

///-- 数据源
@property (nonatomic, strong) PICarportDataModel *dataModel;

+ (instancetype)annotationViewWithMap:(MAMapView *)mapView;

@end
