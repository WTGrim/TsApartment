//
//  EnsurePsdViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "EnsurePsdViewController.h"
#import "NetworkTool.h"

@interface EnsurePsdViewController ()
//密码
@property (weak, nonatomic) IBOutlet UITextField *psd;
//重复密码
@property (weak, nonatomic) IBOutlet UITextField *repeatPsd;

@property (weak, nonatomic) IBOutlet UIButton *visibleBtn;
@end

@implementation EnsurePsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)setupUI{
    
}

#pragma mark - 注册
- (IBAction)signupClick:(UIButton *)sender {
    
    NSArray *arr = @[_psd, _repeatPsd];
    __block NSString *message = nil;
    __block BOOL canGo = true;
    [arr enumerateObjectsUsingBlock:^(UITextField *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.text containsString:@" "]) {
            canGo = false;
            message = @"密码不能包含空格";
        }
        if (obj.text.length < 6 || obj.text.length > 16) {
            canGo = false;
            message = @"密码长度不符";
        }
        
    }];
    if (!canGo) {
        [WTAlertView showMessage:message];
        return;
    }
    
    if (_psd.text != _repeatPsd.text) {
        [WTAlertView showMessage:@"两次输入密码不一致"];
        return;
    }
    
    WEAKSELF;
    [NetworkTool signupWithMobile:_mobile psd:_psd.text succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf signSuccess:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - 注册成功
- (void)signSuccess:(NSDictionary *)dict{
    
    NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
    user = [[dict objectForKey:kUser] mutableCopy];
    [user setObject:[[dict objectForKey:@"session"] objectForKey:kSid] forKey:kSid];
    [[UserStatus shareInstance]initWithDict:[dict objectForKey:kUser]];

    //缓存用户信息到本地
    [self saveUserInfoWith:user];
    [self.navigationController popToRootViewControllerAnimated:true];

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

#pragma mark - 可见
- (IBAction)visibleClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _psd.secureTextEntry = sender.isSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
