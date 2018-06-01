//
//  HomeSectionHeader.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "HomeSectionHeader.h"
#import <Masonry.h>

#define LINE_H 5
#define LINE_W 40

@interface HomeSectionHeader()

//标题
@property(nonatomic, strong)UILabel *titleLabel;
//查看更多
@property(nonatomic, strong)UILabel *moreLabel;
//又箭头
@property(nonatomic, strong)UIImageView *arrow;
//查看更多view
@property(nonatomic, strong)UIView *checkMoreView;
//底部的线
@property(nonatomic, strong)UIView *bottomLine;

@end

@implementation HomeSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = ThemeColor_BlackText;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_titleLabel];
    
    _checkMoreView = [[UIView alloc]init];
    [_checkMoreView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkMoreClick)]];
    [self addSubview:_checkMoreView];
    
    //右箭头
    _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    [_checkMoreView addSubview:_arrow];
    
    //查看更多
    _moreLabel = [[UILabel alloc]init];
    _moreLabel.text = @"查看更多";
    _moreLabel.font = [UIFont systemFontOfSize:13];
    _moreLabel.textColor = ThemeColor_GrayText;
    [_checkMoreView addSubview:_moreLabel];
    
    //底部的线
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = ThemeColor_HomeLine;
    _bottomLine.layer.cornerRadius = LINE_H * 0.5;
    _bottomLine.layer.masksToBounds = true;
    [self addSubview:_bottomLine];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(- 10);
    }];
    
    [_checkMoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.checkMoreView).offset(-15);
        make.bottom.equalTo(self.checkMoreView).offset(-10);
    }];
    
    [_moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.arrow);
        make.right.equalTo(self.arrow.mas_left).offset(-5);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self).offset(-LINE_H);
        make.width.equalTo(@LINE_W);
        make.height.equalTo(@LINE_H);
    }];
}

#pragma mark - 查看更多
- (void)checkMoreClick{
    if (_checkMore) {
        _checkMore();
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

- (void)setHiddenCheckMore:(BOOL)hiddenCheckMore{
    
    _hiddenCheckMore = hiddenCheckMore;
    _moreLabel.hidden = _hiddenCheckMore;
    _arrow.hidden = _hiddenCheckMore;
}

@end
