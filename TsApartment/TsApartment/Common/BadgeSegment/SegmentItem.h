//
//  SegmentItem.h
//  SegmentDemo
//
//  Created by SandClock on 2018/5/25.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentItem : UIView

/**标题*/
@property(nonatomic, copy)NSString *title;
/**标题大小*/
@property(nonatomic, strong)UIFont *titleFont;
/**标题颜色*/
@property(nonatomic, strong)UIColor *titleColor;
/**标题选中颜色*/
@property(nonatomic, strong)UIColor *selectedColor;
/**标题是否选中*/
@property(nonatomic, assign)BOOL isSelected;
/**角标*/
@property(nonatomic, assign)NSInteger badge;
/**角标颜色*/
@property(nonatomic, strong)UIColor *badgeColor;
/**角标背景*/
@property(nonatomic, strong)UIColor *badgeBgColor;
/**角标大小*/
@property(nonatomic, strong)UIFont *badgeFont;


@end
