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

- (NSString *)type {
    
    switch (_type.integerValue) {
        case 1:
            
            return @"审核中";
            break;
            
        case 2:
            
            return @"审核通过";
            break;
           
        case 3:
            
            return @"未通过";
            break;
            
        case 4:
            
            return @"已删除";
            break;
            
        default:
            
            return @"";
            break;
    }
}
@end

