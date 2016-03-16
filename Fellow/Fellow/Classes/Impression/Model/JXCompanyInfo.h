//
//  JXCompanyInfo.h
//  Fellow
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//  公司信息

#import <Foundation/Foundation.h>

@interface JXCompanyInfo : NSObject

/** 公司名称 */
@property (nonatomic, copy) NSString *comName;
/** 公司ID */
@property (nonatomic, assign) NSInteger comId;
/** 在该公司任职老乡人数 */
@property (nonatomic, assign) NSInteger numWorkers;
/** 岗位数 */
@property (nonatomic, assign) NSInteger numJobs;
/** 对该公司的评论人数 */
@property (nonatomic, assign) NSInteger numPraises;
/** 图片数 */
@property (nonatomic, assign) NSInteger numImages;
/** 总评论数 */
@property (nonatomic, assign) NSInteger numComments;
/** 附近合租人数 */
@property (nonatomic, assign) NSInteger numRoommates;
/** 印象(里面是JXImpression对象) */
@property (nonatomic, strong) NSArray *impressions;
/** 公司地址 */
@property (nonatomic, copy) NSString *address;

@end
