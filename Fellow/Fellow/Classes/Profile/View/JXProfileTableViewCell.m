//
//  JXProfileTableViewCell.m
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileTableViewCell.h"

@interface JXProfileTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeView;
@property (weak, nonatomic) IBOutlet UIImageView *accesView;

@end

@implementation JXProfileTableViewCell

- (void)setBadge:(NSInteger)badge {
    _badge = badge;
    
    self.badgeView.hidden = !badge;
    self.badgeView.text = [NSString stringWithFormat:@"%zd", badge];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setAccessory:(BOOL)accessory {
    _accessory = accessory;
    
    self.accesView.hidden = !accessory;
}

+ (NSString *)reuseIdentifier {
    return @"profileCell";
}
@end
