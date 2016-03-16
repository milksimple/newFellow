//
//  JXAccountTool.m
//  JMXMiJia
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//

// 账号的存储路径
#define JXAccountPath(telephone) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"account_%@.archive", telephone]]
// 当前登录的账号存储路径
#define JXCurrentAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"currentAccount.archive"]

#import "JXAccountTool.h"

@implementation JXAccountTool
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(JXAccount *)account
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:JXAccountPath(account.telephone)];
}

/**
 *  返回账号信息，如果不存在返回nil
 *
 *  @return 账号模型
 */
+ (JXAccount *)accountWithTelephone:(NSString *)telephone
{
    // 加载模型
    JXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:JXAccountPath(telephone)];
//    if (account == nil) {
//        account = [[JXAccount alloc] init];
//    }
    return account;
}

/**
 *  返回当前登录的账号信息, 如果不存在返回nil
 */
+ (JXAccount *)currentAccount {
    // 加载模型
    JXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:JXCurrentAccountPath];
    
    return account;
}

/**
 *  存储当前登录的账号信息
 *
 *  @param currentAccount 当前登录的账号信息
 */
+ (void)saveCurrentAccount:(JXAccount *)currentAccount {
    [NSKeyedArchiver archiveRootObject:currentAccount toFile:JXCurrentAccountPath];
}

@end
