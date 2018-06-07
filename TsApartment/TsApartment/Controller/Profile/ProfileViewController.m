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
#import "CommonBtn.h"
#import <UIButton+WebCache.h>
#import "MessageViewController.h"

@interface ProfileViewController ()

//我的住所
@property (weak, nonatomic) IBOutlet CommonBtn *contract;
@property (weak, nonatomic) IBOutlet CommonBtn *guard;
@property (weak, nonatomic) IBOutlet CommonBtn *visitorManage;
@property (weak, nonatomic) IBOutlet CommonBtn *pay;

//个人中心
@property (weak, nonatomic) IBOutlet CommonBtn *book;
@property (weak, nonatomic) IBOutlet CommonBtn *reservation;
@property (weak, nonatomic) IBOutlet CommonBtn *collect;
@property (weak, nonatomic) IBOutlet CommonBtn *activity;
@property (weak, nonatomic) IBOutlet CommonBtn *service;

//消息
@property(nonatomic, strong)MessageBtn *messageBtn;
//住所类数组
@property(nonatomic, strong)NSArray *flatClassArr;
//个人菜单住所
@property(nonatomic, strong)NSArray *menuArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    [self getUserInfoData];
    [self getUserFlat];
    [self getUserMenu];
}

#pragma mark - initView
- (void)setupUI{
    
    self.title = @"个人中心";
    _messageBtn = [[MessageBtn alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_messageBtn];
}

- (void)getUserInfoData{
    
    [NetworkTool getUserInfoWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [self setData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)getUserFlat{
    [NetworkTool getUserFlatWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [self presentFlatMenu:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - 我的住所跳转
- (void)presentFlatMenu:(NSArray *)array{
    _flatClassArr = [NSArray arrayWithArray:array];
    
    NSArray <CommonBtn *> *btnArray = @[_contract, _guard, _visitorManage, _pay];
    NSArray *imgsNames = @[];
    [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!StringIsNull([obj objectForKey:kName])) {
            [btnArray[idx] setTitle:[obj objectForKey:kName] forState:UIControlStateNormal];
        }else{
            
        }
        if (!StringIsNull([obj objectForKey:[CommonTools getFitImgName]])) {
            [btnArray[idx] sd_setImageWithURL:[NSURL URLWithString:[obj objectForKey:[CommonTools getFitImgName]]] forState:UIControlStateNormal];
        }else{//本地图片
            [btnArray[idx] setImage:imgsNames[idx] forState:UIControlStateNormal];
        }
    }];
}

- (void)getUserMenu{
    
    [NetworkTool getUserMenuWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [self presentMenu:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - 设置按钮和跳转
- (void)presentMenu:(NSArray *)array{
    _menuArray = [NSArray arrayWithArray:array];
    NSArray <CommonBtn *> *btnArray = @[_book, _reservation, _collect, _activity, _service];
    NSArray *imgsNames = @[];
    [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!StringIsNull([obj objectForKey:kName])) {
            [btnArray[idx] setTitle:[obj objectForKey:kName] forState:UIControlStateNormal];
        }else{
            
        }
        if (!StringIsNull([obj objectForKey:[CommonTools getFitImgName]])) {
            [btnArray[idx] sd_setImageWithURL:[NSURL URLWithString:[obj objectForKey:[CommonTools getFitImgName]]] forState:UIControlStateNormal];
        }else{//本地图片
            [btnArray[idx] setImage:imgsNames[idx] forState:UIControlStateNormal];
        }
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

#pragma mark - 我的住所
- (IBAction)myFlat:(CommonBtn *)sender {
    
    if (![self checkLogin]){
        [self loginClick:nil];
        return;
    };
    
    NSInteger idx = sender.tag - 100;
    if (!StringIsNull([_flatClassArr[idx] objectForKey:kIos])) {
        NSString *className = [_flatClassArr[idx] objectForKey:kIos];
        Class c = NSClassFromString(className);
        id classVc = [[c alloc]init];
        [self.navigationController pushViewController:classVc animated:true];
    }
}

#pragma mark - service
- (IBAction)myService:(CommonBtn *)sender {
    
    if ([self checkLogin]) {
        [self loginClick:nil];
        return;
    }
    
    NSInteger idx = sender.tag - 200;
    if (!StringIsNull([_menuArray[idx] objectForKey:kIos])) {
        NSString *className = [_flatClassArr[idx] objectForKey:kIos];
        Class c = NSClassFromString(className);
        id classVc = [[c alloc]init];
        [self.navigationController pushViewController:classVc animated:true];
    }
}

#pragma mark - 消息
- (void)messageClick{
    MessageViewController *messageVc = [[MessageViewController alloc]init];
    messageVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:messageVc animated:true];
}

#pragma mark - 判断登录
- (BOOL)checkLogin{
    if ([UserStatus shareInstance].isLogin) {
        return true;
    }
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
