//
//  PhotoScanView.m
//  PhotoScan
//
//  Created by Dwt on 2017/1/6.
//  Copyright © 2017年 Dwt. All rights reserved.
//

#import "PhotoScanView.h"
#import "PhotoScanImageView.h"
#import <UIImageView+WebCache.h>

#define ScanImageViewTag 10000
#define Margin 10
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface PhotoScanView ()<UIScrollViewDelegate>

@end
@implementation PhotoScanView {
    UIScrollView *_scrollView;
    BOOL _hasShow;
    UILabel *_pageLabel;
    UIPageControl *_pageControl;
    BOOL _willDisappear;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.95];
    }
    return self;
}

- (void)didMoveToSuperview{
    [self initScrollView];
    [self initPageLabelAndPageControl];
}

- (void)initScrollView{
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    for (int i = 0; i < self.imagesCount; i++) {
        PhotoScanImageView *scanImageView = [[PhotoScanImageView alloc]init];
        scanImageView.tag = i + ScanImageViewTag;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 1.0;
        doubleTap.numberOfTapsRequired = 2;
        [tap requireGestureRecognizerToFail:doubleTap];
        [scanImageView addGestureRecognizer:tap];
        [scanImageView addGestureRecognizer:doubleTap];
        [scanImageView addGestureRecognizer:longPress];
        
        [_scrollView addSubview:scanImageView];
    }
    
    [self setImageAtIndex:self.currentIndex];
}

- (void)setImageAtIndex:(NSInteger)index{
    
    PhotoScanImageView *scanImageView = _scrollView.subviews[index];
    self.currentIndex = index;
    if (scanImageView.hasLoaded)return;
    
    if ([self reloadLargeImageAtIndex:index]) {
        [scanImageView sd_setImageWithURL:[self reloadLargeImageAtIndex:index] placeholderImage:[self originalImageAtIndex:index]];
    }else{
        scanImageView.image = [self originalImageAtIndex:index];
    }
    scanImageView.hasLoaded = YES;
}

- (NSURL *)reloadLargeImageAtIndex:(NSInteger)index{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoScanView:reloadLargeImageAtIndex:)]) {
        return  [self.delegate photoScanView:self reloadLargeImageAtIndex:index];
    }
    return nil;
}

- (UIImage *)originalImageAtIndex:(NSInteger)index{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoScanView:originalImageAtIndex:)]) {
        return [self.delegate photoScanView:self originalImageAtIndex:index];
    }
    return nil;
}

#pragma mark - 初始化序号和pageControl
- (void)initPageLabelAndPageControl{
    
    _pageLabel = [[UILabel alloc]init];
    _pageLabel.frame = CGRectMake(0, 0, 60, 30);
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = [UIFont boldSystemFontOfSize:14];
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _pageLabel.layer.cornerRadius = _pageLabel.frame.size.height * 0.5;
    _pageLabel.layer.masksToBounds = YES;
    if (self.imagesCount > 1) {
        _pageLabel.hidden = NO;
        _pageLabel.text = [NSString stringWithFormat:@"1/%ld", self.imagesCount];
    }else{
        _pageLabel.hidden = YES;
    }
    [self addSubview:_pageLabel];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    _pageControl.center = CGPointMake(self.center.x, ScreenHeight - 40);
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = self.imagesCount;
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
}

#pragma mark - 长按手势(待扩展)
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    
    if(longPress.state == UIGestureRecognizerStateBegan){
        NSLog(@"保存照片成功");
    }
}

#pragma mark - 单击图片，取消展示
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    _scrollView.hidden = YES;
    _willDisappear = YES;
    PhotoScanImageView *scanImageView = (PhotoScanImageView *)tap.view;
    NSInteger index = scanImageView.tag - ScanImageViewTag;
    
    UIView *originalView = self.originalContainerView.subviews[index];
    CGRect targetRect = [self.originalContainerView convertRect:originalView.frame toView:self];  //返回在目标视图中的rect
    UIImageView *tempImageView = [[UIImageView alloc]init];
    tempImageView.contentMode = originalView.contentMode;
    tempImageView.clipsToBounds = YES;
    tempImageView.image = scanImageView.image;
    
    CGFloat H = scanImageView.image.size.height * (self.bounds.size.width / scanImageView.image.size.width);
    if (!scanImageView.image) {
        H = self.bounds.size.height;
    }
    tempImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, H);
    tempImageView.center = self.center;
    [self addSubview:tempImageView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        tempImageView.frame = targetRect;
        self.backgroundColor = [UIColor clearColor];
        _pageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 双击图片放大
- (void)doubleTap:(UITapGestureRecognizer *)doubleTap{
    
    PhotoScanImageView *imageView = (PhotoScanImageView *)doubleTap.view;
    CGFloat scale;
    if (imageView.isScale) {
        scale = 1;
    }else{
        scale = 2;
    }
    PhotoScanImageView *view = (PhotoScanImageView *)doubleTap.view;
    [view doubleTapToZoom:scale];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += Margin * 2;
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    
    CGFloat Y = 0;
    CGFloat W = _scrollView.frame.size.width - 2 * Margin;
    CGFloat H = _scrollView.frame.size.height;
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof PhotoScanImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat X = Margin + idx * (Margin * 2 + W);
        obj.frame = CGRectMake(X, Y, W, H);
    }];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentIndex * _scrollView.frame.size.width, 0);
    
    if (!_hasShow) {
        [self beginShow];
    }
    _pageLabel.center = CGPointMake(self.bounds.size.width * 0.5, 40);
}

#pragma mark - 开始展示图片
- (void)beginShow{
    
    UIView *originalView = self.originalContainerView.subviews[self.currentIndex];
    CGRect rect = [self.originalContainerView convertRect:originalView.frame toView:self];
    
    UIImageView *tempImageView = [[UIImageView alloc]init];
    tempImageView.clipsToBounds = YES;
    tempImageView.image = [self originalImageAtIndex:self.currentIndex];
    [self addSubview:tempImageView];
    
    CGRect targetRect = [_scrollView.subviews[self.currentIndex] bounds];
    tempImageView.frame = rect;
    tempImageView.contentMode = [_scrollView.subviews[self.currentIndex] contentMode];
    _scrollView.hidden = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        tempImageView.center = self.center;
        tempImageView.bounds = (CGRect){CGPointZero, targetRect.size};
        
    } completion:^(BOOL finished) {
        _hasShow = YES;
        [tempImageView removeFromSuperview];
        _scrollView.hidden = NO;
        
    }];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int pageIndex = (scrollView.contentOffset.x + _scrollView.frame.size.width * 0.5) / _scrollView.bounds.size.width;

    CGFloat margin = 150;
    CGFloat X = scrollView.contentOffset.x;
    if (X - pageIndex * self.bounds.size.width > margin || X - pageIndex * self.bounds.size.width < - margin) {
        PhotoScanImageView *imageView = _scrollView.subviews[self.currentIndex];
        if (imageView.isScale) {
            
            [UIView animateWithDuration:0.5 animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [imageView clearScale];
            }];
        }
    }
    
    if (!_willDisappear) {
        _pageLabel.text = [NSString stringWithFormat:@"%d/%ld", pageIndex + 1, self.imagesCount];
    }
    [self setImageAtIndex:pageIndex];
    _pageControl.currentPage = pageIndex;
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [window addSubview:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
        PhotoScanImageView *imageView = _scrollView.subviews[self.currentIndex];
        if ([imageView isKindOfClass:[PhotoScanImageView class]]) {
            [imageView clearSubViews];
        }
    }
}

- (void)dealloc{
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
}

@end
