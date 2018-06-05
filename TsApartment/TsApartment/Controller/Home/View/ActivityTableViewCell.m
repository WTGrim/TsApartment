//
//  ActivityTableViewCell.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "CommonTools.h"

@interface ActivityTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *join;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    
    _title.text = [CommonTools getStringWithDict:dict key:kTitle];
    _join.text = [NSString stringWithFormat:@"已有%ld人参加", [[dict objectForKey:kPartake] integerValue]];
    _time.text = [CommonTools getStringWithDict:dict key:kActivity_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
