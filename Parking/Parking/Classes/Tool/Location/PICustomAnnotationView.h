//
//  PICustomAnnotationView.h
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "PICustomAnnotation.h"

@interface PICustomAnnotationView : MAAnnotationView

+ (instancetype)annotationViewWithMap:(MAMapView *)mapView;

@end
