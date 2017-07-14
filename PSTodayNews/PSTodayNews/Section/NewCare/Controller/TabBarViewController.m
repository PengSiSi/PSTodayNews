//
//  TabBarViewController.m
//  PSTodayNews
//
//  Created by 思 彭 on 2017/7/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"思思";
    UIViewController *vc = [[UIViewController alloc]init];
    vc.tabBarItem.title = @"新闻";
    vc.navigationItem.title = @"看新闻";
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem.image = [UIImage imageNamed:@"home_tabbar_press_22x22_"];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
    nav1.navigationBarHidden = YES;
    vc.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"视频";
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.tabBarItem.image = [UIImage imageNamed:@"mine_tabbar_press_22x22_"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc1];
    nav2.navigationBarHidden = YES;
    self.viewControllers = @[nav1, nav2];
}

@end
