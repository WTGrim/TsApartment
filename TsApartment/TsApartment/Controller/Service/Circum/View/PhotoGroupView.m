//
//  PhotoGroupView.m
//  FineexFQXD2.0
//
//  Created by Dwt on 2017/3/22.
//  Copyright © 2017年 FineEx. All rights reserved.
//

#import "PhotoGroupView.h"
#import "UIImageView+EasyInOut.h"
#import "PhotoScanView.h"

#define headerW 40
#define margin 3
@interface PhotoGroupView ()<PhotoScanViewDelegate>

@property(nonatomic, strong)NSArray *imageViewsArray;
@property(nonatomic, assign)CGFloat height;
@end

@implementation PhotoGroupView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray = [temp copy];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    
    for (long i = _imageUrlArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_imageUrlArray.count == 0) {
        self.height = 0;
        if (_photoGroupHeightBlock) {
            _photoGroupHeightBlock(self.height);
        }
        return;
    }
    
    CGFloat itemW = [self getWidthWithUrlArray:_imageUrlArray];
    CGFloat itemH = 0;
    
    if (_imageUrlArray.count == 1) {
        itemH = (SCREEN_WIDTH - headerW - 65) / 2;
    }else{
        itemH = itemW;
    }
    
    long colCount = [self getCountWithUrlArray:_imageUrlArray];
    
    [_imageUrlArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        long colIndex = idx % colCount;
        long rowIndex = idx / colCount;
        
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        [imageView wt_setImageWithURL:obj placeholderImage:nil completed:nil];
        imageView.frame = CGRectMake(colIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    int colNum = ceilf(_imageUrlArray.count * 1.0 / colCount);
    
    CGFloat h = colNum * itemH + (colNum - 1) * margin;
    self.height = h;
    
    if (_photoGroupHeightBlock) {
        _photoGroupHeightBlock(h);
    }
}


- (CGFloat)getWidthWithUrlArray:(NSArray *)imageUrlArray{
    
    if (imageUrlArray.count == 0){
        return 0;
    }
    if (imageUrlArray.count == 1) {
        return SCREEN_WIDTH - headerW - 65;
    }
    
    if (imageUrlArray.count == 2 || imageUrlArray.count == 4) {
        return (SCREEN_WIDTH - headerW - 65 - margin) / 2;
    }else{
        return (SCREEN_WIDTH - headerW - 65 - 2 * margin) / 3;
    }
    
}

- (CGFloat)getCountWithUrlArray:(NSArray *)array{
    
    if (array.count <= 3) {
        return array.count;
    }else if(array.count <= 4){
        return 2;
    }else{
        return 3;
    }
}

- (CGFloat)totalHeight{
    
    return self.height;
}

#pragma mark - 点击图片
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    UIView *tapImageView = tap.view;
    PhotoScanView *scanView = [[PhotoScanView alloc]init];
    scanView.currentIndex = tapImageView.tag;
    scanView.imagesCount = self.imageUrlArray.count;
    scanView.originalContainerView = self;
    scanView.delegate = self;
    [scanView show];
}

#pragma mark - PhotoScanViewDelegate
- (NSURL *)photoScanView:(PhotoScanView *)photoScanView reloadLargeImageAtIndex:(NSInteger)index{
    return [NSURL URLWithString:self.imageUrlArray[index]];
}

- (UIImage *)photoScanView:(PhotoScanView *)photoScanView originalImageAtIndex:(NSInteger)index{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}


@end
