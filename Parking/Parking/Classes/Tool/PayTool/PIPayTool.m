//
//  PIPayTool.m
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPayTool.h"
#import "PIWXPayModel.h"


@implementation PIPayTool

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    static PIPayTool *instance;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[PIPayTool alloc] init];
    });
    
    return instance;
}

+ (void)AlipayForOrderWithOrderNum:(NSString *)orderNum success:(void (^)(id))success failue:(void (^)(NSError *))failue {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/pay/mayi/"), orderNum];
    
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        success ? success(response) : nil;
        
    } failure:^(NSError *error) {
        
        failue ? failue(error) : nil;
        
    }];
}

+ (void)WXpayForOrderWithOrderNum:(NSString *)orderNum success:(void (^)(id))success failue:(void (^)(NSError *))failue {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/pay/wx/"), orderNum];
    
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        
        success ? success(response) : nil;
        
    } failure:^(NSError *error) {
        
        failue ? failue(error) : nil;
        
    }];
}

+ (void)WXpayForOrderWithOrderNum:(NSString *)orderNum {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", urlPath(@"api/pay/wx/"), orderNum];
    
    [PIHttpTool piGet:url params:nil success:^(id response) {
        
        PIWXPayModel *model = [PIWXPayModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            PayReq *payRequest = [[PayReq alloc] init];
            payRequest.partnerId = model.data.partnerid;
            payRequest.prepayId = model.data.prepayid;
            payRequest.package = model.data.package;
            payRequest.nonceStr = model.data.noncestr;
            payRequest.timeStamp = [model.data.timestamp intValue];
            payRequest.sign = model.data.sign;
            
            [WXApi sendReq:payRequest];
        }
        
        
    } failure:^(NSError *error) {
        
        
        
    }];
}
+ (void)payForAcountCash:(void (^)(NSString *))success {
    
    [PIHttpTool piGet:urlPath(@"api/account/payCash") params:nil success:^(id response) {
        
        PIBaseModel *model = [PIBaseModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            success ? success(model.data) : nil;
        }else if (model.code == 24) {
            
            [MBProgressHUD showMessage:model.errMsg];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [PINotification postNotificationName:PIPayForCashNotifation object:nil];
                
            });
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showMessage:@"支付失败"];
    }];
}

- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        NSLog(@"%d", resp.errCode);
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        
    }
}

@end
