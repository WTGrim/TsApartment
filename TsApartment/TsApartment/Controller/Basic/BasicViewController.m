//
//  BasicViewController.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BasicViewController.h"
#import "CommonTools.h"
#import "LoginViewController.h"
#import "UserStatus.h"

@interface BasicViewController ()

/** 上次登陆状态 */
@property (assign, nonatomic) BOOL lastLoginStatus;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initBasic];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarWhite];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_lastLoginStatus != [UserStatus shareInstance].isLogin) {
        [self loginStatusChanged];
    }
}

- (void)initBasic{
    
    if (!_backItemHidden) {
        [self initBackItem];
    }
    self.view.backgroundColor = ThemeColor_Background;
}

- (void)loginStatusChanged {
    _lastLoginStatus = [UserStatus shareInstance].isLogin;
}


#pragma mark - 初始化返回按钮
- (void)initBackItem{
    
        //        let leftItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        //        leftItem.width = -15
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        leftItem.width = -20;
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        backButton.contentMode = UIViewContentModeLeft;
        [backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setNavigationBarWhite {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
}

- (void)setNavigationBarShadowHidden{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor clearColor]]];
}

- (void)showLoginAlert{
    
    [CommonTools alertWithTitle:nil message:@"你还没有登录，是否登录" style:UIAlertControllerStyleAlert leftBtnTitle:@"" rightBtnTitle:@"" rootVc:self leftClick:^{
        
    } rightClick:^{
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        [self presentViewController:loginVc animated:true completion:nil];
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)navigationBackItemClicked{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
