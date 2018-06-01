//
//  HomeLocationView.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "HomeLocationView.h"

#define LOCATION_W 10

@interface HomeLocationView()

@property(nonatomic, strong)UILabel *cityLabel;
@property(nonatomic, strong)UIImageView *locationImage;
@property(nonatomic, copy)void(^onClick)(void);

@end

@implementation HomeLocationView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame onClick:(void (^)(void))onClick{
    if (self = [super initWithFrame:frame]) {
        _onClick = onClick;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame) - LOCATION_W, CGRectGetHeight(self.frame))];
    _cityLabel.text = @"北京";
    [_cityLabel sizeToFit];
    _cityLabel.wt_centerY = self.center.y;
    _cityLabel.textColor = ThemeColor_BlackText;
    _cityLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_cityLabel];
    
    _locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityLabel.frame) , CGRectGetMaxY(_cityLabel.frame) - LOCATION_W, LOCATION_W, LOCATION_W)];
    _locationImage.image = [UIImage imageNamed:@"location"];
    [self addSubview:_locationImage];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
}

- (void)tapClick{
    if (_onClick) {
        _onClick();
    }
}

#pragma mark - setter
- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    _cityLabel.text = _cityName;
    [self layoutSubviews];
}

@end
