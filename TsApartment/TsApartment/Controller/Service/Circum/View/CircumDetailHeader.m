//
//  CircumDetailHeader.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumDetailHeader.h"
#import "CommonBtn.h"
#import <WebKit/WebKit.h>

#define CYCLE_H SCREEN_WIDTH * (650 / 750.0)

@interface CircumDetailHeader()<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIView *cycleBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycleHeigth;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *work;
@property (weak, nonatomic) IBOutlet UILabel *goodDegree;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *starNum;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *distance;
//价格sectionHeader
@property (weak, nonatomic) IBOutlet UIView *priceSectionHeader;
@property (weak, nonatomic) IBOutlet UIView *priceBgWeb;
//价格背景高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceWebHeight;
//更多sectionHeader
@property (weak, nonatomic) IBOutlet UIView *moreSectionHeader;
@property (weak, nonatomic) IBOutlet UIView *moreBgWeb;
//web背景高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreWebHeight;
//评论的评星
@property (weak, nonatomic) IBOutlet UIView *commentStarView;
//评论分数
@property (weak, nonatomic) IBOutlet UILabel *commentStarNum;
//评论数
@property (weak, nonatomic) IBOutlet ListHeaderBtn *commentNum;
//价格描述的web
@property(nonatomic, strong)WKWebView *priceWebView;
//更多的web
@property(nonatomic, strong)WKWebView *moreWebView;
//高度回调
@property(nonatomic, copy)void(^heightCallBack)(CGFloat height);
//保存数据
@property(nonatomic, strong)NSDictionary *dict;
//priceWeb的高度
@property(nonatomic, assign)CGFloat finalPriceheight;
//moreWeb的高度
@property(nonatomic, assign)CGFloat finalMoreheight;

@end
@implementation CircumDetailHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _finalPriceheight = 0;
    _finalMoreheight = 0;
    _priceWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_priceBgWeb.frame), CGRectGetHeight(_priceBgWeb.frame))];
    _priceWebView.navigationDelegate = self;
    _priceWebView.userInteractionEnabled = false;
    [_priceBgWeb addSubview:_priceWebView];
    
    _moreWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_moreBgWeb.frame), CGRectGetHeight(_moreBgWeb.frame))];
    _moreWebView.navigationDelegate = self;
    _moreWebView.userInteractionEnabled = false;
    [_moreBgWeb addSubview:_moreWebView];
}
- (void)setHeaderWithDict:(NSDictionary *)dict heightCallBack:(void (^)(CGFloat))heightCallBack{
    _dict = dict;
    _heightCallBack = heightCallBack;
    

}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    WEAKSELF;
    if (webView == _priceWebView) {
        [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
            NSString *heightStr = [NSString stringWithFormat:@"%@",any];
            CGFloat webHeight = heightStr.floatValue;
            weakSelf.priceWebHeight.constant = webHeight;
            weakSelf.finalPriceheight = webHeight;
            weakSelf.priceWebView.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.priceBgWeb.frame), webHeight);
            [weakSelf dealCallBack];
        }];
    }else if(webView == _moreWebView){
        [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
            NSString *heightStr = [NSString stringWithFormat:@"%@",any];
            CGFloat webHeight = heightStr.floatValue;
            weakSelf.moreWebHeight.constant = webHeight;
            weakSelf.finalMoreheight = webHeight;
            weakSelf.moreWebView.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.moreBgWeb.frame), webHeight);
            [weakSelf dealCallBack];
        }];
    }
}

- (void)dealCallBack{
    if (_finalMoreheight != 0 && _finalPriceheight != 0) {
        if (_heightCallBack) {
            _heightCallBack(CYCLE_H + _finalPriceheight + _finalMoreheight + 371);
        }
    }
}

#pragma mark - 打电话
- (IBAction)callClick:(UIButton *)sender {
    
}

#pragma mark - 点击全部评论
- (IBAction)commentClick:(ListHeaderBtn *)sender {
    
}

#pragma mark - 点击位置
- (IBAction)locationClick:(UITapGestureRecognizer *)sender {
    
}

@end
