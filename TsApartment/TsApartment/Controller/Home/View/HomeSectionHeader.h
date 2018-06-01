//
//  HomeSectionHeader.h
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSectionHeader : UIView

//标题
@property(nonatomic, copy)NSString *title;
//查看更多回调
@property(nonatomic, copy)void(^checkMore)(void);
//隐藏查看更多
@property(nonatomic, assign)BOOL hiddenCheckMore;


@end
