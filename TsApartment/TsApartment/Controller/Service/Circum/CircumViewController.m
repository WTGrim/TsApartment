//
//  CircumViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumViewController.h"
#import "PageScrollView.h"
#import "CircumPageViewController.h"

@interface CircumViewController ()<ScrollPageViewDelegate>

@property(nonatomic, strong)NSMutableArray *titleArray;
@property(nonatomic, assign)NSInteger currentIndex;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation CircumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - initView
- (void)setupUI{
    
    self.title = @"周边商业";
    [self initPageScrollView];
}

- (void)initPageScrollView{
    
    
    NSArray *arr = @[@"生活服务", @"餐饮美食", @"休闲娱乐", @"教育培训"];
    [self.titleArray addObjectsFromArray:arr];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    PageTitleStyle *style = [[PageTitleStyle alloc]init];
    style.showSlider = true;
    style.changeTitleColor = true;
    style.sliderWidthFitTitle = true;
    style.sliderColor = ThemeColor_Yellow;
    style.selectedTitleColor = ThemeColor_BlackText;
    style.normalTitleColor = ThemeColor_GrayText;
    style.adjustCoverOrSliderWidth = true;
    style.titleFont = [UIFont systemFontOfSize:15];
    if (self.titleArray.count < 5) {
        style.scrollTitle = false;
    }
    
    PageScrollView *pageScroll = [[PageScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT) titleStyle:style titles:self.titleArray.copy parentViewController:self delegate:self];
    [self.view addSubview:pageScroll];
    [pageScroll setSelectedIndex:0 animated:YES];

}

#pragma mark - ScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers{
    return self.titleArray.count;
}

- (UIViewController<ScrollPageViewChildVcDelegate> *)childViewController:(CircumPageViewController<ScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index{
    
    CircumPageViewController<ScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[CircumPageViewController alloc]init];
    }
    _currentIndex = index;
    childVc.paramDict = self.dataArray[index];
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return false;
}

#pragma mark - lazy
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
