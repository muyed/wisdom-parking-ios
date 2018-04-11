//
//  PISearchBar.m
//  Parking
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PISearchBar.h"

@implementation PISearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        
        
        self.font = [UIFont systemFontOfSize:15.0];
        
        self.placeholder = @"请输入搜索条件";
        
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] init];
        
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        searchIcon.width = 30;
        
        searchIcon.height = 30;
        
        self.leftView = searchIcon;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        
        searchIcon.contentMode = UIViewContentModeCenter;
        
        
    }
    
    return self;
}

+ (instancetype)searchBar {
    
    
    return [[self alloc ] init];
}

@end
