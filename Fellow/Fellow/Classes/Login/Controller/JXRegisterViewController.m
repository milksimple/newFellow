//
//  JXRegisterViewController.m
//  Fellow
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXRegisterViewController.h"
#import "MBProgressHUD+MJ.h"
#import <SMS_SDK/SMSSDK.h>
#import "JXHttpTool.h"
#import "JXChooseCityViewController.h"
#import "JXCity.h"

@interface JXRegisterViewController () <JXChooseCityViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *hometownField;
/** 家乡buuton */
@property (weak, nonatomic) IBOutlet UIButton *hometownButton;
@property (weak, nonatomic) IBOutlet UITextField *verifiField;
/** 获取验证码按钮 */
@property (nonatomic, weak) UIButton *getVerifiButton;
/** 同意协议按钮 */
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 家乡城市 */
@property (nonatomic, strong) JXCity *hometownCity;
@end

@implementation JXRegisterViewController
/** 倒计时 */
static NSInteger _timeout = 60;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"用户注册";
    
    // 初始化textField样式
    [self setupTextField];
    
    // 初始化获取验证码按钮
    [self setupVerfiButton];
    
}

/**
 *  初始化textField样式
 */
- (void)setupTextField {
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
    
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
    
    self.hometownField.leftViewMode = UITextFieldViewModeAlways;
    self.hometownField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
    
    self.verifiField.leftViewMode = UITextFieldViewModeAlways;
    self.verifiField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置家乡
    self.hometownField.text = self.hometownCity.name;
}

/**
 *  初始化获取验证码按钮
 */
- (void)setupVerfiButton {
    self.verifiField.rightViewMode = UITextFieldViewModeAlways;
    UIButton *getVerifiButton = [[UIButton alloc] init];
    getVerifiButton.layer.cornerRadius = 5;
    getVerifiButton.backgroundColor = [UIColor lightGrayColor];
    getVerifiButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [getVerifiButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    getVerifiButton.frame = CGRectMake(0, 0, 120, 30);
    self.verifiField.rightView = getVerifiButton;
    self.getVerifiButton = getVerifiButton;
    
    [getVerifiButton addTarget:self action:@selector(getVerifiButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  选择家乡按钮被点击了
 */
- (IBAction)hometownButtonClicked {
    JXChooseCityViewController *chooseCityVC = [[JXChooseCityViewController alloc] init];
    chooseCityVC.delegate = self;
    [self.navigationController pushViewController:chooseCityVC animated:YES];
}

/**
 *  获取验证码被点击
 */
- (void)getVerifiButtonClicked {
    if (self.usernameField.text.length == 0) {
        [MBProgressHUD showError:@"请填写手机号"];
    }
    else {
        // 1.先判断手机号是否已经被注册
        [MBProgressHUD showMessage:@"正在获取验证码"];
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"telephone"] = self.usernameField.text;
        [JXHttpTool post:[NSString stringWithFormat:@"%@/CheckTelephone", JXServerName] params:paras success:^(id json) {
            [MBProgressHUD hideHUD];
            
            BOOL success = [json[@"success"] boolValue];
            if (!success) { // 手机号已经被注册
                [MBProgressHUD showError:@"手机号已被注册，请直接登录"];
                return;
            }
            else { // 手机号可用,可以发送验证码
                // button不可用
                self.getVerifiButton.enabled = NO;
                // button显示倒计时
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                
                // 获取验证码
                [self getVerificationCode];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            JXLog(@"请求失败 - %@", error);
        }];
    }
}

/**
 *  获取验证码
 */
- (void)getVerificationCode {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.usernameField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            [MBProgressHUD showSuccess:@"验证码已发送"];
            JXLog(@"获取验证码成功");
        }
        else {
            [MBProgressHUD showError:@"验证码发送失败，请1分钟后重试"];
            JXLog(@"获取验证码失败 - %@", error);
        }
    }];
}

/**
 *  倒计时
 */
- (void)countDown {
    _timeout --;
    [self.getVerifiButton setTitle:[NSString stringWithFormat:@"重新获取验证码(%zds)", _timeout] forState:UIControlStateNormal];
    if (_timeout <= 0) { // 停止倒计时
        _timeout = 60;
        [self.timer invalidate];
        self.timer = nil;
        self.getVerifiButton.enabled = YES;
        [self.getVerifiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (IBAction)agreeButtonClicked:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)serviceButtonClicked {
    
}

- (IBAction)registerButtonClicked {
    // 0.判断信息是否填写完整
    if (self.usernameField.text.length == 0 || self.passwordField.text.length == 0 || self.hometownField.text.length == 0 || self.verifiField.text.length == 0) {
        [MBProgressHUD showError:@"请将信息填写完整"];
        return;
    }
    
    if (self.agreeButton.selected == NO) {
        [MBProgressHUD showError:@"请仔细阅读老乡侃服务协议，并选择同意"];
        return;
    }
    
    // 1.验证验证码
    [MBProgressHUD showMessage:@"正在注册"];
    
    [SMSSDK commitVerificationCode:self.verifiField.text phoneNumber:self.usernameField.text zone:@"86" result:^(NSError *error) {
        if (!error) { // 验证成功,可以开始注册
            JXLog(@"验证成功");
            NSMutableDictionary *paras = [NSMutableDictionary dictionary];
            paras[@"telephone"] = self.usernameField.text;
            paras[@"password"] = self.passwordField.text;
            paras[@"hometown"] = [@(self.hometownCity.ID) description];
            [JXHttpTool post:[NSString stringWithFormat:@"%@/RegisteredUser", JXServerName] params:paras success:^(id json) {
                [MBProgressHUD hideHUD];
                
                BOOL success = [json[@"success"] boolValue];
                if (success) { // 注册成功
                    JXLog(@"注册成功");
                    [MBProgressHUD showSuccess:@"注册成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else { // 注册失败
                    [MBProgressHUD showError:json[@"msg"]];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUD];
                JXLog(@"注册请求失败 - %@", error);
            }];
        }
        else { // 验证失败,不需要请求注册
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@", error.userInfo[@"commitVerificationCode"]]];
            JXLog(@"验证失败-错误信息:%@",error);
        }
    }];
}

#pragma mark - JXChooseCityViewControllerDelegate
- (void)chooseCityViewControllerDidFinishedWithCity:(JXCity *)city {
    self.hometownCity = city;
}
@end
