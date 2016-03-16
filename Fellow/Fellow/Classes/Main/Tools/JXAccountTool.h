//
//  JXAccountTool.h
//  JMXMiJia
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXAccount.h"

@interface JXAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(JXAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (JXAccount *)accountWithTelephone:(NSString *)telephone;

/**
 *  返回当前登录的账号信息
 */
+ (JXAccount *)currentAccount;

/**
 *  存储当前登录的账号信息
 *
 *  @param currentAccount 当前登录的账号信息
 */
+ (void)saveCurrentAccount:(JXAccount *)currentAccount;
@end
