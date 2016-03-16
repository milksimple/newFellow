//
//  JXImpressionViewController.m
//  Fellow
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXImpressionViewController.h"
#import "JXFilterToolbar.h"
#import "JXImpressionCell.h"
#import <CoreLocation/CoreLocation.h>
#import "JXHttpTool.h"
#import "JXAccountTool.h"
#import <MJExtension.h>
#import "JXCompanyInfo.h"
#import "JXImpression.h"

@interface JXImpressionViewController () <CLLocationManagerDelegate>
/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;
/** 地理编码 */
@property (nonatomic, strong) CLGeocoder *gecoder;
/** 当前城市 */
@property (nonatomic, copy) NSString *currentCity;
/** 公司信息数组 */
@property (nonatomic, strong) NSMutableArray *companyInfos;
@end

@implementation JXImpressionViewController
#pragma mark - 懒加载
- (CLLocationManager *)locMgr {
    if (_locMgr == nil) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
        
    }
    return _locMgr;
}

- (CLGeocoder *)gecoder {
    if (_gecoder == nil) {
        _gecoder = [[CLGeocoder alloc] init];
    }
    return _gecoder;
}

- (NSString *)currentCity {
    if (_currentCity == nil) {
        JXAccount *account = [JXAccountTool currentAccount];
        _currentCity = account.currentCity;
        if (_currentCity == nil) {
            _currentCity = @"昆明市";
        }
    }
    return _currentCity;
}

- (NSMutableArray *)companyInfos {
    if (_companyInfos == nil) {
        _companyInfos = [NSMutableArray array];
    }
    return _companyInfos;
}


- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    [self setupNavTitle];
    // 设置导航栏头像
    [self setupNavIcon];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JXImpressionCell class]) bundle:nil] forCellReuseIdentifier:[JXImpressionCell reuseIdentifier]];
    
    // 初始化定位
    [self setupLocation];
    
    [self loadNewImpressions];
    
}

/**
 *  初始化定位
 */
- (void)setupLocation {
    if (iOS8) {
        if ([self.locMgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locMgr requestWhenInUseAuthorization];
            
            if ([CLLocationManager locationServicesEnabled]) {
                [self.locMgr startUpdatingLocation];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法进行定位" message:@"请检查您的设备是否开启定位功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    else {
        if ([CLLocationManager locationServicesEnabled]) {
            [self.locMgr startUpdatingLocation];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法进行定位" message:@"请检查您的设备是否开启定位功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

/**
 *  设置导航栏标题
 */
- (void)setupNavTitle {
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.adjustsImageWhenHighlighted = NO;
    titleButton.frame = CGRectMake(0, 0, 120, 36);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [titleButton setTitle:@"企业印象" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:22];
    self.navigationController.navigationBar.barTintColor = JXColor(75, 141, 253);
    [titleButton setImage:[UIImage imageNamed:@"nav_impression"] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleButton;
}

/**
 *  设置导航栏头像
 */
- (void)setupNavIcon {
    UIButton *iconButton = [[UIButton alloc] init];
    iconButton.layer.borderColor = [UIColor whiteColor].CGColor;
    iconButton.layer.borderWidth = 1;
    iconButton.layer.cornerRadius = 20;
    iconButton.clipsToBounds = YES;
    [iconButton setImage:[UIImage imageNamed:@"nav_icon_placeholder"] forState:UIControlStateNormal] ;
    iconButton.frame = CGRectMake(0, 0, 40, 40);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconButton];
}

/**
 *  加载企业印象信息
 */
- (void)loadNewImpressions {
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"pageCount"] = @0;
    paras[@"pageSize"] = @8;
    paras[@"areaName"] = self.currentCity;
    paras[@"hometown"] = @0;
    [JXHttpTool post:[NSString stringWithFormat:@"%@/ListComImpression", JXServerName] params:paras success:^(id json) {
        JXLog(@"请求成功 - %@", json);
        JXLog(@"%@", json[@"impOvs"]);
        self.companyInfos = [JXCompanyInfo mj_objectArrayWithKeyValuesArray:json[@"impOvs"]];
        JXLog(@"count = %zd", self.companyInfos.count);
        for (JXCompanyInfo *comInfo in self.companyInfos) {
            JXLog(@"%@", comInfo.address);
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        JXLog(@"请求失败 - %@", error);
    }];
}

#pragma mark - tableview datasource, delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.companyInfos.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXImpressionCell *cell = [tableView dequeueReusableCellWithIdentifier:[JXImpressionCell reuseIdentifier] forIndexPath:indexPath];
    // 设置数据
    cell.companyInfo = self.companyInfos[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [JXImpressionCell rowHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [JXFilterToolbar toolbarHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXFilterToolbar *toolbar = [JXFilterToolbar toolbar];
    
    return toolbar;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    // 反地理编码出城市信息
    [self.gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            if (![self.currentCity isEqualToString:placemark.locality]) { // 用户换了城市
                self.currentCity = placemark.locality;
                JXAccount *account = [JXAccountTool currentAccount];
                account.currentCity = placemark.locality;
                [JXAccountTool saveAccount:account];
                
                // 刷新tableview
                [self loadNewImpressions];
            }
        }
        
    }];
    
    [manager stopUpdatingLocation];
}

@end
