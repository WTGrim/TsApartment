//
//  WTAlertView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "WTAlertView.h"

#define DefaultDuration 1.0f
#define WarningViewMinHeight 120.0f
#define ButtonHeight 40.0f
#define DefaultGap 30.0f
#define OnlyTextHeight 40.0f
#define DefaultFont [UIFont systemFontOfSize:14]


@interface WTAlertView(){
    NSInteger _maxIndex;
    UILabel *_titleLabel;
    UILabel *_messageLabel;
    UIImageView *_imageView;
}

@property (strong, nonatomic) NSMutableArray *buttonName;
@property (weak, nonatomic) id<WTAlertViewDelegate> delegate;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *warningView;

@end

@implementation WTAlertView

+ (instancetype)shareInstance {
    static WTAlertView *alert = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        alert = [[WTAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return alert;
}

+ (void)showMessage:(NSString *)message {
    [[WTAlertView shareInstance] showMessage:message image:nil duration:DefaultDuration];
}

+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [[WTAlertView shareInstance] showMessage:message image:nil duration:duration];
}

- (void)showMessage:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration {
    if (!StringIsNull(message)) {
        [self createView];
        
        CGSize labelSize = [self getStringSizeWithString:message font:DefaultFont size:CGSizeZero];
        _warningView.frame = CGRectMake(0, 0, labelSize.width + 60, labelSize.height + 40);
        _warningView.center = [self getCenterInView:self];
        
        UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        warningLabel.center = [self getCenterInView:_warningView];
        warningLabel.text = message;
        warningLabel.textColor = [UIColor whiteColor];
        warningLabel.font = DefaultFont;
        warningLabel.numberOfLines = 0;
        warningLabel.textAlignment = NSTextAlignmentCenter;
        [_warningView addSubview:warningLabel];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self disMissView];
        });
    }
}

- (void)createView {
    self.frame = [UIScreen mainScreen].bounds;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [keyWindow bringSubviewToFront:self];
    
    [self removeSubViews];
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor clearColor];
    //    [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:0.5f];
    [self addSubview:_backgroundView];
    
    _warningView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, WarningViewMinHeight)];
    _warningView.backgroundColor = [UIColor colorWithWhite:10/255.0f alpha:0.85f];
    _warningView.layer.cornerRadius = 5;
    _warningView.clipsToBounds = YES;
    [self addSubview:_warningView];
}

- (void)disMissView {
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeSubViews];
        }
    }];
}

- (void)removeSubViews {
    _titleLabel = nil;
    _messageLabel = nil;
    _imageView = nil;
    if (_backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
    }
    if (_warningView) {
        [_warningView removeFromSuperview];
        _warningView = nil;
    }
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message  image:(UIImage *)image alertViewDelegate:(id<WTAlertViewDelegate>)delegate cancelButton:(NSString *)cancel otherButton:(NSString *)otherStr, ... {
    
    NSMutableArray *buttonNames = [[NSMutableArray alloc] init];
    if (otherStr) {
        va_list buttonList;
        [buttonNames addObject:otherStr];
        va_start(buttonList, otherStr);
        NSString *buttonName;
        while ((buttonName = va_arg(buttonList, NSString *))) {
            [buttonNames addObject:buttonName];
        }
        va_end(buttonList);
    }
    if (cancel) {
        [buttonNames addObject:cancel];
    }
    
    [[WTAlertView shareInstance] showAlertWithTitle:title message:message buttonNames:buttonNames image:image alertViewDelegate:delegate];
}
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonNames:(NSArray *)buttonArray image:(UIImage *)image alertViewDelegate:(id<WTAlertViewDelegate>)delegate {
    [self createView];
    if (delegate) {
        _delegate = delegate;
    }
    _maxIndex = buttonArray.count - 1;
    __weak typeof(self) weakSelf = self;
    
    CGFloat imageWidth = 0.0f;
    if (image) {
        imageWidth = image.size.width;
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = CGRectMake(_warningView.center.x - image.size.width * 0.5, 15, image.size.width, image.size.height);
        [_warningView addSubview:_imageView];
    }
    
    if (title && title.length > 0) {
        [self createTitleLabelWithTitle:title imageWidth:imageWidth buttonShow:buttonArray.count > 0 ? YES : NO];
        if (_imageView) {
            _imageView.center = CGPointMake(_titleLabel.frame.origin.x - imageWidth * 0.5 - 8, _titleLabel.center.y);
        }
    }
    
    if (message && message.length > 0) {
        [self createMessageLabelWithMessage:message buttonShow:buttonArray.count > 0 ? YES : NO];
    }
    
    if(buttonArray.count > 0) {
        [self createButtonWithButtonNames:buttonArray];
    }
    
    CGSize titleSize = _titleLabel.bounds.size;
    CGSize messageSize = _messageLabel.bounds.size;
    CGFloat locationY = titleSize.height + messageSize.height + 8;
    if (titleSize.height == 0.0f || messageSize.height == 0.0f) {
        locationY -= 8;
    }
    if (buttonArray.count > 0) {
        locationY += DefaultGap * 2;
        locationY += ButtonHeight;
    }else {
        _titleLabel.center = CGPointMake(_titleLabel.center.x, _warningView.center.y);
        _imageView.center = CGPointMake(_imageView.center.x, _warningView.center.y);
        locationY += OnlyTextHeight * 2;
        [self createRigthCancelButtonInView:_warningView];
    }
    
    _warningView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 80, locationY > WarningViewMinHeight ? locationY : WarningViewMinHeight);
    _warningView.center = [weakSelf getCenterInView:weakSelf];
    _warningView.backgroundColor = [UIColor whiteColor];
}

- (void)createTitleLabelWithTitle:(NSString *)title imageWidth:(CGFloat)imageWidth buttonShow:(BOOL)buttonShow {
    CGFloat distance = buttonShow ? DefaultGap : OnlyTextHeight;
    CGSize titleSize = [self getStringSizeWithString:title font:[UIFont systemFontOfSize:15] size:CGSizeMake(_warningView.frame.size.width - 16 -  imageWidth, Maxheight())];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleSize.width, titleSize.height)];
    _titleLabel.center = CGPointMake(_warningView.center.x + imageWidth * 0.5, titleSize.height*0.5 + distance);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = title;
    _titleLabel.numberOfLines = 0;
    [_warningView addSubview:_titleLabel];
}

- (void)createMessageLabelWithMessage:(NSString *)message buttonShow:(BOOL)buttonShow {
    CGSize titleSize = _titleLabel.bounds.size;
    CGFloat distance = buttonShow ? DefaultGap : OnlyTextHeight;
    
    CGSize messageSize = [self getStringSizeWithString:message font:DefaultFont size:CGSizeZero];
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, messageSize.width + 5, messageSize.height)];
    CGFloat locationY = messageSize.height * 0.5 + titleSize.height + distance + 8;
    if (titleSize.height == 0.0f) {
        locationY -= 8;
    }
    _messageLabel.center = CGPointMake(_warningView.center.x, locationY);
    _messageLabel.text = message;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.textColor = [UIColor colorWithWhite:100/255.0 alpha:1.0f];
    _messageLabel.font = DefaultFont;
    _messageLabel.numberOfLines = 0;
    [_warningView addSubview:_messageLabel];
    
}

- (void)createRigthCancelButtonInView:(UIView *)view {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 35, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"cancelX"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightCancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_warningView addSubview:button];
}

- (void)rightCancelButtonClicked {
    [self disMissView];
}

- (void)createButtonWithButtonNames:(NSArray *)buttonArray {
    CGSize titleSize = _titleLabel.bounds.size;
    CGSize messageSize = _messageLabel.bounds.size;
    __block CGFloat buttonWidth = _warningView.bounds.size.width / buttonArray.count;
    [buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat locationY = titleSize.height + messageSize.height + DefaultGap * 2 + 8;
        if (titleSize.height == 0.0f || messageSize.height == 0.0f) {
            locationY -= 8;
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(idx * buttonWidth, locationY, buttonWidth, ButtonHeight)];
        button.tag = idx;
        button.titleLabel.font = DefaultFont;
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:100/255.0 alpha:1.0f] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_warningView addSubview:button];
        
        CALayer *lineLayer = [CALayer layer];
        lineLayer.frame = CGRectMake(0, 0, buttonWidth, 0.5);
        lineLayer.backgroundColor = [UIColor colorWithWhite:180/255.0 alpha:1.0f].CGColor;
        [button.layer addSublayer:lineLayer];
        
        if (idx != buttonArray.count - 1) {
            CALayer *lineLayer = [CALayer layer];
            lineLayer.frame = CGRectMake(buttonWidth - 0.5, 0, 0.5f, ButtonHeight);
            lineLayer.backgroundColor = [UIColor colorWithWhite:180/255.0 alpha:1.0f].CGColor;
            [button.layer addSublayer:lineLayer];
        }
    }];
}

- (void)buttonClicked:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(wtAlertView:clickedButtonAtIndex:)]) {
        [_delegate wtAlertView:self clickedButtonAtIndex:button.tag];
    }
    [self disMissView];
}

#pragma mark —— 获取字符串的宽度
- (CGSize)getStringSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size{
    if (!StringIsNull(string)) {
        CGSize maxSize = CGSizeEqualToSize(size, CGSizeZero) ? CGSizeMake(MaxWidth(), Maxheight()) : size;
        CGSize stringSize = [string boundingRectWithSize:maxSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                              attributes:@{NSFontAttributeName:font}
                                                 context:nil].size;
        return stringSize;
    }
    return CGSizeZero;
}

- (CGPoint)getCenterInView:(UIView *)view {
    return CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
}

CGFloat MaxWidth() {
    return SCREEN_WIDTH - 120;
}

CGFloat Maxheight() {
    return 100;
}

@end
