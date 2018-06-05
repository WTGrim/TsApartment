//
//  ProfileViewController.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "NetworkTool.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    [self getData];
}

#pragma mark - initView
- (void)setupUI{
    
    self.title = @"个人中心";
}

- (void)getData{
    
    [NetworkTool getUserInfoWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [self setData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - setData
- (void)setData:(NSDictionary *)dict{
    
}

#pragma mark - 登录注册
- (IBAction)loginClick:(UITapGestureRecognizer *)sender {
    LoginViewController *loginVc = [[LoginViewController alloc]init];
    loginVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:loginVc animated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
