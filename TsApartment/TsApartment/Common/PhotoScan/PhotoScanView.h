//
//  PhotoScanView.h
//  PhotoScan
//
//  Created by Dwt on 2017/1/6.
//  Copyright © 2017年 Dwt. All rights reserved.
//



#import <UIKit/UIKit.h>
@class PhotoScanView;
@protocol PhotoScanViewDelegate <NSObject>
@required
- (UIImage *)photoScanView:(PhotoScanView *)photoScanView originalImageAtIndex:(NSInteger)index;
@optional
- (NSURL *)photoScanView:(PhotoScanView *)photoScanView reloadLargeImageAtIndex:(NSInteger)index;
@end

@interface PhotoScanView : UIView

@property(nonatomic, strong)UIView *originalContainerView;
@property(nonatomic, assign)NSInteger currentIndex;
@property(nonatomic, assign)NSInteger imagesCount;
@property(nonatomic, weak)id<PhotoScanViewDelegate>delegate;

- (void)show;
@end
