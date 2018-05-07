//
//  PIAcountModel.h
//  Parking
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIAcountModel : NSObject

///-- <#Notes#>
@property (nonatomic, assign) CGFloat balance;
///-- <#Notes#>
@property (nonatomic, copy) NSString *cash;
///-- <#Notes#>
@property (nonatomic, copy) NSString *createTime;
///-- <#Notes#>
@property (nonatomic, copy) NSString *ID;
///-- <#Notes#>
@property (nonatomic, copy) NSString *modifyTime;
///-- <#Notes#>
@property (nonatomic, copy) NSString *ranges;
///-- <#Notes#>
@property (nonatomic, copy) NSString *sorts;
///-- <#Notes#>
@property (nonatomic, copy) NSString *userId;
@end
