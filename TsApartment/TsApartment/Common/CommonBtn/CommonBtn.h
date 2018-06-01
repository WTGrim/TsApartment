//
//  CommonBtn.h
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonBtn : UIButton


@end

@interface MessageBtn: UIButton

//消息数
@property (nonatomic, assign) NSInteger badgeNumber;
//隐藏
@property (nonatomic, assign) BOOL badgeHidden;

@end

@interface ListHeaderBtn : UIButton

@end
