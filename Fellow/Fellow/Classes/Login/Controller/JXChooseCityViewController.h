//
//  JXChooseCityViewController.h
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXCity;

@protocol JXChooseCityViewControllerDelegate <NSObject>

@optional
- (void)chooseCityViewControllerDidFinishedWithCity:(JXCity *)city;

@end

@interface JXChooseCityViewController : UITableViewController

@property (nonatomic, weak) id<JXChooseCityViewControllerDelegate> delegate;

@end
