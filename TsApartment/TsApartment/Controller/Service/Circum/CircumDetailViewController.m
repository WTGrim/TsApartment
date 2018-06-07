//
//  CircumDetailViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumDetailViewController.h"
#import "CommentBottomView.h"
#import "CircumDetailHeader.h"
#import "CircumDetailCommentCell.h"
#define BOTTOM_H 50

@interface CircumDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
//评论框
@property(nonatomic, strong)CommentBottomView *bottomView;
//header
@property(nonatomic, strong)CircumDetailHeader *header;
//页码
@property(nonatomic, assign)NSInteger pageIndex;

@end

@implementation CircumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self getData];
}

#pragma mark - initView
- (void)setupUI{
    
    self.title = @"资讯详情";
    _pageIndex = 1;
    [self initTableView];
    [self initBottomView];
}

- (void)getData{
    
    [self getCircumDetailData];
    [self getCircumCommentData];
}

#pragma mark - 获取周边详情数据
- (void)getCircumDetailData{
    
}

#pragma mark - 获取周边评论数据
- (void)getCircumCommentData{
    
}

- (void)presentCircumDatailData:(NSDictionary *)dict{
    WEAKSELF;
    [self.header setHeaderWithDict:dict heightCallBack:^(CGFloat height) {
        weakSelf.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        [weakSelf.tableView reloadData];
    }];
}

- (void)initBottomView{
    _bottomView = [[CommentBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - BOTTOM_H - SAFE_NAV_HEIGHT, SCREEN_WIDTH, BOTTOM_H)];
    WEAKSELF;
    _bottomView.publicCallBack = ^(NSString *comment) {
        
    };
    [self.view addSubview:_bottomView];
}


- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT -BOTTOM_H) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CircumDetailCommentCell class] forCellReuseIdentifier:NSStringFromClass([CircumDetailCommentCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircumDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircumDetailCommentCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - lazy
- (CircumDetailHeader *)header{
    if (!_header) {
        _header = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CircumDetailHeader class]) owner:nil options:nil].firstObject;
        _tableView.tableHeaderView = _header;
    }
    return _header;
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
