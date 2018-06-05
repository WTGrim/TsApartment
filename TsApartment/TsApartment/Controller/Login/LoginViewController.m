//
//  LoginViewController.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "NetworkTool.h"

@interface LoginViewController ()
//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phone;
//密码
@property (weak, nonatomic) IBOutlet UITextField *psd;
//登录
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

#pragma mark - initView
- (void)setupUI{
    
    [self setNavigationBarShadowHidden];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(signupClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = ThemeColor_Yellow;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"login_delete"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    _topMargin.constant = SCREEN_HEIGHT * 0.1;
    
}

#pragma mark - 登录
- (IBAction)loginClick:(UIButton *)sender {
    
    if (![CommonTools isTelNumber:_phone.text]) {
        [WTAlertView showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_psd.text.length == 0) {
        [WTAlertView showMessage:@"请输入密码"];
        return;
    }
    
    if (_psd.text.length < 6 || _psd.text.length > 16) {
        [WTAlertView showMessage:@"请输入6-16位长度的密码"];
        return;
    }
    WEAKSELF;
    [NetworkTool loginWithMobile:_phone.text psd:_psd.text succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf loginSucceed:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

//登录成功
- (void)loginSucceed:(NSDictionary *)dict{
    NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
    user = [[dict objectForKey:kUser] mutableCopy];
    [user setObject:[[dict objectForKey:@"session"] objectForKey:kSid] forKey:kSid];
    [[UserStatus shareInstance]initWithDict:[dict objectForKey:kUser]];
    
    //缓存用户信息到本地
    [self saveUserInfoWith:user];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)saveUserInfoWith:(NSDictionary *)result {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    for (NSString *key in result.allKeys) {
        if ([result objectForKey:key] != nil && ![[result objectForKey:key] isKindOfClass:[NSNull class]]) {
            [userInfo setObject:[result objectForKey:key] forKey:key];
        }
    }
    [CommonTools saveLocalWithKey:kSaveUserInfo Obj:userInfo];
}


#pragma mark - 忘记密码
- (IBAction)forgetPsdClick:(UIButton *)sender {
    
    SignUpViewController *signupVc = [[SignUpViewController alloc]init];
    signupVc.type = SignupType_FindPsd;
    [self.navigationController pushViewController:signupVc animated:true];
}

#pragma mark - 三方登录
- (IBAction)thirdLogin:(UIButton *)sender {
    
    
}

#pragma mark - 注册
- (void)signupClick:(UIButton *)sender {
    
    SignUpViewController *signupVc = [[SignUpViewController alloc]init];
    signupVc.type = SignupType_Signup;
    [self.navigationController pushViewController:signupVc animated:true];
}



- (void)backClick{
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
