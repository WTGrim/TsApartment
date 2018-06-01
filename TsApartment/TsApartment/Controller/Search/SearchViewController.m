//
//  SearchViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SearchViewController.h"
#import "LeftViewTextField.h"
#import "SearchItemView.h"
#import "SearchHotView.h"
#import "DistrListTableViewCell.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

//tableView
@property(nonatomic, strong)UITableView *tableView;
//dataSource
@property(nonatomic, strong)NSMutableArray *dataArray;
//search
@property(nonatomic, strong)LeftViewTextField *searchTextField;
//searchHotView
@property(nonatomic, strong)SearchHotView *searchHotView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self getData];
}

- (void)setupUI{
    
    [self initNavBar];
    [self initTableView];
}

#pragma mark - 获取数据
- (void)getData{
    
    
}

#pragma mark - 开始搜索
- (void)searchClick:(NSString *)keywords{
    //先做缓存
    [self.searchHotView saveLocalSearch:keywords];
    //搜索网络请求
    
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
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_searchIcon"]];
    _searchTextField.leftView = left;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_searchTextField];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    
}

#pragma mark - initTableView
- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 150;
    _tableView.hidden = true;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DistrListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DistrListTableViewCell class])];
    [self.view addSubview:_tableView];
    
    [self.view addSubview:self.searchHotView];
}

- (void)showTableView{
    _tableView.hidden = false;
    self.searchHotView.hidden = true;
    [self.view bringSubviewToFront:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DistrListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DistrListTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField.text.length == 0) return false;
    [self searchClick:textField.text];
    [self.searchHotView saveLocalSearch:textField.text];
    self.searchHotView.hidden = true;
    return true;
}

#pragma mark - lazy
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (SearchHotView *)searchHotView{
    if (!_searchHotView) {
        _searchHotView = [[SearchHotView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT)];
        WEAKSELF;
        _searchHotView.itemClick = ^(NSString *item) {
            [weakSelf searchClick:item];
        };
    }
    return _searchHotView;
}

#pragma mark - 取消
- (void)cancelClick{
    [self.navigationController popViewControllerAnimated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
