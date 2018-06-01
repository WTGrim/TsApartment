//
//  DistCollectionViewCell.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "DistCollectionViewCell.h"

@implementation DistCollectionViewCell{
    
    __weak IBOutlet UIImageView *picture;
    __weak IBOutlet UILabel *desc;
    __weak IBOutlet UILabel *price;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath{
    
}

@end
