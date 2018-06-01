//
//  SearchItemView.h
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchItemView : UIView

//间隔，默认10
@property(nonatomic, assign)CGFloat itemMargin;
//item文本颜色
@property(nonatomic, strong)UIColor *textColor;
//背景颜色
@property(nonatomic, strong)UIColor *itemBackgroundColor;
//总体高度
@property(nonatomic, assign)CGFloat listHeight;
//所有item数据
@property(nonatomic, strong)NSMutableArray *listItemArray;
//itemButton内间距
@property(nonatomic, assign)CGFloat itemButtonMargin;
//item列数
@property(nonatomic, assign)NSInteger itemCols;
//是否有圆角
@property(nonatomic, assign)CGFloat cornerRadius;
//文字大小
@property(nonatomic, strong)UIFont *itemFont;
//item高度
@property(nonatomic, assign)CGFloat itemHeight;

@property(nonatomic, assign)BOOL fitListHeight;
- (void)addItem:(NSString *)title;
- (void)addItems:(NSArray *)titleArray;

//点击标签
@property(nonatomic, copy)void(^itemClick)(NSString *item);

@end
