//
//  PIMoreController.m
//  Parking
//
//  Created by apple on 2018/5/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIMoreController.h"
#import "PIBaseDetailCell.h"
#import "PIAboutUsController.h"

@interface PIMoreController ()

@end

@implementation PIMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多";
    
    [self setupUI];
}

- (void)setupUI {
    
    
    [self setupTableViewWithFrame:CGRectMake(0, NavBarHeight + 20, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - 20)];
    
    self.tableView.rowHeight = 60;
    
    [self.tableView registerClass:[PIBaseDetailCell class] forCellReuseIdentifier:NSStringFromClass([PIBaseDetailCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"More"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"More"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = indexPath.row == 0 ? @"去评分" : @"关于我们";
        cell.textLabel.font = PISYS_FONT(18);
        return cell;
    }else {
        
        PIBaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PIBaseDetailCell class])];
        
        cell.titleString = @"当前版本";
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        cell.contentString = [NSString stringWithFormat:@"%@  ", version];
        cell.commentLabel.textAlignment = NSTextAlignmentRight;
        cell.contentColor = txtPlaceColor;
        cell.titleLabel.font = PISYS_FONT(18);
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        PIAboutUsController *about = [PIAboutUsController new];
        
        [self.navigationController pushViewController:about animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
