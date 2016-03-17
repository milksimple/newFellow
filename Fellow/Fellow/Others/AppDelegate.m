//
//  AppDelegate.m
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "JXTabBarViewController.h"
#import "JXNavigationController.h"
#import "JXLoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "JXAccountTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 判断之前是否登录过
    JXAccount *currentAccount = [JXAccountTool currentAccount];
    if (!currentAccount.hasLogin) {
        self.window.rootViewController = [[JXTabBarViewController alloc] init];
    }
    else {
        JXLoginViewController *loginVC = [[JXLoginViewController alloc] init];
        self.window.rootViewController = [[JXNavigationController alloc] initWithRootViewController:loginVC];
    }
    
    [self.window makeKeyAndVisible];
    
    [SMSSDK registerApp:@"10751ebd46e57" withSecret:@"08eb192375caa652010ae05430169a95"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
