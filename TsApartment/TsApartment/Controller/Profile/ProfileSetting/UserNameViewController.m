//
//  UserNameViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "UserNameViewController.h"
#import "NetworkTool.h"

@interface UserNameViewController ()

@property(nonatomic, strong)UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"修改用户名";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveBtn];
}

#pragma mark - 保存
- (void)saveClick{
    
    if (_name.text.length == 0) {
        [WTAlertView showMessage:@"请先填写您的用户名"];
        return;
    }
    [NetworkTool editUserInfoWithNickName:_name.text sex:0 imageArray:nil password:@"" SucceedBlock:^(NSDictionary * _Nullable result) {
        [self saveSucceed];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)saveSucceed{
    [self.navigationController popViewControllerAnimated:true];
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        _saveBtn.layer.cornerRadius = 15;
        _saveBtn.layer.masksToBounds = true;
        _saveBtn.backgroundColor = ThemeColor_Yellow;
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
