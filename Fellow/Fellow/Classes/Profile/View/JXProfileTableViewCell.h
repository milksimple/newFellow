//
//  JXProfileTableViewCell.h
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXProfileTableViewCell : UITableViewCell
/** 数字 */
@property (nonatomic, assign) NSInteger badge;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL accessory;

+ (NSString *)reuseIdentifier;

@end
