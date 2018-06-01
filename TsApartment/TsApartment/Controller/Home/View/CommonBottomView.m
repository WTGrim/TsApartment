//
//  CommonBottomView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/1.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommonBottomView.h"
#import <Masonry.h>

#define BOTTOM_H 100
@interface CommonBottomView()

@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation CommonBottomView

+ (instancetype)shareInstance{
    static CommonBottomView *bottomView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bottomView = [[CommonBottomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BOTTOM_H)];
        [bottomView setupUI];
    });
    return bottomView;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_bottom"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
