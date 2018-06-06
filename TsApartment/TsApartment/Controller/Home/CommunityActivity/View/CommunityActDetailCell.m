//
//  CommunityActDetailCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommunityActDetailCell.h"

@interface CommunityActDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation CommunityActDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    _name.text = [CommonTools getStringWithDict:dict key:kUsername];
    _num.text = [NSString stringWithFormat:@"%ld人", [[dict objectForKey:kNumber] integerValue]];
    _mobile.text = [CommonTools getStringWithDict:dict  key:kMobile];
    _time.text = [CommonTools getStringWithDict:dict key:kAdd_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
