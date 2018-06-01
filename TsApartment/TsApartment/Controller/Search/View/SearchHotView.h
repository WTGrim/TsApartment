//
//  SearchHotView.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/1.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHotView : UIView

//缓存操作
- (void)saveLocalSearch:(NSString *)keyword;
//点击操作
@property(nonatomic, copy)void(^itemClick)(NSString *item);

@end
