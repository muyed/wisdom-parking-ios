//
//  PINoticeModel.m
//  Parking
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PINoticeModel.h"

@implementation PINoticeModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":@"PINoticeData"};
}
@end


@implementation PINoticeData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}
@end

