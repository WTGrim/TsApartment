//
//  PageScrollViewDelegate.h
//  PageScrollView
//
//  Created by Dwt on 2017/1/23.
//  Copyright © 2017年 Dwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageContentView;
@class TitleView;
@class WTCollectionView;

@protocol ScrollPageViewChildVcDelegate <NSObject>
@optional


- (void)wt_viewWillAppearForIndex:(NSInteger)index;
- (void)wt_viewDidAppearForIndex:(NSInteger)index;
- (void)wt_viewWillDisappearForIndex:(NSInteger)index;
- (void)wt_viewDidDisappearForIndex:(NSInteger)index;

- (void)wt_viewDidLoadForIndex:(NSInteger)index;

@end


@protocol ScrollPageViewDelegate <NSObject>
/** 将要显示的子页面的总数 */
- (NSInteger)numberOfChildViewControllers;

/** 获取到将要显示的页面的控制器
 * -index : 对应的下标
 */
- (UIViewController<ScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index;

@optional


- (BOOL)scrollPageController:(UIViewController *)scrollPageController contentScrollView:(WTCollectionView *)scrollView shouldBeginPanGesture:(UIPanGestureRecognizer *)panGesture;

- (void)setUpTitleView:(TitleView *)titleView forIndex:(NSInteger)index;

/**
 *  页面将要出现
 *
 */
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index;
/**
 *  页面已经出现
 *
 */
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index;

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index;
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index;
/**
 *  页面添加到父视图时，在父视图中显示的位置
 */
- (CGRect)frameOfChildControllerForContainer:(UIView *)containerView;

@end
