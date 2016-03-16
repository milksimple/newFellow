//
//  JXCompanyInfo.m
//  Fellow
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXCompanyInfo.h"
#import <MJExtension.h>
#import "JXImpression.h"

@implementation JXCompanyInfo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"impressions":[JXImpression class]};
}

@end
