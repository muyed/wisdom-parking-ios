//
//  PIAddSubViewCell.h
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickIndex)(NSInteger index);
@interface PIAddSubViewCell : UITableViewCell

///-- 下标
@property (nonatomic, assign) NSInteger index;

///-- 点击回调
@property (nonatomic, copy) ClickIndex clickIndex;

@end
