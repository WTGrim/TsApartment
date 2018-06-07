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
@property(nonatomic, copy)void(^heightCallBack)(CGFloat height);

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
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = idx / count;
        NSInteger col = idx % count;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(ORIGIN_X + idx * w, ORIGIN_Y + row * h, w, h)];
        btn.tag = BTN_TAG + idx;
        
    }];
}

@end
