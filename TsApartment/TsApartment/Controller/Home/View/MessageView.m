//
//  MessageView.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "MessageView.h"

#define SPOT_W 10

@interface MessageView()

//图标
@property(nonatomic, strong)UIImageView *imageView;
//红点
@property(nonatomic, strong)UIView *spot;
//点击回调
@property(nonatomic, copy)void(^onClick)(void);

@end

@implementation MessageView

- (instancetype)initWithFrame:(CGRect)frame onClick:(void (^)(void))onClick{
    if (self = [super initWithFrame:frame]) {
        _onClick = onClick;
        [self setupUI];
    }
    return self;
}

#pragma mark - initView
- (void)setupUI{
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"message"]];
    _imageView.center = self.center;
    [self addSubview:_imageView];
    
    _spot = [[UIView alloc]initWithFrame:CGRectMake(SPOT_W * 0.5, SPOT_W * 0.5, SPOT_W, SPOT_W)];
    _spot.backgroundColor = [UIColor redColor];
    _spot.layer.cornerRadius = SPOT_W * 0.5;
    _spot.layer.masksToBounds = true;
    [self addSubview:_spot];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
}

- (void)tapClick{
    if (_onClick) {
        _onClick();
    }
}

- (void)setSpotHidden:(BOOL)spotHidden{
    _spotHidden = spotHidden;
    _spot.hidden = _spotHidden;
}

@end
