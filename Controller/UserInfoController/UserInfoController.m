//
//  UserInfoController.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/8/29.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "UserInfoController.h"
#import <Masonry.h>
#import "Tool.h"
#import "StarViewController.h"

@interface UserInfoController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *topView;        /**< 顶部  */
@property (nonatomic,strong) UIView *midView;        /**< 中间  */
@property (nonatomic,strong) UIView *bottomView;        /**< 底部  */
@property (nonatomic,strong) UIScrollView *baseScroll;        /**< 背景  */
@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setup{
    [self initBackground];
    [self initTop];
    [self initMid];
    [self initBottom];
}

//背景scroll
-(void)initBackground{
    self.baseScroll = [[UIScrollView alloc]init];
    self.baseScroll.delegate = self;
    self.baseScroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+40);
    self.baseScroll.backgroundColor = RGBColor(235, 235, 235, 1);
    self.baseScroll.showsVerticalScrollIndicator = NO;
    self.baseScroll.contentOffset = CGPointMake(self.view.frame.size.width,0);
    [self.view addSubview:self.baseScroll];
    [self.baseScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.and.bottom.equalTo(self.view);
    }];
}




//顶部
-(void)initTop{
    self.topView = [[UIView alloc]init];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.baseScroll addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScroll).mas_offset(45);
        make.left.and.right.equalTo(self.baseScroll);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(self.baseScroll).mas_offset(-480);
    }];
    
    UILabel *userLbl = [[UILabel alloc]init];
    [userLbl setText:@"Reus97"];
    [self.topView addSubview:userLbl];
    [userLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.mas_offset(130);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *headImgV = [[UIImageView alloc]init];
    headImgV.image = [UIImage imageNamed:@"interesting"];
//    headImgV.backgroundColor = RGBColor(190, 190, 190, 1);
    headImgV.layer.cornerRadius = 15.0f;
    headImgV.layer.masksToBounds = YES;
    [self.topView addSubview:headImgV];
    [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.mas_offset(30);
        make.top.equalTo(self.topView).with.mas_offset(15);
        make.width.and.height.mas_equalTo(70);
    }];
}


//中间
-(void)initMid{
    self.midView = [[UIView alloc]init];
    self.midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).mas_offset(100);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.view.mas_width);
    }];
    
    
    UILabel *collectionlbl = [[UILabel alloc]init];
    [collectionlbl setText:@"我的收藏"];
    [self.midView addSubview:collectionlbl];
    [collectionlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midView).mas_offset(20);
        make.top.equalTo(self.midView).mas_offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toStarVC)];
    [self.midView addGestureRecognizer:touch];
}
-(void)toStarVC{
    StarViewController *starVC = [[StarViewController alloc]init];
    [self presentViewController:starVC animated:YES completion:nil];
}

//底部
-(void)initBottom{
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midView.mas_bottom).mas_offset(222);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(50);
    }];
    UILabel *logoutlabl = [[UILabel alloc]init];
    [logoutlabl setText:@"注销"];
    [logoutlabl setTextColor:[UIColor redColor]];
    [self.bottomView addSubview:logoutlabl];
    [logoutlabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView.mas_centerX).mas_offset(15);
        make.top.equalTo(self.bottomView).mas_offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
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
