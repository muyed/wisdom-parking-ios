//
//  PIPersonalController.m
//  Parking
//
//  Created by apple on 2018/3/8.
//  Copyright © 2018年 GM. All rights reserved.
//  

#import "PIPersonalController.h"

@interface PIPersonalController ()<UITableViewDelegate, UITableViewDataSource>

///-- 顶部视图
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PIPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0];
    
    // self.view.backgroundColor = [UIColor redColor];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self show];
    
}

- (void)show {
    
    self.topView.backgroundColor = PIMainColor;
    self.topView.x = 0;
    self.topView.y = -200;
    self.topView.height = 200;
    self.topView.width = SCREEN_WIDTH;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _topView.y = 0;
    }];
}


- (void)setupUI {
    
    self.topView = [[UIView alloc] init];
    
    [self.view addSubview:self.topView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, SCREEN_HEIGHT - 180) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    return cell;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
