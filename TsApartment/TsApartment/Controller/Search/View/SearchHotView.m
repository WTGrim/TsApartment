//
//  SearchHotView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/1.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SearchHotView.h"
#import "SearchItemView.h"
#import "SearchHotTableViewCell.h"
#import "SearchTableViewCell.h"

#define HEADER_H 40
#define MARGIN 25

@interface SearchHotView()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;

//historyData
@property(nonatomic, strong)NSMutableArray *historyArray;
//hotData
@property(nonatomic, strong)NSMutableArray *hotArray;
//header
@property(nonatomic, strong)UIView *searchHeader;
//footer
@property(nonatomic, strong)SearchItemView *searchFooter;
//底部高度
@property(nonatomic, assign)CGFloat footerH;
//sectionHeader
@property(nonatomic, strong)UIView *sectionHeader;

@end

@implementation SearchHotView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self initTableView];
    [self getHistoryData];
    [self getHotData];
}

#pragma mark - 获取历史数据
- (void)getHistoryData{
    
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:kLocalSearchHistory] isKindOfClass:[NSNull class]] && [[[NSUserDefaults standardUserDefaults]objectForKey:kLocalSearchHistory] count] != 0) {
        
        NSArray *localArray = [[NSUserDefaults standardUserDefaults]objectForKey:kLocalSearchHistory];
        self.historyArray = localArray.mutableCopy;
    }
    if (self.historyArray.count == 0) {
        _tableView.tableHeaderView = nil;
    }
}

#pragma mark - 获取热门数据
- (void)getHotData{
    
    NSArray *arr = @[@"光华中心", @"基金牛去", @"搜我都是的的", @"sdhkadhfsa"];
    [self.hotArray addObjectsFromArray:arr];
    [self.searchFooter addItems:self.hotArray.copy];
    [_tableView reloadData];
}

#pragma mark - 缓存搜索历史
- (void)saveLocalSearch:(NSString *)keyword{
    
    if (keyword.length != 0) {
        
        if (![[[NSUserDefaults standardUserDefaults]objectForKey:kLocalSearchHistory] isKindOfClass:[NSNull class]] && [[[NSUserDefaults standardUserDefaults]objectForKey:kLocalSearchHistory] count] != 0) {
            
            NSArray *localArray = [[NSUserDefaults standardUserDefaults]objectForKey:kLocalSearchHistory];
            if ([keyword isEqualToString:[localArray objectAtIndex:0]]) {
                
                self.historyArray = localArray.mutableCopy;
                
            }else{
                
                NSMutableArray *multable = localArray.mutableCopy;
                __block NSUInteger index = 0;
                [multable enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isEqualToString:keyword]) {
                        index = idx;
                    }
                }];
                
                if (index != 0) {
                    
                    [multable removeObjectAtIndex:index];
                    [multable insertObject:[localArray objectAtIndex:index] atIndex:0];
                    self.historyArray  = multable.mutableCopy;
                    
                }else{//没有已存在的
                    
                    [self.historyArray insertObject:keyword atIndex:0];
                }
            }
            
        }else{
            
            [self.historyArray insertObject:keyword atIndex:0];
        }
        //个数判断
        if (self.historyArray.count > 10) {
            [self.historyArray removeLastObject];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:self.historyArray forKey:kLocalSearchHistory];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

#pragma mark - 清楚历史搜索
- (void)clearSearchHistory{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLocalSearchHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //刷新数据
    [self.historyArray removeAllObjects];
    _tableView.tableHeaderView = nil;
    [_tableView reloadData];
}


#pragma mark - initTableView
- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = self.searchHeader;
    _tableView.rowHeight = 100;
    [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SearchTableViewCell class])];
    [_tableView registerClass:[SearchHotTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SearchHotTableViewCell class])];
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.historyArray.count;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return self.searchFooter.itemHeight;
            break;
        default:
            return CGFLOAT_MIN;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchTableViewCell class]) forIndexPath:indexPath];
        cell.name = self.historyArray[indexPath.row];
        return cell;
    }else if(indexPath.section == 1){
        SearchHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchHotTableViewCell class]) forIndexPath:indexPath];
        cell.searchHotView = self.searchFooter;
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    return nil;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0)return 10;
//    return CGFLOAT_MIN;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section == 1)return HEADER_H;
//    return CGFLOAT_MIN;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) return nil;
//    return self.sectionHeader;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_itemClick) {
            _itemClick(self.historyArray[indexPath.row]);
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - lazy
- (NSMutableArray *)historyArray{
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

- (NSMutableArray *)hotArray{
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (UIView *)searchHeader{
    if (!_searchHeader) {
        _searchHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADER_H)];
        _searchHeader.backgroundColor = [UIColor whiteColor];
        
        UILabel *historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 100, CGRectGetHeight(_searchHeader.frame))];
        historyLabel.font = [UIFont systemFontOfSize:14];
        historyLabel.textColor = ThemeColor_BlackText;
        historyLabel.text = @"搜索历史";
        [_searchHeader addSubview:historyLabel];
        
        UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120 - 20, 0, 120, CGRectGetHeight(_searchHeader.frame))];
        [clearBtn setTitleColor:ThemeColor_BlackText forState:UIControlStateNormal];
        [clearBtn setTitle:@"清除历史记录" forState:UIControlStateNormal];
        clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [clearBtn addTarget:self action:@selector(clearSearchHistory) forControlEvents:UIControlEventTouchUpInside];
        [_searchHeader addSubview:clearBtn];
    }
    return _searchHeader;
}

- (SearchItemView *)searchFooter{
    if (!_searchFooter) {
        _searchFooter = [[SearchItemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - MARGIN, 0)];
        _searchFooter.backgroundColor = [UIColor whiteColor];
        _searchFooter.itemFont = [UIFont systemFontOfSize:13];
        _searchFooter.textColor = ThemeColor_BlackText;
        _searchFooter.itemMargin = 8;
        _searchFooter.itemBackgroundColor = ThemeColor_lightBg;
        _searchFooter.itemButtonMargin = MARGIN;
        WEAKSELF;
        _searchFooter.itemClick = ^(NSString *item) {
            if (item.length == 0) return ;
            if (weakSelf.itemClick) {
                weakSelf.itemClick(item);
            }
        };
    }
    return _searchFooter;
}

- (UIView *)sectionHeader{
    if (!_sectionHeader) {
        _sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADER_H)];
        _searchHeader.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN, 0, CGRectGetWidth(_sectionHeader.frame), CGRectGetHeight(_sectionHeader.frame))];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = ThemeColor_BlackText;
        title.text = @"热门搜索";
        [_sectionHeader addSubview:title];
    }
    return _sectionHeader;
}


@end
