//
//  CommunityActHeader.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommunityActHeader.h"
#import <WebKit/WebKit.h>
#import "HomeSectionHeader.h"
#import "WTCycleScrollView.h"
#import "NetworkTool.h"

#define CYCLE_H SCREEN_WIDTH * (650 / 750.0)
#define COMMON_H CYCLE_H + 458

@interface CommunityActHeader ()<CycleScrollViewDelegate, WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIView *cycleBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycleViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *webBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webBgHeight;

@property (weak, nonatomic) IBOutlet UIView *applyView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *joinNum;

@property(nonatomic, strong)WTCycleScrollView *cycleScrollView;
@property(nonatomic, strong)WKWebView *webView;
@property(nonatomic, copy)void(^heightCallBack)(CGFloat height);
@property(nonatomic, strong)NSDictionary *dict;
@end

@implementation CommunityActHeader

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

- (void)setHeaderWithDict:(NSDictionary *)dict heightCallBack:(void (^)(CGFloat))heightCallBack{
    
    _dict = [NSDictionary dictionaryWithDictionary:dict];
    _heightCallBack = heightCallBack;
    self.cycleScrollView.imageUrlsArray = [dict objectForKey:kImgUrl];
    _time.text = [CommonTools getStringWithDict:dict key:kActivity_time];
    _address.text = [CommonTools getStringWithDict:dict key:kAddress];
    NSString *partake = [NSString stringWithFormat:@"%ld", [[dict objectForKey:kPartake]integerValue]];
    NSString *note = [NSString stringWithFormat:@"已有%@人报名，限%ld人", partake, [[dict objectForKey:kLimit]integerValue]];
    _tips.attributedText = [CommonTools getAttrWithString:note attr:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:ThemeColor_Yellow} range:NSMakeRange(2, [partake length])];
    
    [_webView loadHTMLString:[dict objectForKey:kContent] baseURL:nil];

}

- (void)setupUI{
    
    _cycleViewHeight.constant = CYCLE_H;
    [_cycleBgView addSubview:self.cycleScrollView];
    _applyView.layer.cornerRadius = 5;
    _applyView.layer.masksToBounds = true;
    _applyView.layer.shadowOpacity = 0.4;
    _applyView.layer.shadowOffset = CGSizeMake(1, 1);
    _applyView.layer.shadowColor = RGBA(0, 0, 0, 0.4).CGColor;
    
    HomeSectionHeader *header = [[HomeSectionHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_headerView.frame))];
    header.title = @"活动说明";
    header.hiddenCheckMore = true;
    [_headerView addSubview:header];
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_webBgView.frame), CGRectGetHeight(_webBgView.frame))];
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = false;
    [_webBgView addSubview:_webView];
}

//报名
- (IBAction)applyClick:(UIButton *)sender {
    
    WEAKSELF;
    [NetworkTool serviceApplyWithId:[[_dict objectForKey:kId] integerValue] Name:_name.text mobile:_mobile.text num:[_joinNum.text integerValue] SucceedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf applySucceed];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
    
}

- (void)applySucceed{
    [WTAlertView showMessage:@"报名成功"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    WEAKSELF;
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        CGFloat webHeight = heightStr.floatValue;
        weakSelf.webBgHeight.constant = webHeight;
        weakSelf.webView.frame = CGRectMake(0, 0, CGRectGetWidth(weakSelf.webBgView.frame), webHeight);
        if (weakSelf.heightCallBack) {
            weakSelf.heightCallBack(COMMON_H + webHeight);
        }
    }];
}
#pragma mark - lazy
- (WTCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [WTCycleScrollView netCycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CYCLE_H) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.autoScroll = true;
        _cycleScrollView.loop = true;
        _cycleScrollView.showPageControl = true;
        _cycleScrollView.timeInterVal = 3;
        _cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlAliment = PageControlAlimentCenter;
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    }
    return _cycleScrollView;
}


@end
