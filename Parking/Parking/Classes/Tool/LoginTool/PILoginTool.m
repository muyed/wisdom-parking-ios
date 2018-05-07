//
//  PILoginTool.m
//  Parking
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PILoginTool.h"
#import "PINavigationController.h"
#import "PILoginViewController.h"

@implementation PILoginTool

+ (instancetype)defaultTool {
    
    static dispatch_once_t onceToken;
    static PILoginTool *insatance;
    
    dispatch_once(&onceToken, ^{
        
        insatance = [PILoginTool new];
    });
    
    return insatance;
}

+ (void)loginOut {
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        PINavigationController  *nav = [[PINavigationController alloc] initWithRootViewController:[[PILoginViewController alloc] init]];
        
        [PIUserDefaults removeObjectForKey:SessionId];
        [PIUserDefaults removeObjectForKey:CookieID];
        [PIUserDefaults removeObjectForKey:@"PIUserInfo"];
        [PIUserDefaults synchronize];
        
        [PIMapManager sharedManager].isFirst = NO;
        [[PIMapManager sharedManager] stopUpdateLocation];
        //重新设置窗口的根视图
        window.rootViewController = nav;
        
        [UIView setAnimationsEnabled:oldState];
        
    } completion:^(BOOL finished) {
        
        
    }];

    
}

+ (void)saveAcountInfo:(NSDictionary *)dict {
    
    NSDictionary *data = dict[@"data"];
    
    [PIUserDefaults setObject:[data mj_JSONString] forKey:@"PIUserInfo"];
    [PIUserDefaults synchronize];
}


- (BOOL)isIdentiAuthen {
    
    PILoginDataModel *model = [self getAcountInfo];
    
    return model.identityCard.length == 0 ? NO : YES;
}

- (BOOL)hasCarPot {
    
    PILoginDataModel *model = [self getAcountInfo];
    
    return model.userCarportList.count == 0 ? NO : YES;
}

- (BOOL)hasVillage {
    
    PILoginDataModel *model = [self getAcountInfo];
    
    return model.communityList.count == 0 ? NO : YES;
}

- (CGFloat)balance {
    
    if (!_balance) {
        
        PILoginDataModel *model = [self getAcountInfo];
        _balance = model.account.balance;
    }
    
    return _balance;
}

- (NSString *)accountCashConf {
    
    if (!_accountCashConf) {
        
        PILoginDataModel *model = [self getAcountInfo];
        
        _accountCashConf = model.accountCashConf;
    }
    
    return _accountCashConf;
}

- (NSString *)carportCashConf {
    
    if (!_carportCashConf) {
        
        PILoginDataModel *model = [self getAcountInfo];
        
        _carportCashConf = model.carportCashConf;
    }
    
    return _carportCashConf;
}

- (PILoginDataModel *)acountModel {
    
    return [self getAcountInfo];
}

- (PILoginDataModel *)getAcountInfo {

    NSString *acountInfoStr = [PIUserDefaults objectForKey:@"PIUserInfo"];
    NSDictionary *acountInfoDict = [acountInfoStr mj_JSONObject];
    
    PILoginDataModel *userInfo = [PILoginDataModel mj_objectWithKeyValues:acountInfoDict];
    return userInfo;
}
@end
