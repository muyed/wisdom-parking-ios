//
//  PIMyParkingCollectionCell.h
//  Parking
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PIMyParkDataModel;

@interface PIMyParkingCollectionCell : UICollectionViewCell

///-- <#Notes#>
@property (nonatomic, strong) PIMyParkDataModel *model;

///-- <#Notes#>
@property (nonatomic, assign) NSInteger index;
@end
