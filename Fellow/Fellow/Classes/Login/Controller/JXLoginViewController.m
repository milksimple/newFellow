//
//  JXLoginViewController.m
//  Fellow
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXLoginViewController.h"
#import "JXRegisterViewController.h"
#import "MBProgressHUD+MJ.h"
#import "JXHttpTool.h"
#import "JXTabBarViewController.h"
#import "JXAccountTool.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

@interface JXLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation JXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航栏样式
    [self setupNav];

    // 初始化textField样式
    [self setupTextField];
    
}

/**
 *  初始化导航栏样式
 */
- (void)setupNav {
    self.navigationController.navigationBar.barTintColor = JXColor(75, 141, 253);
    self.navigationItem.title = @"登 录";
}

/**
 *  初始化textField样式
 */
- (void)setupTextField {
    UIImageView *usernameImage = [[UIImageView alloc] init];
    usernameImage.contentMode = UIViewContentModeCenter;
    usernameImage.image = [UIImage imageNamed:@"login_username"];
    usernameImage.frame = CGRectMake(0, 0, 44, 44);
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameTextField.leftView = usernameImage;
    
    UIImageView *pwdImage = [[UIImageView alloc] init];
    pwdImage.contentMode = UIViewContentModeCenter;
    pwdImage.image = [UIImage imageNamed:@"login_pwd"];
    pwdImage.frame = CGRectMake(0, 0, 44, 44);
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = pwdImage;
    
    // 监听用户名输入
    self.usernameTextField.delegate = self;
}


- (IBAction)login {
    if (self.usernameTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        [MBProgressHUD showError:@"请将信息填写完整"];
        return;
    }
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"telephone"] = self.usernameTextField.text;
    paras[@"password"] = self.passwordTextField.text;
    [MBProgressHUD showMessage:@"正在登录"];
    [JXHttpTool post:[NSString stringWithFormat:@"%@/LoginCheck", JXServerName] params:paras success:^(id json) {
        [MBProgressHUD hideHUD];
        JXLog(@"登录json = %@", json);
        BOOL success = [json[@"success"] boolValue];
        if (success) { // 登录成功
            // 存储账号信息
            JXAccount *account = [JXAccount mj_objectWithKeyValues:json[@"user"]];
            account.hasLogin = YES;
            [JXAccountTool saveAccount:account];
            // 存储当前登录账号信息
            [JXAccountTool saveCurrentAccount:account];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[JXTabBarViewController alloc] init];
        }
        else { // 登录失败
            [MBProgressHUD showError:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        JXLog(@"登录请求失败 - %@", error);
    }];
}

- (IBAction)forgotPassword {
    
}

- (IBAction)registerButtonClicked {
    JXRegisterViewController *registerVC = [[JXRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // 在沙盒找到当前输入账号的账号信息
    JXAccount *account = [JXAccountTool accountWithTelephone:self.usernameTextField.text];
    if (account.img.length != 0) {
        // 设置对应账号的对应头像
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:account.img] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    }
    return YES;
}

@end
