//
//  PIMyCardsModel.m
//  Parking
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyCardsModel.h"

@implementation PIMyCardsModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data" : @"PIMyCardsDataModel"};
}

@end

@implementation PIMyCardsDataModel
{
    
    NSString *_bank_logo;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

- (NSString *)bank_logo {
    
    if (!_bank_logo) {
        
        switch (_bankCode) {
            case 1002:
                
                _bank_logo = @"icon_bank_gonghang";
                
                break;
            
            case 1005:
                
                _bank_logo = @"icon_bank_nongye";
                
                break;
            
            case 1026:
                
                _bank_logo = @"icon_bank_zhongguo";
                
                break;
            
            case 1003:
                
                _bank_logo = @"icon_bank_jianshe";
                
                break;
                
            case 1001:
                
                _bank_logo = @"icon_bank_zhaoshang";
                
                break;
                
            case 1066:
                
                _bank_logo = @"icon_bank_youchu";
                
                break;
            
            case 1020:
                
                _bank_logo = @"icon_bank_jiaotong";
                
                break;
                
            case 1004:
                
                _bank_logo = @"icon_bank_pufa";
                
                break;
                
            case 1006:
                
                _bank_logo = @"icon_bank_minsheng";
                
                break;
            
            case 1009:
                
                _bank_logo = @"icon_bank_xingye";
                
                break;
                
            case 1010:
                
                _bank_logo = @"icon_bank_pingan";
                
                break;
                
            case 1021:
                
                _bank_logo = @"icon_bank_zhongxin";
                
                break;
            
            case 1025:
                
                _bank_logo = @"icon_bank_huaxia";
                
                break;
            
            case 1027:
                
                _bank_logo = @"icon_bank_guangfa";
                
                break;
            
            case 1022:
                
                _bank_logo = @"icon_bank_guangda";
                
                break;
            
            case 1032:
                
                _bank_logo = @"icon_bank_guangfa";
                
                break;
            
            case 1056:
                
                _bank_logo = @"icon_bank_ningbo";
                
                break;
                
            default:
                break;
        }
    }
    
    return _bank_logo;
}
@end
