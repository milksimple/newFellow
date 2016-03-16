//
//  JXImpressionCell.h
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXCompanyInfo;

@interface JXImpressionCell : UITableViewCell
/** 公司信息模型 */
@property (nonatomic, strong) JXCompanyInfo *companyInfo;

+ (NSString *)reuseIdentifier;

+ (CGFloat)rowHeight;
@end
