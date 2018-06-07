//
//  PhotoGroupView.h
//  FineexFQXD2.0
//
//  Created by Dwt on 2017/3/22.
//  Copyright © 2017年 FineEx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhotoGroupHeightBlock)(CGFloat height);

@interface PhotoGroupView : UIView

@property(nonatomic, strong)NSArray *imageUrlArray;
@property(nonatomic, assign)CGFloat totalHeight;

@property(nonatomic, copy)PhotoGroupHeightBlock photoGroupHeightBlock;
@end
