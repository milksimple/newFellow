//
//  JXProvince.h
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXProvince : NSObject
/** 省份ID */
@property (nonatomic, assign) NSInteger ID;
/** 省份名称 */
@property (nonatomic, copy) NSString *name;
/** 包含的二级城市,里面是JXCity模型 */
@property (nonatomic, strong) NSArray *cityes;
@end
