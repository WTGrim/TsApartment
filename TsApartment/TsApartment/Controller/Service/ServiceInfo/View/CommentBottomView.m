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

@interface CommentBottomView()<UITextFieldDelegate>


@end

@implementation CommentBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
    line.backgroundColor = ThemeColor_line;
    [self addSubview:line];
    
    _commentTextField = [[CommentTextField alloc]initWithFrame:CGRectMake(15, 5, CGRectGetWidth(self.frame) - 2 * MARGIN, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.image = [UIImage imageNamed:@"comment_pen"];
    _commentTextField.leftView = imageView;
    _commentTextField.delegate = self;
    _commentTextField.leftViewMode = UITextFieldViewModeAlways;
    _commentTextField.rightViewMode = UITextFieldViewModeAlways;

    _commentTextField.layer.cornerRadius = CGRectGetHeight(_commentTextField.frame) * 0.5;
    _commentTextField.layer.masksToBounds = true;
    _commentTextField.layer.borderWidth = 1;
    _commentTextField.font = [UIFont systemFontOfSize:14];
    _commentTextField.returnKeyType = UIReturnKeySend;
    _commentTextField.layer.borderColor = ThemeColor_line.CGColor;
    
    UIButton *publicBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    publicBtn.backgroundColor = ThemeColor_Yellow;
    publicBtn.layer.cornerRadius = 2;
    publicBtn.layer.masksToBounds = true;
    [publicBtn setTitle:@"发布" forState:UIControlStateNormal];
    publicBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [publicBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    _commentTextField.rightView = publicBtn;

    [self addSubview:_commentTextField];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length == 0) return false;
    if (_publicCallBack) {
        _publicCallBack(textField.text);
    }
    [textField resignFirstResponder];
    return true;
}

- (void)publishClick{
    if (_commentTextField.text.length == 0) {
        return;
    }
    if (_publicCallBack) {
        _publicCallBack(_commentTextField.text);
    }
    _commentTextField.text = nil;
}

@end
