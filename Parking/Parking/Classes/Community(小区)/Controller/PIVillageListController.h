//
//  PIVillageListController.h
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

@class PIVillageDataModel;

typedef void(^VillageID)(PIVillageDataModel *villageModel);

@interface PIVillageListController : PIBaseViewController

/**
 <#Description#>
 */
@property (nonatomic, copy) VillageID villageID;

@end
