//
//  PIMyParkingController.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyParkingController.h"
#import "PIMyParkingCollectionCell.h"

@interface PIMyParkingController ()<UICollectionViewDelegate, UICollectionViewDataSource>

///-- 导航
@property (nonatomic, weak) UIView *navView;
///-- <#Notes#>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation PIMyParkingController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupUI];
    
    [self loadData];
}




- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


- (void)setupNav {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    nav.backgroundColor = PIMainColor;
    [self.view addSubview:nav];
    self.navView = nav;
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的车位";
    label.font = [UIFont boldSystemFontOfSize:18.0];
    CGFloat top = NavBarHeight - 34;
    label.frame = CGRectMake(0, top, SCREEN_WIDTH, 24);
    
    [nav addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithImageName:@"navgation-back"];
    btn.x = 15;
    btn.y = top;
    btn.width = 25;
    btn.height = 25;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:btn];

    
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    
    // -- 设置滚动方向
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50);
    layOut.minimumLineSpacing = 0;
    layOut.minimumInteritemSpacing = 0;
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //_layout = layOut;
    //
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight + 50) collectionViewLayout:layOut];
    
    collection.backgroundColor = [UIColor clearColor];
    collection.delegate = self;
    collection.dataSource = self;
    collection.showsHorizontalScrollIndicator = NO;
    collection.showsVerticalScrollIndicator = NO;
    collection.pagingEnabled = YES;
    
    [self.view addSubview:collection];
    
    _collectionView = collection;
    
     [collection registerClass:[PIMyParkingCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([PIMyParkingCollectionCell class])];
}

- (void)loadData {
    
    [PIHttpTool piGet:urlPath(@"api/carport/myCarport") params:nil success:^(id response) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PIMyParkingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PIMyParkingCollectionCell class]) forIndexPath:indexPath];
    
    
    return cell;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
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
