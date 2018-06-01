//
//  ServiceInfoListController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/1.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoListController.h"
#import "ServiceInfoListCell.h"

@interface ServiceInfoListController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ServiceInfoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"服务资讯";
    [self initTableView];
}

#pragma mark - tableView
- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 160;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ServiceInfoListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ServiceInfoListCell class])];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ServiceInfoListCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
