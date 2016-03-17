//
//  JXProfileViewController.m
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileViewController.h"
#import "JXProfileTableViewCell.h"
#import "JXProfileCellModel.h"
#import <MJExtension.h>
#import "JXProfileHeaderView.h"
#import <UIViewController+MMDrawerController.h>
#import "JXNavigationController.h"
#import "JXImpressionViewController.h"
#import "JXFriendViewController.h"

@interface JXProfileViewController () <JXProfileHeaderViewDelegate>
/** JXProfileMode数组 */
@property (nonatomic, strong) NSMutableArray *profileModels;

@end

@implementation JXProfileViewController
#pragma mark - 懒加载
- (NSMutableArray *)profileModels {
    if (_profileModels == nil) {
        _profileModels = [JXProfileCellModel mj_objectArrayWithFilename:@"profileModel.plist"];
    }
    return _profileModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JXGlobalBgColor;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JXProfileTableViewCell class]) bundle:nil] forCellReuseIdentifier:[JXProfileTableViewCell reuseIdentifier]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[JXProfileTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        JXProfileCellModel *profileModel = self.profileModels[indexPath.row];
        cell.profileModel = profileModel;
    }
    else if (indexPath.section == 1) {
        JXProfileCellModel *profileModel = self.profileModels[indexPath.row + 5];
        cell.profileModel = profileModel;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        JXProfileHeaderView *header = [JXProfileHeaderView headerView];
        header.delegate = self;
        return header;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [JXProfileHeaderView headerHeight];
    }
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: { // 我的好友
                JXFriendViewController *friendVC = [[JXFriendViewController alloc] init];
                JXNavigationController *friendNav = [[JXNavigationController alloc] initWithRootViewController:friendVC];
                
                [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                    CATransition * animation = [CATransition animation];
                    animation.subtype = kCATransitionFromRight;
                    friendVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:friendNav animated:YES completion:nil];
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - JXProfileHeaderViewDelegate
- (void)profileHeaderViewDidClickedProfileInfoButton {
    
}

- (void)dealloc {
    JXLog(@"JXProfileViewController - dealloc");
}

@end
