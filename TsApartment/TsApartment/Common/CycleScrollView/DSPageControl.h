//
//  DSPageControl.h
//  FineexFQXD2.0
//
//  Created by Dwt on 08/03/2017.
//  Copyright © 2017 Dwt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>

@interface DSPageControl : UIControl

@property (assign, nonatomic) NSInteger numberOfPages;
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIColor *currentPageIndicatorTintColor;
@property (strong, nonatomic) UIColor *pageIndicatorTintColor;

@property (assign, nonatomic) BOOL hidesForSinglePage;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;
@end
