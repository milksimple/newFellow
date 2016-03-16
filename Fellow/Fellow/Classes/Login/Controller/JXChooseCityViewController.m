//
//  JXChooseCityViewController.m
//  Fellow
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChooseCityViewController.h"
#import "JXProvince.h"
#import "JXCity.h"
#import <MJExtension.h>
#import "JXTableViewHeaderFooterView.h"

@interface JXChooseCityViewController ()
/** 省份数组 */
@property (nonatomic, strong) NSMutableArray *provinces;

@end

@implementation JXChooseCityViewController
#pragma mark - 常量
static NSString * const cityCellID = @"cityCellID";
static NSString * const provinceHeaderID = @"provinceHeaderID";

#pragma mark - 懒加载
- (NSMutableArray *)provinces {
    if (_provinces == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area.txt" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _provinces = [JXProvince mj_objectArrayWithKeyValuesArray:json[@"provinces"]];
    }
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCellID];
    [self.tableView registerClass:[JXTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:provinceHeaderID];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.provinces.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JXProvince *province = self.provinces[section];
    return province.cityes.count;
}

#pragma table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellID forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    JXProvince *province = self.provinces[indexPath.section];
    JXCity *city = province.cityes[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXTableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:provinceHeaderID];
    JXProvince *province = self.provinces[section];
    header.textLabel.text = province.name;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(chooseCityViewControllerDidFinishedWithCity:)]) {
        JXProvince *province = self.provinces[indexPath.section];
        JXCity *city = province.cityes[indexPath.row];
        [self.delegate chooseCityViewControllerDidFinishedWithCity:city];
    }
}
@end
