//
//  JXProfileHeaderView.h
//  Fellow
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXProfileHeaderViewDelegate <NSObject>

@optional
- (void)profileHeaderViewDidClickedProfileInfoButton;

@end

@interface JXProfileHeaderView : UIView

@property (nonatomic, weak) id<JXProfileHeaderViewDelegate> delegate;

+ (instancetype)headerView;

+ (CGFloat)headerHeight;

@end
