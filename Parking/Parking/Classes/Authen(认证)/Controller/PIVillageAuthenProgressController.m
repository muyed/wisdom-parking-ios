//
//  PIVillageAuthenProgressController.m
//  Parking
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIVillageAuthenProgressController.h"
#import "PIVillageAuthenProgressView.h"

@interface PIVillageAuthenProgressController ()

/**
 <#Description#>
 */
@property (nonatomic, strong) PIVillageAuthenProgressView *authView;
@end

@implementation PIVillageAuthenProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小区认证";
    [self.view addSubview:self.authView];
    
    weakself
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(NavBarHeight);
        make.height.mas_equalTo(230 * Scale_Y);
    }];
    
    self.authView.villageName = self.villageName;
}

- (PIVillageAuthenProgressView *)authView {
    
    if (!_authView) {
        
        _authView = [PIVillageAuthenProgressView new];
        
    }
    
    return _authView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
