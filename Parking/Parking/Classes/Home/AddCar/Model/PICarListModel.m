//
//  PICarListModel.m
//  Parking
//
//  Created by apple on 2018/4/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICarListModel.h"

@implementation PICarListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data" : @"PICarDataModel"};
}

@end


@implementation PICarDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

@end
