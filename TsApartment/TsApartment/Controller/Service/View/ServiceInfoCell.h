//
//  ServiceInfoCell.h
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ServiceInfoCellType) {
    ServiceInfoCellType_ServiceInfo,
    ServiceInfoCellType_Circum,
};

@interface ServiceInfoCell : UITableViewCell

- (void)setCellWithArray:(NSArray *)array cellType:(ServiceInfoCellType)cellType;

@end
