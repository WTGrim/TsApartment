//
//  SearchHotTableViewCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SearchHotTableViewCell.h"
#import "SearchItemView.h"
#define MARGIN 25

@implementation SearchHotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setSearchHotView:(SearchItemView *)searchHotView{
    _searchHotView = searchHotView;
    [self.contentView addSubview:_searchHotView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _searchHotView.frame = CGRectMake(MARGIN, 0, CGRectGetWidth(self.frame) - MARGIN * 2, CGRectGetHeight(self.frame));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
