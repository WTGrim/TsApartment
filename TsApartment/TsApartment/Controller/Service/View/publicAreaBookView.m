//
//  publicAreaBookView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "publicAreaBookView.h"
#import "UIImageView+EasyInOut.h"

@implementation publicAreaBookView{
    
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *title;
    __weak IBOutlet UILabel *desc;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI{
    
}

- (void)setBookViewWithDict:(NSDictionary *)dict{
    
    [imageView wt_setImageWithURL:[dict objectForKey:[CommonTools getFitImgName]] placeholderImage:nil completed:nil];
    title.text = [dict objectForKey:kName];
    desc.text = [dict objectForKey:kDesc];
}

@end
