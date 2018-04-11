//
//  PIPayTool.m
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayTool.h"

@implementation PIPayTool

+ (void)AlipayForOrderWithOrderNum:(NSString *)orderNum success:(void (^)(id))success failue:(void (^)(NSError *))failue {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/pay/mayi/"), orderNum];
    
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        success ? success(response) : nil;
        
    } failure:^(NSError *error) {
        
        failue ? failue(error) : nil;
        
    }];
}
@end
