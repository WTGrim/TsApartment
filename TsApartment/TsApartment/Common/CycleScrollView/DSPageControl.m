//
//  DSPageControl.m
//  FineexFQXD2.0
//
//  Created by Dwt on 08/03/2017.
//  Copyright © 2017 Dwt. All rights reserved.
//

#import "DSPageControl.h"

static const CGFloat kItemWidth = 15.0f;
static const CGFloat kGapWidth = 8.0f;
static const CGFloat kItemHeight = 2.0f;

@interface DSPageControl()
@property (strong, nonatomic) NSMutableArray *pagesArray;
@property (strong, nonatomic) UIImage *currentPageImage;
@property (strong, nonatomic) UIImage *pageImage;
@property (strong, nonatomic) UIImageView *currentImageView;
@property (strong, nonatomic) UIView *pageBackView;
@end

@implementation DSPageControl

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.currentPageIndicatorTintColor = RGB(14, 152, 223);
        self.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _currentPageImage = [self drawPageImageWithColor:_currentPageIndicatorTintColor];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageImage = [self drawPageImageWithColor:_pageIndicatorTintColor];
}

- (UIImage *)drawPageImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, kItemWidth, kItemHeight);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount {
    return CGSizeMake(pageCount * kItemWidth + ( pageCount - 1 ) * kGapWidth, kItemWidth);
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self createPageControllUI];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    [self currentPageMoved];
}

- (void)createPageControllUI {
    _pageBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _numberOfPages * (kItemWidth + kGapWidth) - kGapWidth, kItemHeight)];
    _pageBackView.center = self.center;
    [self addSubview:_pageBackView];
    
    for (int i = 0; i < _numberOfPages; i++) {
        UIImageView *pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (kItemWidth + kGapWidth), 0, kItemWidth, kItemHeight)];
        pageImageView.image = [_pageImage copy];
        pageImageView.layer.cornerRadius = kItemHeight * 0.5f;
        pageImageView.clipsToBounds = YES;
        [_pageBackView addSubview:pageImageView];
        [_pagesArray addObject:pageImageView];
    }
    
    _currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemHeight)];
    _currentImageView.layer.cornerRadius = kItemHeight * 0.5;
    _currentImageView.clipsToBounds = YES;
    _currentImageView.image = _currentPageImage;
    [_pageBackView addSubview:_currentImageView];
}

- (void)currentPageMoved {
    [UIView animateWithDuration:0.1 animations:^{
        _currentImageView.frame = CGRectMake(_currentPage * (kItemWidth + kGapWidth), 0, kItemWidth, kItemHeight);
    }];
}

- (void)drawRect:(CGRect)rect {
    _pageBackView.center = CGPointMake(self.center.x, kItemHeight * 0.5);
}

@end
