//
//  PIMyBankCardCell.h
//  Parking
//
//  Created by apple on 2018/5/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PIMyCardsModel.h"

typedef void(^DeleteCard)(PIMyCardsDataModel *dataModel);
@interface PIMyBankCardCell : UITableViewCell

///-- <#Notes#>
@property (nonatomic, strong) PIMyCardsDataModel *dataModel;
///-- <#Notes#>
@property (nonatomic, copy) DeleteCard deleteCard;
@end
