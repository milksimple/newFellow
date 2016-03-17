//
//  JXProfileTableViewCell.h
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXProfileCellModel;

@interface JXProfileTableViewCell : UITableViewCell

@property (nonatomic, strong) JXProfileCellModel *profileModel;

+ (NSString *)reuseIdentifier;

@end
