//
//  DistributedViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "DistributedViewController.h"
#import "DistrListTableViewCell.h"
#import "LeftViewTextField.h"
#import "SearchViewController.h"
#import "MapViewController.h"

@interface DistributedViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

//tableView
@property(nonatomic, strong)UITableView *tableView;
//数据源
@property(nonatomic, strong)NSMutableArray *dataArray;
//search
@property(nonatomic, strong)LeftViewTextField *searchTextField;

@end

@implementation DistributedViewController

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

    _searchTextField = [[LeftViewTextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
    _searchTextField.placeholder = @"输入您想住的区域";
    _searchTextField.font = [UIFont systemFontOfSize:13];
    _searchTextField.textColor = ThemeColor_BlackText;
    _searchTextField.delegate = self;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.backgroundColor = ThemeColor_lightBg;
    _searchTextField.layer.cornerRadius = 15;
    _searchTextField.layer.masksToBounds = true;
    UIImageView *left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_searchIcon"]];
    _searchTextField.leftView = left;
    self.navigationItem.titleView = _searchTextField;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"DistrList_map"] style:UIBarButtonItemStylePlain target:self action:@selector(mapClick)];
}

#pragma mark - tableView
- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 150;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DistrListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DistrListTableViewCell class])];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DistrListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DistrListTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - 点击地图
- (void)mapClick{
    
    MapViewController *mapVc = [[MapViewController alloc]init];
    mapVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:mapVc animated:true];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    SearchViewController *searchVc = [[SearchViewController alloc]init];
    searchVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVc animated:true];
    return false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
