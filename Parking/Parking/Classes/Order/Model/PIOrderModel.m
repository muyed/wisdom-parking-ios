//
//  PIOrderModel.m
//  Parking
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIOrderModel.h"

@implementation PIOrderModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data": @"PIOrderListData"};
}

@end

@implementation PIOrderListData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}
@end

