//
//  PhotoScanImageView.h
//  PhotoScan
//
//  Created by Dwt on 2017/1/6.
//  Copyright © 2017年 Dwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScanImageView : UIImageView

@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign, readonly)BOOL isScale;
@property(nonatomic, assign)BOOL hasLoaded;

- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;
- (void)doubleTapToZoom:(CGFloat)scale;
- (void)clearScale;
- (void)clearSubViews;
@end
