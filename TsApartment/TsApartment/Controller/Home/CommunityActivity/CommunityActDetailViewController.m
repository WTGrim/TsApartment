//
//  CommunityActDetailViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommunityActDetailViewController.h"
#import "CommunityActHeader.h"
#import "CommunityActDetailCell.h"
#import "NetworkTool.h"

@interface CommunityActDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *joinListArray;
//页码
@property(nonatomic, assign)NSInteger pageIndex;
@end

@implementation CommunityActDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = true;
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = false;
}

- (void)setupUI{
    
    self.title =  @"活动详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - SAFE_BOTTOM_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(- SAFE_NAV_HEIGHT, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityActDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CommunityActDetailCell class])];
    [self.view addSubview:_tableView];
}

- (void)getData{
    [self getDetailData];
    [self getJoinInfoData];
}

#pragma mark - 活动详情数据
- (void)getDetailData{
    [NetworkTool getCommunityActivityDetailWithId:_Id SucceedBlock:^(NSDictionary * _Nullable result) {
        [self presentDetail:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)presentDetail:(NSDictionary *)dict{
    
}

#pragma mark - 活动报名列表
- (void)getJoinInfoData{
    WEAKSELF;
    [NetworkTool getCommunityActivityJoin_listDetailWithId:_Id pageIndex:_pageIndex count:COMMON_PAGE_SIZE SucceedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf presentJoin_list:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)presentJoin_list:(NSArray *)array{
    [_tableView.mj_footer endRefreshing];
    
    if (array.count < COMMON_PAGE_SIZE) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.joinListArray addObjectsFromArray:array];
    [_tableView reloadData];
    if (array.count == 0 && _pageIndex == 1) {
        _tableView.mj_footer.hidden = true;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.joinListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityActDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommunityActDetailCell class]) forIndexPath:indexPath];
    if (self.joinListArray.count != 0) {
        [cell setCellWithDict:self.joinListArray[indexPath.row] indexPath:indexPath];
    }
    return cell;
}

#pragma mark - 分享
- (void)shareClick{
    
}

#pragma mark - lazy
- (NSMutableArray *)joinListArray{
    if (!_joinListArray) {
        _joinListArray = [NSMutableArray array];
    }
    return _joinListArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
