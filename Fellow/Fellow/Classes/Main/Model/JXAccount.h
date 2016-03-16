//
//  JXAccount.h
//  Fellow
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//

/*
    img = ;
	workCom = 0;
	age = 0;
	hometown = 3;
	telephone = 18213827534;
	sex = -1;
	nickName = ;
 
 */

#import <Foundation/Foundation.h>

@interface JXAccount : NSObject <NSCoding>

/** 所在地区名称 */
@property (nonatomic, copy) NSString *currentCity;
/** 头像地址 */
@property (nonatomic, copy) NSString *img;
/** 工作公司 */
@property (nonatomic, copy) NSString *workCom;
/** 性别 */
@property (nonatomic, assign) NSInteger sex;
/** 家乡城市ID */
@property (nonatomic, assign) NSInteger hometown;
/** 电话 */
@property (nonatomic, copy) NSString *telephone;
/** 年龄 */
@property (nonatomic, assign) NSInteger age;
/** 昵称 */
@property (nonatomic, copy) NSString *nickName;
/** 是否登录过 */
@property (nonatomic, assign) BOOL hasLogin;
@end
