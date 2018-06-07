//
//  PhotoScanImageView.m
//  PhotoScan
//
//  Created by Dwt on 2017/1/6.
//  Copyright © 2017年 Dwt. All rights reserved.
//

#import "PhotoScanImageView.h"
#import "PhotoProgressView.h"
#import <UIImageView+WebCache.h>

@interface PhotoScanImageView ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong)PhotoProgressView *progressView;
@end
@implementation PhotoScanImageView{
    
    CGFloat _totalScale;
    UIScrollView *_scrollView;      //超长图片的scrollView
    UIImageView *_imageView;
    UIScrollView *_zoomingScrollView;
    UIImageView *_zoomingImageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        _totalScale = 1;
        
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pin:)];
        pin.delegate = self;
        [self addGestureRecognizer:pin];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _progressView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGSize imageSize = self.image.size;
    
    //超长图片
    if (self.bounds.size.width * (imageSize.height / imageSize.width) > self.bounds.size.height) {
        if (!_scrollView) {
            _scrollView = [[UIScrollView alloc]init];
            _scrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
            _imageView = [[UIImageView alloc]init];
            _imageView.image = self.image;
            [_scrollView addSubview:_imageView];
            [self addSubview:_scrollView];
            if(_progressView){
                [self bringSubviewToFront:_progressView];
            }
        }
        _scrollView.frame = self.bounds;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        CGFloat H = self.bounds.size.width * (imageSize.height / imageSize.width);
        _imageView.bounds = CGRectMake(0, 0, _scrollView.frame.size.width, H);
        _imageView.center = CGPointMake(_scrollView.frame.size.width * 0.5, _imageView.frame.size.height * 0.5);
        _scrollView.contentSize = CGSizeMake(0, _imageView.frame.size.height);
        
    }else{
        if(_scrollView){
            [_scrollView removeFromSuperview];
        }
    }
}

- (BOOL)isScale{
    return _totalScale != 1;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    _progressView.progress = progress;
}

- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholderImage{
    _progressView = [[PhotoProgressView alloc]init];
    _progressView.style = ProgressStyle_annulus;
    _progressView.bounds = CGRectMake(0, 0, 100, 100);
    [self addSubview:_progressView];
    __weak typeof(self)weakself = self;
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        weakself.progressView.progress = (CGFloat)receivedSize / expectedSize;
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakself removeProgressView];
        if(image){
            _imageView.image = image;
            [_imageView setNeedsDisplay];
        }
    }];
}

#pragma mark - 捏合手势(放大缩小)
- (void)pin:(UIPinchGestureRecognizer *)pin{
    
    [self initZoomingScrollView];
    CGFloat scale = pin.scale;
    CGFloat tempScale = _totalScale + (scale - 1);
    [self setFinalScale:tempScale];
    pin.scale = 1.0;
}

- (void)setFinalScale:(CGFloat)scale{
    
    if ((_totalScale < 0.5 && _totalScale > scale) || (_totalScale > 2 && _totalScale < scale)) return;
    [self zoomWithScale:scale];
}

- (void)zoomWithScale:(CGFloat)scale{
    
    _totalScale  = scale;
    _zoomingImageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (scale > 1) {
        
        CGFloat W = _zoomingImageView.frame.size.width;
        CGFloat H = MAX(_zoomingImageView.frame.size.height, self.frame.size.height);
        _zoomingImageView.center = CGPointMake(W * 0.5, H * 0.5);
        _zoomingScrollView.contentSize = CGSizeMake(W, H);
        
        CGPoint offset = _zoomingScrollView.contentOffset;
        offset.x = (W - _zoomingScrollView.frame.size.width) * 0.5;
        _zoomingScrollView.contentOffset = offset;
    }else{
        
        _zoomingScrollView.contentSize = _zoomingScrollView.frame.size;
        _zoomingScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _zoomingImageView.center = _zoomingScrollView.center;
    }
}

- (void)initZoomingScrollView{
    if (!_zoomingScrollView) {
        _zoomingScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _zoomingScrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
        _zoomingScrollView.contentSize = self.bounds.size;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.image];
        CGSize imageSize = imageView.image.size;
        CGFloat imageHeight = self.bounds.size.height;
        if (imageSize.width > 0) {
            imageHeight = self.bounds.size.width * (imageSize.height / imageSize.width);
        }
        imageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageHeight);
        imageView.center = _zoomingScrollView.center;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomingImageView = imageView;
        [_zoomingScrollView addSubview:_zoomingImageView];
        [self addSubview:_zoomingScrollView];
    }
}

- (void)doubleTapToZoom:(CGFloat)scale{
    [self initZoomingScrollView];
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:0.5 animations:^{
        
        [weakself zoomWithScale:scale];
    } completion:^(BOOL finished) {
        if (scale == 1) {
            [weakself clearSubViews];
        }
    }];
}

- (void)clearSubViews{
    [_zoomingScrollView removeFromSuperview];
    _zoomingScrollView = nil;
    _zoomingImageView = nil;
}

- (void)clearScale{
    [self clearSubViews];
    _totalScale = 1.0;
}

- (void)removeProgressView{
    [_progressView removeFromSuperview];
}


@end
