//
//  PIBaseViewController.m
//  Parking
//
//  Created by apple on 2018/1/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"
#import "PIPersonAuthenController.h"

@interface PIBaseViewController ()

@end

@implementation PIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = PIBackColor;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [PINotification addObserver:self selector:@selector(pushToPersonAuth) name:PIPayForCashNotifation object:nil];
}


- (void)pushToPersonAuth {
    
    PIPersonAuthenController *person = [PIPersonAuthenController new];
    
    [self.navigationController pushViewController:person animated:YES];
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
