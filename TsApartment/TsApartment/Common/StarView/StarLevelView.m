//
//  StarLevelView.m
//  HormoneSportsClient
//
//  Created by Dwt on 2017/6/30.
//  Copyright © 2017年 HormoneSports. All rights reserved.
//

#import "StarLevelView.h"

typedef void(^FinishBlock)(CGFloat currentStar);
@interface StarLevelView ()

@property(nonatomic, strong)UIView *foreLevelStarView;
@property(nonatomic, strong)UIView *backStarView;
@property(nonatomic, assign)NSInteger totalStar;
@property(nonatomic, assign)BOOL animated;
@property(nonatomic, assign)CGFloat currentScore;

@end

@implementation StarLevelView

- (instancetype)initWithFrame:(CGRect)frame animated:(BOOL)animated{
        if (self = [super initWithFrame:frame]) {
            _animated = animated;
            _totalStar = 5;
            _style = StarStyleCustom;
            self.userInteractionEnabled = true;
            [self createStarView];
        }
        return self;
}

- (UIView *)setStarViewWithImage:(NSString *)imageName{
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    view.clipsToBounds = true;
    view.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < self.totalStar; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * w / self.totalStar, 0, w / self.totalStar, h);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}


- (void)setTapEnable:(BOOL)tapEnable{
    _tapEnable = tapEnable;
    self.userInteractionEnabled = _tapEnable;
}

- (void)setStyle:(StarStyle)style{
    _style = style;
}

- (void)createStarView{

    self.backStarView = [self setStarViewWithImage:@"training_bgStar"];
    _foreLevelStarView = [self setStarViewWithImage:@"training_yellowStar"];
    
    [self addSubview:self.backStarView];
    [self addSubview:self.foreLevelStarView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    CGPoint tapPoint = [tap locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat score = offset / (self.bounds.size.width / self.totalStar);
    switch (_style) {
        case StarStyleCustom:
            self.currentScore = score;
            break;
        case StarStyleWhole:
            self.currentScore = ceilf(score);
            break;
        default:
            break;
    }
    
    if (self.currentScore <= 0) _currentScore = 0;
    if (self.currentScore >= self.totalStar) _currentScore = self.totalStar;
    if (_completed) {
        _completed(_currentScore);
    }
    [self setNeedsLayout];
}

- (void)setExternalScore:(CGFloat)externalScore{
    _externalScore = externalScore;
    _currentScore = _externalScore;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [UIView animateWithDuration:self.animated?0.2 : 0.0 animations:^{
        self.foreLevelStarView.frame = CGRectMake(0, 0, self.wt_width * self.currentScore / self.totalStar, self.wt_height);
    }];
}


@end
