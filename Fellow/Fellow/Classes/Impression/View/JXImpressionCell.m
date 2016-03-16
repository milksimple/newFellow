//
//  JXImpressionCell.m
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXImpressionCell.h"
#import "Fellow-swift.h"
#import "JXCompanyInfo.h"
#import "JXImpression.h"

@interface JXImpressionCell()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;


/** 波浪1 */
@property (nonatomic, weak) WaveLoadingIndicator *wave1;
/** 波浪2 */
@property (nonatomic, weak) WaveLoadingIndicator *wave2;
/** 波浪3 */
@property (nonatomic, weak) WaveLoadingIndicator *wave3;
/** 波浪4 */
@property (nonatomic, weak) WaveLoadingIndicator *wave4;

@property (weak, nonatomic) IBOutlet UILabel *impressionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *impressionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *impressionLabel3;
@property (weak, nonatomic) IBOutlet UILabel *impressionLabel4;

/** 任职老乡数 */
@property (weak, nonatomic) IBOutlet UILabel *numWorkersLabel;
/** 总评论人数 */
@property (weak, nonatomic) IBOutlet UILabel *numpraisesLabel;
/** 合租数 */
@property (weak, nonatomic) IBOutlet UILabel *numRoommatesLabel;

/** 地址 */
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
/** 岗位数 */
@property (weak, nonatomic) IBOutlet UIButton *numJobsButton;
/** 图片数 */
@property (weak, nonatomic) IBOutlet UIButton *numImagesButton;
/** 评论数 */
@property (weak, nonatomic) IBOutlet UIButton *numCommentsButton;

@property (nonatomic, weak) UIImageView *iconView;
@end

@implementation JXImpressionCell

- (void)awakeFromNib {
    WaveLoadingIndicator *wave1 = [[WaveLoadingIndicator alloc] init];
    [self.view1 addSubview:wave1];
    self.wave1 = wave1;
    wave1.frame = self.view1.bounds;
    wave1.progress = 0.5;
    wave1.waveAmplitude = 5;
    wave1.titleText = @"129";
    wave1.backgroundColor = [UIColor whiteColor];
    
    self.wave1 = [self addWaveViewInView:self.view1];
    self.wave2 = [self addWaveViewInView:self.view2];
    self.wave3 = [self addWaveViewInView:self.view3];
    self.wave4 = [self addWaveViewInView:self.view4];
}

- (WaveLoadingIndicator *)addWaveViewInView:(UIView *)view {
    WaveLoadingIndicator *wave = [[WaveLoadingIndicator alloc] init];
    [view addSubview:wave];
    wave.frame = self.view1.bounds;
    wave.progress = 0.5;
    wave.waveAmplitude = 5;
    wave.backgroundColor = [UIColor whiteColor];
    return wave;
}

- (void)setCompanyInfo:(JXCompanyInfo *)companyInfo {
    _companyInfo = companyInfo;
    
    self.numWorkersLabel.text = [NSString stringWithFormat:@"%zd", companyInfo.numWorkers];
    self.numpraisesLabel.text = [NSString stringWithFormat:@"%zd", companyInfo.numPraises];
    self.numRoommatesLabel.text = [NSString stringWithFormat:@"%zd", companyInfo.numRoommates];
    
    /** 地址 */
    [self.addressButton setTitle:companyInfo.address forState:UIControlStateNormal];
    /** 岗位数 */
    [self.numJobsButton setTitle:[NSString stringWithFormat:@"%zd", companyInfo.numJobs] forState:UIControlStateNormal];
    /** 图片数 */
    [self.numImagesButton setTitle:[NSString stringWithFormat:@"%zd", companyInfo.numImages] forState:UIControlStateNormal];
    /** 评论数 */
    [self.numCommentsButton setTitle:[NSString stringWithFormat:@"%zd", companyInfo.numComments] forState:UIControlStateNormal];
}

+ (NSString *)reuseIdentifier {
    return @"impressionCell";
}

+ (CGFloat)rowHeight {
    return 170;
}

@end
