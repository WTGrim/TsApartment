//
//  LocationChooseController.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "LocationChooseController.h"
#import "LocationChooseCell.h"

@interface LocationChooseController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong)UITableView *tableView;
//dataSource
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation LocationChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark - initView
- (void)setupUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [_tableView registerClass:[LocationChooseCell class] forCellReuseIdentifier:NSStringFromClass([LocationChooseCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LocationChooseCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:true completion:nil];
    if (_chooseCity) {
        _chooseCity(@"成都");
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


@end
