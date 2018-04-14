//
//  PISelectCitiesController.h
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

typedef void(^SelectCityName)(NSString *cityName);

@interface PISelectCitiesController : PIBaseViewController

@property (nonatomic, copy) SelectCityName selectCityName;

@end
