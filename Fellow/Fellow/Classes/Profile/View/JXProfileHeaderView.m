//
//  JXProfileHeaderView.m
//  Fellow
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileHeaderView.h"
#import "JXAccountTool.h"
#import <UIButton+WebCache.h>

@interface JXProfileHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;

@end

@implementation JXProfileHeaderView

- (void)awakeFromNib {
    JXAccount *account = [JXAccountTool currentAccount];
    
    if (account == nil) {
        return;
    }
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:account.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    
    self.nicknameLabel.text = account.nickName;
    
    self.telephoneLabel.text = account.telephone;
}

/**
 *  个人名片按钮被点击
 */
- (IBAction)prifileInfoButtonClicked {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(profileHeaderViewDidClickedProfileInfoButton)]) {
        [self.delegate profileHeaderViewDidClickedProfileInfoButton];
    }
}

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXProfileHeaderView class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)headerHeight {
    return 100;
}

@end
