//
//  SearchTableViewCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SearchTableViewCell.h"
#import <Masonry.h>

@interface SearchTableViewCell()

@property(nonatomic, strong)UILabel *titleName;

@end

@implementation SearchTableViewCell

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

- (void)setName:(NSString *)name{
    _name = name;
    _titleName.text = _name;
}

- (void)setupUI{
    
    _titleName = [UILabel new];
    _titleName.font = [UIFont systemFontOfSize:12];
    _titleName.textColor = ThemeColor_BlackText;
    [self.contentView addSubview:_titleName];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = ThemeColor_line;
    [self.contentView addSubview:bottomLine];
    
    [_titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-1);
        make.height.equalTo(@1);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
