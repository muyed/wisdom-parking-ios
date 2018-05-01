//
//  PIAddCarHeaderView.h
//  Parking
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIAddCarHeaderView : UITableViewHeaderFooterView

+ (instancetype)addcarHeaderView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *titles;
@end
