//
//  JXTabBarViewController.m
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTabBarViewController.h"
#import "JXNavigationController.h"
#import "JXImpressionViewController.h"
#import "JXQuestionViewController.h"
#import <MMDrawerController.h>
#import "JXProfileViewController.h"

@interface JXTabBarViewController () 

@end

@implementation JXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化子控制器
    [self setupChildVC];
    
}

/**
 *  初始化子控制器
 */
- (void)setupChildVC {
    // 印象控制器
    JXImpressionViewController *impresssionVC = [[JXImpressionViewController alloc] init];
    [impresssionVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(0, 128, 255)} forState:UIControlStateSelected];
    [self addChildVC:impresssionVC image:@"tabbar_impression_normal" selectedImage:@"tabbar_impression_selected" title:@"印象"];
    
    // 问答控制器
    JXQuestionViewController *questionVC = [[JXQuestionViewController alloc] init];
    [questionVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(92, 218, 84)} forState:UIControlStateSelected];
    [self addChildVC:questionVC image:@"tabbar_question_normal" selectedImage:@"tabbar_question_selected" title:@"问答"];
}

- (void)addChildVC:(UIViewController *)childVC image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(137, 137, 137)} forState:UIControlStateNormal];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}


@end
