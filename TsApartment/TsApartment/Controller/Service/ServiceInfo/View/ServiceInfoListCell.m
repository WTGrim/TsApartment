//
//  ServiceInfoListCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/1.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoListCell.h"
#import "UIImageView+EasyInOut.h"

@interface ServiceInfoListCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;


@end
@implementation ServiceInfoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    [_icon wt_setImageWithURL:[dict objectForKey:kIndex_img] placeholderImage:[UIImage imageNamed:@"placeholder_img"] completed:nil];
    _title.text = [CommonTools getStringWithDict:dict key:kTitle];
    _desc.text = [CommonTools getStringWithDict:dict key:kDescription];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
