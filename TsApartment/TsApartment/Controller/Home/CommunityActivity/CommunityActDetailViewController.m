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

#define SECTION_HEADER 40

@interface CommunityActDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *joinListArray;
//页码
@property(nonatomic, assign)NSInteger pageIndex;
@property(nonatomic, strong)CommunityActHeader *header;
@property(nonatomic, strong)UIView *sectionHeader;
@property(nonatomic, strong)UILabel *sectionTitle;

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
    _pageIndex = 1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(- SAFE_NAV_HEIGHT, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityActDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CommunityActDetailCell class])];
    WEAKSELF;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [self getJoinInfoData];
    }];
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
    
    WEAKSELF;
    [self.header setHeaderWithDict:dict heightCallBack:^(CGFloat height) {
        weakSelf.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        [weakSelf.tableView reloadData];
    }];
    _sectionTitle.text = [NSString stringWithFormat:@"%ld人已成功报名", (long)[[dict objectForKey:kLimit] integerValue]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.sectionHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SECTION_HEADER;
}

#pragma mark - 分享
- (void)shareClick{
    
}

- (void)refreshData{
    [self.joinListArray removeAllObjects];
    _pageIndex = 1;
    [self getJoinInfoData];
}

#pragma mark - lazy
- (NSMutableArray *)joinListArray{
    if (!_joinListArray) {
        _joinListArray = [NSMutableArray array];
    }
    return _joinListArray;
}

- (CommunityActHeader *)header{
    if (!_header) {
        _header = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CommunityActHeader class]) owner:nil options:nil].firstObject;
        WEAKSELF;
        _header.applySucceedCallBack = ^{
            [weakSelf refreshData];
        };
        _tableView.tableHeaderView = _header;
    }
    return _header;
}

- (UIView *)sectionHeader{
    if (!_sectionHeader) {
        _sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SECTION_HEADER)];
        _sectionHeader.backgroundColor = ThemeColor_Background;
        _sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, CGRectGetHeight(_sectionHeader.frame))];
        _sectionTitle.textColor =  ThemeColor_BlackText;
        _sectionTitle.font = [UIFont systemFontOfSize:13];
        [_sectionHeader addSubview:_sectionTitle];
    }
    return _sectionHeader;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
