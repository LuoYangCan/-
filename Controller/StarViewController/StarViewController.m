//
//  StarViewController.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/28.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "StarViewController.h"
#import <Masonry.h>
#import "Tool.h"


@interface StarViewController ()

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    [self initUI];
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *starLabl = [[UILabel alloc]init];
    starLabl.text = @"我的收藏";
    [starLabl sizeToFit];
    [self.view addSubview:starLabl];
    [starLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(25);
    }];
    
    UIButton * backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(starLabl);
        make.width.and.height.mas_equalTo(20);
    }];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
