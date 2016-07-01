//
//  JHDynamicViewController.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/15.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHDynamicViewController.h"
#import "JHChatViewController.h"
#import "JHContactsViewController.h"

@interface JHDynamicViewController ()
// 账号
@property(nonatomic,strong)UITextField *accountTextField;
// 密码
@property(nonatomic,strong)UITextField *passwordTextField;
// 登陆按钮
@property(nonatomic,strong)UIButton *loginButton;
@end

@implementation JHDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
}

/**
 *  初始化界面
 */
-(void)setupView{
    UILabel *weChatTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCWidth, 30)];
    weChatTitleLabel.text = @"使用账号和密码登陆";
    weChatTitleLabel.textAlignment = NSTextAlignmentCenter;
    weChatTitleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:weChatTitleLabel];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 70, 30)];
    accountLabel.text = @"账号";
    accountLabel.textColor = [UIColor blackColor];
    [self.view addSubview:accountLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 70, 30)];
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [UIColor blackColor];
    [self.view addSubview:passwordLabel];
    
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
}



#pragma mark - 自定义控件方法
-(void)userLoginAction{
    // 退出键盘
    [self.passwordTextField resignFirstResponder];
    // 缓存当前用户输入的账户名和密码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.accountTextField.text forKey:@"userAccount"];
    [userDefaults setObject:self.passwordTextField.text forKey:@"userPassword"];
    [userDefaults synchronize];
    
    // 登陆回调
    [[JHXMPPManager sharedInstance] loginWithUserName:self.accountTextField.text password:self.passwordTextField.text successHandle:^{
        // 登陆
        DLog(@"登陆成功");
        
        JHContactsViewController *contactsVC = [[JHContactsViewController alloc] init];
        [self.navigationController pushViewController:contactsVC animated:YES];
        
        
    } errorHandle:^(NSError *error) {
        DLog(@"登陆失败");
    }];
}



#pragma mark - 懒加载
-(UITextField *)accountTextField{
    if (_accountTextField == nil) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, SCWidth - 90, 30)];
        _accountTextField.placeholder = @"请输入账号";
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userAccount = [userDefaults objectForKey:@"userAccount"];
        if (![NSString isBlankString:userAccount]) {
            _accountTextField.text = userAccount;
        }
    }
    return _accountTextField;
}

-(UITextField *)passwordTextField{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 280, SCWidth - 90, 30)];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.placeholder = @"请输入密码";
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userPassword = [userDefaults objectForKey:@"userPassword"];
        if (![NSString isBlankString:userPassword]) {
            _passwordTextField.text = userPassword;
        }
    }
    return _passwordTextField;
}

/**
 *  登陆按钮懒加载
 *
 *  @return 登陆按钮
 */
-(UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 360, SCWidth - 200, 50)];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"Bg_hl"] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(userLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}




@end
