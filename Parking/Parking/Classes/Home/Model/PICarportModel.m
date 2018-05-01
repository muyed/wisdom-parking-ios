//
//  PICarportModel.m
//  Parking
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarportModel.h"

@implementation PICarportModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data" : @"PICarportDataModel"};
}
@end

@implementation PICarportDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id",
             @"lat" : @"latitude",
             @"lon" : @"longitude"
             };
}

- (NSString *)startWeekDay {
    
    if (!_startWeekDay) {
        
        _startWeekDay = [NSString getWeekDay:_startTime];
    }
    
    return _startWeekDay;
}

- (NSString *)stopWeekDay {
    
    if (!_stopWeekDay) {
        
        _stopWeekDay = [NSString getWeekDay:_stopTime];
    }
    
    return _stopWeekDay;
}

- (NSString *)startDay {
    
    if (!_startDay) {
        
        _startDay = [NSString getDay:_startTime];
    }
    
    return _startDay;
}

- (NSString *)stopDay {
    
    if (!_stopDay) {
        
        _stopDay = [NSString getDay:_stopTime];
    }
    
    return _stopDay;
}

- (NSString *)startHour {
    
    if (!_startHour) {
        
        _startHour = [NSString getTime:_startTime];
    }
    
    return _startHour;
}

- (NSString *)stopHour {
    
    if (!_stopHour) {
        
        _stopHour = [NSString getTime:_stopTime];
    }
    
    return _stopHour;
}
@end
