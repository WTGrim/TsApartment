//
//  SegmentItem.m
//  SegmentDemo
//
//  Created by SandClock on 2018/5/25.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SegmentItem.h"

@interface SegmentItem()

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *badgeLabel;

@end

@implementation SegmentItem

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
        [self setupUI];
    }
    return self;
}

- (void)config{
    _titleFont = [UIFont systemFontOfSize:12];
    _titleColor = [UIColor blackColor];
    _badgeFont = [UIFont systemFontOfSize:10];
    _badgeColor = [UIColor whiteColor];
    _badgeBgColor = [UIColor redColor];
    _isSelected = false;
    _selectedColor = [UIColor redColor];
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = _titleFont;
    _titleLabel.textColor = _titleColor;
    _titleLabel.center = self.center;
    [self addSubview:_titleLabel];
    
    _badgeLabel = [[UILabel alloc]init];
    _badgeLabel.font = _badgeFont;
    _badgeLabel.textColor = _badgeColor;
    _badgeLabel.backgroundColor = _badgeBgColor;
    [self addSubview:_badgeLabel];
    
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    _titleLabel.text = _title;
    _badgeLabel.center = CGPointMake(CGRectGetMaxX(_titleLabel.frame) - 20, CGRectGetMinY(_titleLabel.frame) - 20);
}

- (void)setBadge:(NSInteger)badge{
    _badge = badge;
    if (_badge == 0){
        _badgeLabel.hidden = true;
    }else{
        _badgeLabel.hidden = false;
        _badgeLabel.text = [NSString stringWithFormat:@"%ld", (long)_badge];
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    _titleLabel.textColor = isSelected ? _selectedColor : _titleColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
}


- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
}

- (void)setBadgeFont:(UIFont *)badgeFont{
    _badgeFont = badgeFont;
}

- (void)setBadgeColor:(UIColor *)badgeColor{
    _badgeBgColor = badgeColor;
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor{
    _badgeBgColor = badgeBgColor;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _titleLabel.textColor = _titleColor;
}

@end
