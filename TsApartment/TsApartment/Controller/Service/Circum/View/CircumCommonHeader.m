//
//  CircumCommonHeader.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumCommonHeader.h"

#define MARGIN 15
#define ORIGIN_X 20
#define ORIGIN_Y 20
#define BTN_TAG 100

@interface CircumCommonHeader()

@property(nonatomic, strong)NSArray *titles;
//高度回调
@property(nonatomic, copy)void(^heightCallBack)(CGFloat height);
//当前选中按钮
@property(nonatomic, strong)UIButton *currentBtn;
@end

@implementation CircumCommonHeader

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles heightCallBack:(void (^)(CGFloat))heightCallBack{
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _heightCallBack = heightCallBack;
        [self setup];
    }
    return self;
}

#pragma mark - initView
- (void)setup{
    
    self.backgroundColor = ThemeColor_LightYellow;
    CGFloat w = (SCREEN_WIDTH - 2 * ORIGIN_X - 3 * MARGIN) / 4.0;
    CGFloat h = w * 0.5;
    NSInteger count = _titles.count;
    WEAKSELF;
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = idx / 4;
        NSInteger col = idx % 4;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(ORIGIN_X + (w + MARGIN) * col, ORIGIN_Y + row * (ORIGIN_Y + h), w, h)];
        btn.tag = BTN_TAG + idx;
        btn.layer.cornerRadius = h * 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:weakSelf.titles[idx] forState:UIControlStateNormal];
        btn.layer.masksToBounds = true;
        btn.layer.borderWidth = 1.0;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (idx == 0) {
            weakSelf.currentBtn = btn;
            [self setBtnStatus:true btn:btn];
        }else{
            [self setBtnStatus:false btn:btn];
        }
        [self addSubview:btn];
    }];
    NSInteger j = count / 4 > 0 ? 1 : 0;
    CGFloat headerHeight = (count / 4 + j) * h + (count / 4 + j + j) * ORIGIN_Y ;
    if (_heightCallBack) {
        _heightCallBack(headerHeight);
    }
}

- (void)btnClick:(UIButton *)btn{
    if (_currentBtn == btn) return;
    [self setBtnStatus:true btn:btn];
    [self setBtnStatus:false btn:_currentBtn];
    _currentBtn = btn;
    if (_onClick) {
        _onClick(btn.tag - BTN_TAG);
    }
}

-(void)setBtnStatus:(BOOL)isSelected btn:(UIButton *)btn{
    if (isSelected) {
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:ThemeColor_Yellow];
        btn.layer.borderColor = [UIColor clearColor].CGColor;
    }else{
        [btn setTitleColor:ThemeColor_BlackText forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = ThemeColor_line.CGColor;
    }
}

@end
