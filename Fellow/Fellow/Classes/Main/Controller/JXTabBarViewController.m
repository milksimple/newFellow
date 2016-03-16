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
    JXImpressionViewController *impresssionVC = [[JXImpressionViewController alloc] init];
    [self addChildVC:impresssionVC image:@"tabbar_impression_normal" selectedImage:@"tabbar_impression_selected" title:@"印象"];
    [impresssionVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(29, 142, 252)} forState:UIControlStateSelected];
    
    JXQuestionViewController *questionVC = [[JXQuestionViewController alloc] init];
    [self addChildVC:questionVC image:@"tabbar_question_normal" selectedImage:@"tabbar_question_selected" title:@"问答"];
    [questionVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(92, 218, 84)} forState:UIControlStateSelected];
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
