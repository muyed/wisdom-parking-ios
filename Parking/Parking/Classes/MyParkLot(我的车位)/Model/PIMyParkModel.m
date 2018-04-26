//
//  PIMyParkModel.m
//  Parking
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyParkModel.h"

@implementation PIMyParkModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data" : @"PIMyParkDataModel"};
}

@end

@implementation PIMyParkDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

@end
