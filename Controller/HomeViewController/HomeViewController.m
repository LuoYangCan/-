//
//  HomeViewController.m
//  InternationalEtiquette
//
//  Created by 孤岛 on 2017/8/18.
//  Copyright © 2017年 孤岛. All rights reserved.
//
#import <Masonry.h>
#import "HomeViewController.h"
#import "Tool.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong) UISearchBar *topSearch ;
@property (nonatomic,strong) UITableView *baseTableView;
@property (nonatomic,strong) UIView *TopView;        /**< 顶部View  */
@property (nonatomic,assign) CGFloat marginTop;        /**< contentInset.top  */

@end

@implementation HomeViewController

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
    [self initBaseUI];
}


-(void)initBaseUI{
    self.view.backgroundColor = [UIColor blueColor];
  //  [self initSearchBar];
    [self initbaseTableView];
    [self initTopView];
}

//-(void)initSearchBar{
//    self.topSearch = [[UISearchBar alloc]init];
//    UIImage *img = [Tool GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
//    [self.topSearch setBackgroundImage:img];
//    self.topSearch.delegate = self;
//    [self.view addSubview:self.topSearch];
//    [self.topSearch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view.mas_top).mas_offset(60);
//        make.left.and.right.equalTo(self.view);
//    }];
//}
-(void)initTopView{
    self.TopView = [[UIView alloc]init];
    self.TopView.backgroundColor = [UIColor grayColor];
    [self.baseTableView addSubview:self.TopView];
    [self.TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_top).mas_offset(200);
       // make.bottom.equalTo(self.view.mas_top).mas_offset(200);
    }];
    self.TopView.contentMode = UIViewContentModeScaleToFill;
    self.TopView.clipsToBounds = YES;
}


-(void)initbaseTableView{
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:self.baseTableView];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(self.view);
        //make.top.equalTo(self.view).mas_offset(200);
        //make.top.equalTo(self.TopView.mas_bottom);
    }];
        [self.baseTableView setContentOffset:CGPointMake(0, -200) animated:NO];
     self.baseTableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate&&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       HomeTableViewCell *cell = [[HomeTableViewCell alloc]initWithDic:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.marginTop != scrollView.contentInset.top) {
        self.marginTop =scrollView.contentInset.top;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;
//    if (newoffsetY >=140) {
//        newoffsetY = 140;
//    }
    if (scrollView == self.baseTableView) {
        if (newoffsetY >=0 &&newoffsetY <140) {
            [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.bottom.equalTo(self.view.mas_top).mas_offset(200-newoffsetY);
            }];

        }else if (newoffsetY >=140){
            [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_top).mas_offset(60);
            }];
        }else{
            [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_top).mas_offset(200);
            }];
        }
    }
}
@end
