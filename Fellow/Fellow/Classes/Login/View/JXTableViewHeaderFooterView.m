//
//  JXTableViewHeaderFooterView.m
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTableViewHeaderFooterView.h"

@implementation JXTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.textLabel setFont:[UIFont systemFontOfSize:13]];
    self.textLabel.textColor = [UIColor lightGrayColor];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [self.textLabel setFont:[UIFont systemFontOfSize:13]];
}

@end
