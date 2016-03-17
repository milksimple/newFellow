//
//  JXProfileTableViewCell.m
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileTableViewCell.h"
#import "JXProfileCellModel.h"

@interface JXProfileTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeView;
@property (weak, nonatomic) IBOutlet UIImageView *accesView;

@end

@implementation JXProfileTableViewCell

- (void)setProfileModel:(JXProfileCellModel *)profileModel {
    _profileModel = profileModel;
    
    self.badgeView.hidden = !profileModel.badge;
    self.badgeView.text = [NSString stringWithFormat:@"%zd", profileModel.badge];
    
    self.imageView.image = [UIImage imageNamed:profileModel.imageName];
    
    self.titleLabel.text = profileModel.title;
    
    self.accesView.hidden = !profileModel.accessory;
    
}

+ (NSString *)reuseIdentifier {
    return @"profileCell";
}
@end
