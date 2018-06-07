//
//  CircumListTableViewCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumListTableViewCell.h"
#import "StarLevelView.h"

@interface CircumListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIView *starBgView;
@property(nonatomic, strong)StarLevelView *starView;
@end

@implementation CircumListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _starView = [[StarLevelView alloc]initWithFrame:CGRectMake(0, 0, 120, 20) animated:true];
    _starView.tapEnable = false;
    [_starBgView addSubview:_starView];
    _starView.externalScore = 4;
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
