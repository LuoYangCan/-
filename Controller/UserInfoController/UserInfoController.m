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
    _baseScroll = [[UIScrollView alloc]init];
    _baseScroll.delegate = self;
    _baseScroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+40);
    _baseScroll.backgroundColor = RGBColor(235, 235, 235, 1);
    _baseScroll.showsVerticalScrollIndicator = NO;
    _baseScroll.contentOffset = CGPointMake(self.view.frame.size.width,0);
    [self.view addSubview:_baseScroll];
    [_baseScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.and.bottom.equalTo(self.view);
    }];
}




//顶部
-(void)initTop{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor whiteColor];
    [_baseScroll addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_baseScroll).mas_offset(60);
        make.left.and.right.equalTo(_baseScroll);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(_baseScroll).mas_offset(-480);
    }];
}


//中间
-(void)initMid{
    _midView = [[UIView alloc]init];
    _midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_midView];
    [_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).mas_offset(100);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.view.mas_width);
    }];
    
    
    UILabel *collectionlbl = [[UILabel alloc]init];
    [collectionlbl setText:@"我的收藏"];
    [_midView addSubview:collectionlbl];
    [collectionlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_midView).mas_offset(20);
        make.top.equalTo(_midView).mas_offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
}


//底部
-(void)initBottom{
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_midView.mas_bottom).mas_offset(80);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(50);
    }];
    UILabel *logoutlabl = [[UILabel alloc]init];
    [logoutlabl setText:@"注销"];
    [logoutlabl setTextColor:[UIColor redColor]];
    [_bottomView addSubview:logoutlabl];
    [logoutlabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView.mas_centerX).mas_offset(15);
        make.top.equalTo(_bottomView).mas_offset(15);
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
