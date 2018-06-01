//
//  CentralizedViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CentralizedViewController.h"
#import "CentraListTableViewCell.h"

@interface CentralizedViewController ()<UITableViewDelegate, UITableViewDataSource>

//tableView
@property(nonatomic, strong)UITableView *tableView;
//数据源
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation CentralizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark - initView
- (void)setupUI{
    
    [self initNavBar];
    [self initTableView];
}

#pragma mark - initNavBar
- (void)initNavBar{
    

}

#pragma mark - tableView
- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 220;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CentraListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CentraListTableViewCell class])];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CentraListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CentraListTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
