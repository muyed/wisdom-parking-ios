//
//  PICustomAnnotationView.m
//  Parking
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICustomAnnotationView.h"
#import "PICarportModel.h"

static NSString *identifier = @"PICustomAnnotationView";

@implementation PICustomAnnotationView

+ (instancetype)annotationViewWithMap:(MAMapView *)mapView
{
    PICustomAnnotationView *annoView = (PICustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annoView == nil) {
        annoView = [[PICustomAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
    }
    return annoView;
}

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        // 可以自定义控件
        
        //self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setAnnotation:(PICustomAnnotation *)annotation
{
    [super setAnnotation:annotation];
    self.image = [UIImage imageNamed:annotation.icon];
    self.dataModel = annotation.model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    NSLog(@"------------------");
    
}
@end
