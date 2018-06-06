//
//  ServiceInfoCollectionViewCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoCollectionViewCell.h"
#import <Masonry.h>
#import "UIImageView+EasyInOut.h"

@interface ServiceInfoCollectionViewCell()

@property(nonatomic, strong)UIImageView *pic;
@property(nonatomic, strong)UILabel *title;

@end

@implementation ServiceInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    _title.text = [CommonTools getStringWithDict:dict key:kTitle];
    [_pic wt_setImageWithURL:[dict objectForKey:kIndex_img] placeholderImage:[UIImage imageNamed:@"placeholder_img"] completed:nil];
}

- (void)setupUI{
    
    _pic = [UIImageView new];
    _pic.contentMode = UIViewContentModeScaleAspectFill;
    _pic.clipsToBounds = true;
    _pic.image = [UIImage imageNamed:@"temp_image"];
    [self.contentView addSubview:_pic];
    
    _title = [UILabel new];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textColor = ThemeColor_BlackText;
    _title.text = @"五区公寓";
    [self.contentView addSubview:_title];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pic);
        make.height.equalTo(@20);
        make.top.equalTo(self.pic.mas_bottom).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
}

@end
