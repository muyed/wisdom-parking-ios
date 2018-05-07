//
//  PIHomeSearchController.h
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIBaseViewController.h"

typedef void(^DestinationCoor)(CGFloat lat, CGFloat lon);

@interface PIHomeSearchController : PIBaseViewController

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *addrssKeyWord;
///-- <#Notes#>
@property (nonatomic, copy) DestinationCoor destinationCoor;
@end
