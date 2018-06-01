//
//  BootViewControllerManager.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BootViewControllerManager.h"
#import "HomeViewController.h"
#import "ServiceViewController.h"
#import "ProfileViewController.h"


@implementation BootViewControllerManager

+ (UITabBarController *)initBootController{
    
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    ServiceViewController *serviceVc = [[ServiceViewController alloc]init];
    ProfileViewController *profileVc = [[ProfileViewController alloc]init];
    
    homeVc.title = @"首页";
    serviceVc.title = @"服务";
    profileVc.title = @"我";
    homeVc.tabBarItem.title = @"首页";
    serviceVc.tabBarItem.title = @"服务";
    profileVc.tabBarItem.title = @"我";
    
    homeVc.backItemHidden = true;
    serviceVc.backItemHidden = true;
    profileVc.backItemHidden = true;
    
    homeVc.tabBarItem.image = [UIImage imageNamed:@""];
    homeVc.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    serviceVc.tabBarItem.image = [UIImage imageNamed:@""];
    serviceVc.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    profileVc.tabBarItem.image = [UIImage imageNamed:@""];
    profileVc.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVc];
    UINavigationController *serviceNav = [[UINavigationController alloc]initWithRootViewController:serviceVc];
    UINavigationController *profileNav = [[UINavigationController alloc]initWithRootViewController:profileVc];
    
    NSArray *items = @[homeNav, serviceNav, profileNav];
    
    UITabBarController *bootTabBarVc = [[UITabBarController alloc]init];
    bootTabBarVc.tabBar.tintColor = [UIColor whiteColor];
    bootTabBarVc.tabBar.translucent = false;
    bootTabBarVc.viewControllers = items;
    bootTabBarVc.selectedIndex = 0;
    return bootTabBarVc;
}

@end
