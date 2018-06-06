//
//  OperationView.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/20.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "OperationView.h"
#import <Masonry.h>

@interface OperationView ()

@property(nonatomic, strong)UIButton *likeButton;
@property(nonatomic, strong)UIButton *commentButton;

@end
@implementation OperationView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.clipsToBounds = YES;//AlbumLike   AlbumComment
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor whiteColor];
    _likeButton = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"service_like"] selImage:nil target:self selector:@selector(likeButtonClicked)];
    [self addSubview:_likeButton];
    _commentButton = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"service_comment"] selImage:nil target:self selector:@selector(commentButtonClicked)];
    [self addSubview:_commentButton];

    
    WEAKSELF;
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(0);
        make.left.mas_equalTo(self).offset(5);
        make.bottom.mas_equalTo(self).offset(0);
        make.width.mas_equalTo(80);
    }];

    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(0);
        make.left.mas_equalTo(weakSelf.likeButton.mas_right).offset(20);
        make.bottom.mas_equalTo(self).offset(0);
        make.width.mas_equalTo(80);
    }];
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

-(void)setPraiseString:(NSString *)praiseString{
    _praiseString = praiseString;
    [_likeButton setTitle:praiseString forState:UIControlStateNormal];
}

- (void)likeButtonClicked{
    if(self.likeBtnClicked){
        self.likeBtnClicked();
    }
}

- (void)commentButtonClicked{
    if(self.commentBtnClicked){
        self.commentBtnClicked();
    }
}

@end
