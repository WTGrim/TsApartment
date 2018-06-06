//
//  ContainView.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCellModel.h"

@protocol ContainViewDelegate <NSObject>

-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView;

@end
@interface ContainView : UIView

@property (nonatomic,strong)CommentCellModel *model;
@property (nonatomic,weak)id <ContainViewDelegate>delegate;

@end
