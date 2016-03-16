//
//  JXFilterToolbar.m
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXFilterToolbar.h"

@implementation JXFilterToolbar

+ (instancetype)toolbar {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXFilterToolbar class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)toolbarHeight {
    return 44;
}

@end
