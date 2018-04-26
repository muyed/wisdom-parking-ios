//
//  PIMyVillageListModel.m
//  Parking
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyVillageListModel.h"

@implementation PIMyVillageListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data" : @"PIMyVillageDataModel"};
}

@end

@implementation PIMyVillageDataModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"carportList" : @"PIMyVillageCarportModel"};
}



@end

@implementation PIMyVillageCarportModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

//- (NSString *)modifyTime {
//    
//    
//}
@end
