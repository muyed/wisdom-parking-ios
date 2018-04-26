//
//  PILoginModel.m
//  Parking
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginModel.h"
#import "PIMyVillageListModel.h"
#import "PIMyParkModel.h"


@implementation PILoginModel

@end

@implementation PILoginDataModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"communityList" : @"PIMyVillageDataModel",
             @"userCarportList" : @"PIMyParkDataModel"};
}
@end
