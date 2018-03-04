//
//  UIBarButtonItem+PI.m
//  Parking
//
//  Created by apple on 2018/1/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "UIBarButtonItem+PI.h"

@implementation UIBarButtonItem (PI)

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action type:(PIBarButtonItemType)type {
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.size = CGSizeMake(70, 30);

    switch (type) {
        case 0:
            barButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            break;
        case 1:
            barButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;

        case 2:
            barButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            break;
        default:
            barButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            break;
    }

    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:barButton];
    
   // return [self itemWithTitle:title image:nil target:target action:action type:type];
}

+ (instancetype)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action {
    
    return [self itemWithTitle:nil image:imageName target:target action:action type:4];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action type:(PIBarButtonItemType)type {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    if (imageName) {
        
         button.size = CGSizeMake(30, 30);
    }else {
        
        button.size = CGSizeMake(60, 25);
    }
   
    
    if (title) {
        
        switch (type) {
            case 0:
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                break;
            case 1:
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                break;
                
            case 2:
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                break;
            default:
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                break;
        }
    }
    
    
     return [[self alloc] initWithCustomView:button];
}


@end
