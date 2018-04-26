//
//  PIMyParkingController.m
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMyParkingController.h"
#import "PIMyParkingCollectionCell.h"
#import "PIMyParkModel.h"


@interface PIMyParkingController ()<UICollectionViewDelegate, UICollectionViewDataSource>

///-- 导航
@property (nonatomic, weak) UIView *navView;
///-- 网格
@property (nonatomic, weak) UICollectionView *collectionView;
///-- 分页
@property (nonatomic, weak) UIPageControl *pageControl;
///-- 数据源
@property (nonatomic, strong) NSMutableArray *dataArr;

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
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(40, SCREEN_HEIGHT - TabBarHeight  - 50 * Scale_Y, SCREEN_WIDTH - 80, 40)];
    //pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = PIMainColor;
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)loadData {
    
    weakself
    [PIHttpTool piGet:urlPath(@"api/carport/myCarport") params:nil success:^(id response) {
        
        PIMyParkModel *model = [PIMyParkModel mj_objectWithKeyValues:response];
        
        if (model.code == 200) {
            
            weakSelf.dataArr = (NSMutableArray *)model.data;
            weakSelf.pageControl.numberOfPages = model.data.count;
            
        }else {
            
            [MBProgressHUD showMessage:model.errMsg];
        }
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showMessage:@"获取失败"];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PIMyParkingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PIMyParkingCollectionCell class]) forIndexPath:indexPath];
    
    cell.index = indexPath.row + 1;
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = (int)scrollView.contentOffset.x/SCREEN_WIDTH;
    
    self.pageControl.currentPage = page;
    
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
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
