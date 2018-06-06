//
//  CommentBottomView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommentBottomView.h"

#define MARGIN 15
#define BTN_W 40
@implementation CommentBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    _commentTextField = [[CommentTextField alloc]initWithFrame:CGRectMake(15, 10, CGRectGetWidth(self.frame) - 2 * MARGIN, CGRectGetHeight(self.frame))];
    _commentTextField.wt_centerY = self.wt_centerY;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.image = [UIImage imageNamed:@"comment_pen"];
    _commentTextField.leftView = imageView;
    _commentTextField.leftViewMode = UITextFieldViewModeAlways;
    _commentTextField.rightViewMode = UITextFieldViewModeAlways;

    _commentTextField.layer.cornerRadius = CGRectGetHeight(_commentTextField.frame) * 0.5;
    _commentTextField.layer.masksToBounds = true;
    _commentTextField.layer.borderWidth = 1;
    _commentTextField.font = [UIFont systemFontOfSize:14];
    _commentTextField.returnKeyType = UIReturnKeySend;
    _commentTextField.layer.borderColor = ThemeColor_line.CGColor;
    
    UIButton *publicBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    publicBtn.backgroundColor = ThemeColor_Yellow;
    publicBtn.layer.cornerRadius = 2;
    publicBtn.layer.masksToBounds = true;
    [publicBtn setTitle:@"发布" forState:UIControlStateNormal];
    publicBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [publicBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    _commentTextField.rightView = publicBtn;

    [self addSubview:_commentTextField];
}

- (void)publishClick{
    if (_commentTextField.text.length == 0) {
        return;
    }
    if (_publicCallBack) {
        _publicCallBack(_commentTextField.text);
    }
}

@end
