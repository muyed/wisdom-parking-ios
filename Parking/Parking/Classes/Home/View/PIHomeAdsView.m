//
//  PIHomeAdsView.m
//  Parking
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeAdsView.h"
#import "PINoticeModel.h"
#import "PIHomeNoticeCell.h"
#import "PINoticeViewController.h"

static CGFloat const TimerIntervals = 2.0;

@interface PIHomeAdsView ()<UICollectionViewDelegate, UICollectionViewDataSource>

///-- 广播
@property (nonatomic, strong) UIImageView *broadcastView;
///-- 提示
@property (nonatomic, strong) UILabel *tipLabel;
///-- 箭头
@property (nonatomic, strong) UIImageView *rowImageView;
///-- 广告数据
@property (nonatomic, strong) PINoticeModel *noticeModel;
///-- <#Notes#>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation PIHomeAdsView
{
    
    NSTimer *_timer;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self loadData];
        [self setupUI];
    }
    
    return self;
}

- (void)loadData {
    
    weakself
    
    [PIHttpTool piGet:urlPath(@"api/notice/list") params:nil success:^(id response) {
        
        weakSelf.noticeModel = [PINoticeModel mj_objectWithKeyValues:response];
        
        
        [weakSelf.collectionView reloadData];
        
        if (weakSelf.noticeModel.code == 200) {
            
            [weakSelf startTimer];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}
- (void)setupUI {
    
    [self addSubview:self.broadcastView];
    [self addSubview:self.tipLabel];
    [self addSubview:self.rowImageView];
    [self addSubview:self.collectionView];
    
    weakself
    
    [self.broadcastView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).offset(10);
        make.height.and.width.mas_equalTo(30);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.rowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).offset(-5);
        make.height.and.width.mas_equalTo(35);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.broadcastView.mas_right).offset(5);
        make.right.equalTo(weakSelf.rowImageView.mas_left).offset(5);
        make.top.and.bottom.equalTo(weakSelf);
    }];
    
   
    [self.collectionView registerClass:[PIHomeNoticeCell class] forCellWithReuseIdentifier:NSStringFromClass([PIHomeNoticeCell class])];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //return self.dataArr.count;
    return self.noticeModel.data.count >  0 ? self.noticeModel.data.count : 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PIHomeNoticeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PIHomeNoticeCell class]) forIndexPath:indexPath];
    
    
    cell.notice = self.noticeModel.data.count >  0 ? self.noticeModel.data[indexPath.row].title : @"暂无公告";
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PINoticeViewController *notice = [PINoticeViewController new];
    notice.noticeData = self.noticeModel.data[indexPath.row];
    
    [self.parentController.navigationController pushViewController:notice animated:YES];
}

- (void)startTimer {
    
    [_timer invalidate];
    _timer = nil;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:TimerIntervals target:self selector:@selector(startAutoScroll) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
}

- (void)startAutoScroll {
    
    // －－ 获取上次的索引
    NSInteger currentIndex = _collectionView.contentOffset.y/_collectionView.frame.size.height;
    
    // NSLog(@"%lu", currentIndex);
    // -- 下一个label
    currentIndex += 1;
    
    if (currentIndex >= self.noticeModel.data.count) {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        
        
    }else {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

- (UIImageView *)broadcastView {
    
    if (!_broadcastView) {
        
        _broadcastView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_broadcast"]];
        
    }
    
    return _broadcastView;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        
        _tipLabel = [[UILabel alloc] initWithFont:16 textColor:txtMainColor];
        _tipLabel.text = @"抢月卡，详情信息，戳此抢购";
        //_tipLabel.backgroundColor = [UIColor redColor];
    }
    
    return _tipLabel;
}

- (UIImageView *)rowImageView {
    
    if (!_rowImageView) {
        
        _rowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_right_row"]];
    }
    
    return _rowImageView;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH - 90, 40);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
    }
    
    return _collectionView;
}
@end
