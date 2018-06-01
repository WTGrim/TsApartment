//
//  LocationChooseCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "LocationChooseCell.h"
#import <Masonry.h>

@interface LocationChooseCell()
//城市
@property(nonatomic, strong)UILabel *city;
//勾选
@property(nonatomic, strong)UIImageView *checkImageView;

@end

@implementation LocationChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _city = [[UILabel alloc]init];
    _city.font = [UIFont systemFontOfSize:14];
    _city.textColor = ThemeColor_BlackText;
    _city.text = @"成都";
    [self.contentView addSubview:_city];
    
    _checkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"location_check"]];
    _checkImageView.hidden = true;
    [self.contentView addSubview:_checkImageView];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor darkGrayColor];
    [self.contentView addSubview:line];
    
    [_city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
    }];
    
    [_checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        _checkImageView.hidden = false;
        _city.textColor = [UIColor orangeColor];
    }else{
        _checkImageView.hidden = true;
        _city.textColor = ThemeColor_BlackText;
    }
    // Configure the view for the selected state
}

@end
