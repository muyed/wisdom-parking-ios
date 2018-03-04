//
//  PIHomeItemView.m
//  Parking
//
//  Created by apple on 2018/3/3.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeItemView.h"
#import "PIHomeItemCell.h"

@interface PIHomeItemView ()<UICollectionViewDelegate, UICollectionViewDataSource>

///-- collectionView
@property (nonatomic, weak) UICollectionView *collection;
///-- 数据源
@property (nonatomic, copy) NSArray *dataArr;
///-- index
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) BOOL firstSelecte;
@end

@implementation PIHomeItemView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.dataArr = @[@"", @"分享车位", @"智慧车位", @"充电车位", @""];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.width /3, self.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
   // collectionView.pagingEnabled = YES;

    [self addSubview:collectionView];
    self.collection = collectionView;
    collectionView.contentOffset = CGPointMake(self.width /3, 0);
    [collectionView registerClass:[PIHomeItemCell class] forCellWithReuseIdentifier:NSStringFromClass([PIHomeItemCell class])];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PIHomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PIHomeItemCell class]) forIndexPath:indexPath];
    
    cell.title = self.dataArr[indexPath.row];
    cell.selected = indexPath.row == 2 ? YES : NO;
    self.firstSelecte = YES;
    if (indexPath.row == 2) {
        
        self.selectIndexPath = indexPath;
    }
    
    if (indexPath.row == 0 || indexPath.row == self.dataArr.count - 1) {
        
        cell.userInteractionEnabled = NO;
    }else {
        
        cell.userInteractionEnabled = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.firstSelecte) {
        
        if (indexPath.row != 2) {
            
            PIHomeItemCell *cell = (PIHomeItemCell *)[collectionView cellForItemAtIndexPath:self.selectIndexPath];
            cell.selected = NO;
            self.firstSelecte = NO;
        }
    }
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSLog(@"%lf", scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
    NSIndexPath *index;
    
    if (scrollView.contentOffset.x <= 65) {
        index = [NSIndexPath indexPathForItem:1 inSection:0];
        
    }else if (scrollView.contentOffset.x >= 165) {
        
        index = [NSIndexPath indexPathForItem:3 inSection:0];
        
    }else {
        
        index = [NSIndexPath indexPathForItem:2 inSection:0];
    }
    
    [self.collection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self scrollToCellIndex:index];
}

- (void)scrollToCellIndex:(NSIndexPath *)index {
    
    
    [self.collection selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

@end
