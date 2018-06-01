//
//  SearchItemView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/31.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SearchItemView.h"

@interface SearchItemView(){
    NSMutableArray *_itemsArray;
}

@property(nonatomic, strong)NSMutableDictionary *itemDict;
@property(nonatomic, strong)NSMutableArray *itemButtons;

@end
@implementation SearchItemView

- (NSMutableArray *)itemButtons{
    if (!_itemButtons) {
        _itemButtons = [NSMutableArray array];
    }
    return _itemButtons;
}

- (NSMutableDictionary *)itemDict{
    if (!_itemDict) {
        _itemDict = [NSMutableDictionary dictionary];
    }
    return _itemDict;
}

- (NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    _itemMargin = 10;
    _itemButtonMargin = 10;
    _cornerRadius = 13;
    _itemCols = 4;
    _textColor = [UIColor blackColor];
    _itemBackgroundColor = [UIColor whiteColor];
    _itemFont = [UIFont systemFontOfSize:13];
    _fitListHeight = YES;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
}

- (void)setItemMargin:(CGFloat)itemMargin{
    _itemMargin = itemMargin;
}

- (void)setItemButtonMargin:(CGFloat)itemButtonMargin{
    _itemButtonMargin = itemButtonMargin;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
}

- (void)setItemBackgroundColor:(UIColor *)itemBackgroundColor{
    _itemBackgroundColor = itemBackgroundColor;
}

- (void)setItemFont:(UIFont *)itemFont{
    _itemFont = itemFont;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
}

- (void)setItemHeight:(CGFloat)itemHeight{
    _itemHeight = itemHeight;
}

- (CGFloat)listHeight{
    
    if (self.itemButtons.count <= 0) return 0;
    return CGRectGetMaxY([self.itemButtons.lastObject frame]) + _itemMargin;
}

- (void)addItems:(NSArray *)titleArray{
    
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"Error" reason:@"先设置标签列表的frame" userInfo:nil];
    }
    for (NSString *title in titleArray) {
        [self addItem:title];
    }
}

- (void)addItem:(NSString *)title{
    
    UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectZero];
    itemButton.layer.cornerRadius = _cornerRadius;
    itemButton.clipsToBounds = YES;
    itemButton.tag = self.itemButtons.count;
    [itemButton setTitle:title forState:UIControlStateNormal];
    [itemButton setTitleColor:_textColor forState:UIControlStateNormal];
    [itemButton setBackgroundColor:_itemBackgroundColor];
    itemButton.titleLabel.font = _itemFont;
    [itemButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:itemButton];
    
    [self.itemButtons addObject:itemButton];
    [self.itemDict setObject:itemButton forKey:title];
    [self.itemsArray addObject:title];
    //设置item的位置
    [self updateItemFrame:itemButton.tag extraMagin:YES];
    
    //    // 更新自己的高度
    //    if (_fitListHeight) {
    //        CGRect frame = self.frame;
    //        frame.size.height = self.listHeight;
    //        [UIView animateWithDuration:0.25 animations:^{
    //            self.frame = frame;
    //        }];
    //    }
}

- (void)updateItemFrame:(NSInteger)i extraMagin:(BOOL)extraMagin{
    
    NSInteger preI = i - 1;
    
    UIButton *preButton;
    
    if (preI >= 0) {
        preButton = self.itemButtons[preI];
    }
    
    UIButton *button = self.itemButtons[i];
    [self setupTagButtonCustomFrame:button preButton:preButton extreMargin:YES];
    
}

- (void)setupTagButtonCustomFrame:(UIButton *)tagButton preButton:(UIButton *)preButton extreMargin:(BOOL)extreMargin
{
    CGFloat btnX = preButton? CGRectGetMaxX(preButton.frame) + _itemMargin : 0;
    
    CGFloat btnY = preButton? preButton.frame.origin.y : 0;
    
    CGFloat titleW = [tagButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_itemFont}].width;
    CGFloat titleH = _itemHeight;
    CGFloat btnW = extreMargin ? titleW + 2 * _itemButtonMargin : tagButton.bounds.size.width ;
    
    CGFloat btnH = extreMargin? titleH : tagButton.bounds.size.height;
    
    CGFloat rightWidth = self.bounds.size.width - btnX;
    
    if (rightWidth < btnW) {
        btnX = 0;
        btnY = CGRectGetMaxY(preButton.frame) + _itemMargin;
    }
    
    tagButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (void)clickItem:(UIButton *)button{
    
    if (_itemClick) {
        _itemClick(button.currentTitle);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


@end
