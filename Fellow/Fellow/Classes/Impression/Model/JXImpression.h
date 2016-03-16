//
//  JXImpression.h
//  Fellow
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//  印象信息

/*
 address = 金色交响家园(云南省昆明市盘龙区东三环路);
	comName = 云南星长征1;
	numWorkers = 0;
	numJobs = 0; 岗位
	numPraises = 0; 评论人数
	numImages = 0; 有图
	numComments = 0; 评论
	impressions = (
 );
	comId = 1439344696744;
	numRoommates = 0; 合租
 */

#import <Foundation/Foundation.h>

@interface JXImpression : NSObject
/** 印象描述 */
@property (nonatomic, copy) NSString *label;
/** 评论数 */
@property (nonatomic, assign) NSInteger count;

@end
