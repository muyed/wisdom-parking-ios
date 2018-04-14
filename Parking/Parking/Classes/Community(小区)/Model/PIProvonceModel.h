//
//  PIProvonceModel.h
//  Parking
//
//  Created by apple on 2018/4/13.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PICitiesModel;

@interface PIProvonceModel : NSObject

@property (nonatomic, copy) NSString *State;

@property (nonatomic, copy) NSArray<PICitiesModel *> *Cities;

@end

@interface PICitiesModel : NSObject

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *lon;
@end

