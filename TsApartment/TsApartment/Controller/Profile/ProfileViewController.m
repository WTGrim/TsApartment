//
//  ProfileViewController.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (![UserStatus shareInstance].isLogin) {
//        LoginViewController *loginVc = [[LoginViewController alloc]init];
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVc] animated:true completion:nil];
//    }
//}

#pragma mark - initView
- (void)setupUI{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
