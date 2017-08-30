//
//  BaseTabController.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/8/29.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "BaseTabController.h"
#import "HomeViewController.h"
#import "UserInfoController.h"
#import "Tool.h"
@interface BaseTabController ()

@end

@implementation BaseTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbarController];
    // Do any additional setup after loading the view.
}


-(void)initTabbarController{
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithCapacity:[self setVCArray].count];
    for (NSDictionary *dic in [self setVCArray]) {
        Class vcClass = NSClassFromString(dic[@"viewcontroller"]);
        UIViewController *vc = [[vcClass alloc]init];
        vc.title = dic[@"name"];
        NSString *imgname = dic[@"icon"];
        UIImage *img = [UIImage imageNamed:imgname];
        [vc.tabBarItem setImage:img];
        [viewControllers addObject:vc];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = 0;
    [[UITabBar appearance]setBarTintColor:RGBColor(195, 255, 62, 1)];
    [UITabBar appearance].translucent = NO;
    
}




-(NSArray *)setVCArray{
    NSArray *array = @[@{ @"name":@"首页",
                          @"icon":@"home",
                          @"viewcontroller":NSStringFromClass([HomeViewController class])
                           },
                       @{ @"name":@"个人",
                          @"icon":@"my",
                          @"viewcontroller":NSStringFromClass([UserInfoController class])
                           }
                       ];
    return [array copy];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
