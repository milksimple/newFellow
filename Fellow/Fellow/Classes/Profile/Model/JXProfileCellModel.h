//
//  JXProfileCellModel.h
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXProfileCellModel : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger badge;

@property (nonatomic, assign) BOOL accessory;

@end
