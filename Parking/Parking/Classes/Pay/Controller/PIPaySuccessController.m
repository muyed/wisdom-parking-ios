//
//  PIPaySuccessController.m
//  Parking
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIPaySuccessController.h"
#import "PIVillageAuthenProgressView.h"
#import "PIMyVillageController.h"

@interface PIPaySuccessController ()

/**
 <#Description#>
 */
@property (nonatomic, strong) PIVillageAuthenProgressView *authView;

@end

@implementation PIPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *sp = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    sp.width = -10;
    UIBarButtonItem *back = [UIBarButtonItem itemWithImage:@"navgation-back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItems = @[sp,back];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.authView];
    
    weakself
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(NavBarHeight);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(190 * Scale_Y);
    }];
    
    self.authView.imageName = @"put_forward_success";
    self.authView.tipTitle = @"充值成功";
}

- (void)back {
    
    NSLog(@"-------------");
    
//        for (UIViewController *vc in self.navigationController.viewControllers) {
//
//            if ([vc isKindOfClass:NSClassFromString(@"PIMyVillageController")]) {
//
//                PIMyVillageController *village = (PIMyVillageController *)vc;
//                village.isSuccess = YES;
//                [self.navigationController popToViewController:village animated:YES];
//
//                break;
//            }
//        }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (PIVillageAuthenProgressView *)authView {
    
    if (!_authView) {
        
        _authView = [PIVillageAuthenProgressView new];
        
    }
    
    return _authView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
