//
//  PIVillageListModel.m
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageListModel.h"

@implementation PIVillageListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data" : @"PIVillageDataModel"};
}

@end

@implementation PIVillageDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}
@end

