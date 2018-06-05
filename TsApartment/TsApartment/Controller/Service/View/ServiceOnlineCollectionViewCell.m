//
//  ServiceOnlineCollectionViewCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceOnlineCollectionViewCell.h"
#import "UIImageView+EasyInOut.h"

@interface ServiceOnlineCollectionViewCell()

//标题
@property (weak, nonatomic) IBOutlet UILabel *title;
//描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation ServiceOnlineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    
    _title.text = [CommonTools getStringWithDict:dict key:kName];
    _desc.text = [CommonTools getStringWithDict:dict key:kDesc];
    [_icon wt_setImageWithURL:[dict objectForKey:[CommonTools getFitImgName]] placeholderImage:[UIImage imageNamed:@""] completed:nil];
}

@end
