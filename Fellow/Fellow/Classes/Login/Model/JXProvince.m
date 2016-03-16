//
//  JXProvince.m
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProvince.h"
#import <MJExtension.h>
#import "JXCity.h"

@implementation JXProvince

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cityes":[JXCity class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end
