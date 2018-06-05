//
//  ServiceInfoDetailController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoDetailController.h"

@interface ServiceInfoDetailController ()

@end

@implementation ServiceInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}

#pragma mark - initView
- (void)setupUI{
    
    self.title = @"资讯详情";
    
}

#pragma mark - 获取数据
- (void)getData{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
