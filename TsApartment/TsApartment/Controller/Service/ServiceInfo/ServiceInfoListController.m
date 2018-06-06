//
//  ServiceInfoListController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/1.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoListController.h"
#import "ServiceInfoListCell.h"
#import "NetworkTool.h"
#import "ServiceInfoDetailController.h"

@interface ServiceInfoListController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, assign)NSInteger pageIndex;

@end

@implementation ServiceInfoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonConfig];
    [self setupUI];
    [self getData];
}

- (void)commonConfig{
    _pageIndex = 1;
}

- (void)getData{
    
    WEAKSELF;
    [NetworkTool getServiceInfoListWithPageIndex:_pageIndex succeedBlock:^(NSDictionary * _Nullable result) {
        [self presentData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)presentData:(NSArray *)array{
    [_tableView.mj_footer endRefreshing];
    if (array.count < COMMON_PAGE_SIZE) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.dataArray addObjectsFromArray:array];
    [_tableView reloadData];
    if (array.count == 0 && _pageIndex == 1) {
        _tableView.mj_footer.hidden = true;
    }
}

- (void)setupUI{
    
    self.title = @"服务资讯";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
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
    WEAKSELF;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [self getData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _tableView.mj_footer.hidden = self.dataArray.count == 0;
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ServiceInfoListCell class]) forIndexPath:indexPath];
    if (self.dataArray.count != 0) {
        [cell setCellWithDict:self.dataArray[indexPath.row] indexPath:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ServiceInfoDetailController *detailVc = [[ServiceInfoDetailController alloc]init];
    detailVc.hidesBottomBarWhenPushed = true;
    detailVc.Id = [[self.dataArray[indexPath.row] objectForKey:kId] integerValue];
    [self.navigationController pushViewController:detailVc animated:true];
}

- (void)shareClick{
    
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
