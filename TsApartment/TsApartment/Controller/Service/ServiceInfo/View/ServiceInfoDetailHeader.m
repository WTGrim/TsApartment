//
//  ServiceInfoDetailHeader.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoDetailHeader.h"
#import <WebKit/WebKit.h>
#define COMMON_H 140

@interface ServiceInfoDetailHeader()<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIView *webBgView;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webBgHeight;

@property(nonatomic, strong)WKWebView *webView;
//高度回调
@property(nonatomic, copy)void(^heightCallBack)(CGFloat height);
//保存数据
@property(nonatomic, strong)NSDictionary *dict;

@end

@implementation ServiceInfoDetailHeader


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
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_webBgView.frame), CGRectGetHeight(_webBgView.frame))];
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = false;
    [_webBgView addSubview:_webView];
}
#pragma mark - 设置数据
- (void)setHeaderWithDict:(NSDictionary *)dict heightCallBack:(void (^)(CGFloat))heightCallBack{
    _dict = dict;
    _heightCallBack = heightCallBack;
    _title.text = [CommonTools getStringWithDict:dict key:kTitle];
    _author.text = [CommonTools getStringWithDict:dict key:kAuthor];
    _time.text = [CommonTools getStringWithDict:dict key:kAdd_time];
    
    [_webView loadHTMLString:[dict objectForKey:kContent] baseURL:nil];

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

#pragma mark - 点击更多
- (IBAction)moreClick:(UIButton *)sender {
    
    
}

@end
