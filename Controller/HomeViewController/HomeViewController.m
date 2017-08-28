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
#import "SearchView.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong) UISearchBar *topSearch ;
@property (nonatomic,strong) UITableView *baseTableView;
@property (nonatomic,strong) UIView *TopView;        /**< 顶部View  */
@property (nonatomic,assign) CGFloat marginTop;        /**< contentInset.top  */
@property (nonatomic,strong) UIView *SearchView;        /**< 搜索框  */
@property (nonatomic,assign) CGFloat Offset;        /**< 滑动  */
@property (nonatomic,strong) UILabel *searchlbl;        /**< 搜索文字  */
@property (nonatomic,strong) UIRefreshControl *RefreshControl;        /**< 下拉刷新  */
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
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    
    self.RefreshControl = [[UIRefreshControl alloc]init];
    [self.RefreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.RefreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.baseTableView addSubview:self.RefreshControl];
}






-(void)initTopView{
    
    
    self.TopView = [[UIView alloc]init];
    self.TopView.backgroundColor =RGBColor(118, 238, 104, 1);
    [self.baseTableView addSubview:self.TopView];
    [self.TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        //make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_top).mas_offset(200);
       // make.bottom.mas_equalTo(self.baseTableView.mas_top);
    }];
    self.TopView.contentMode = UIViewContentModeScaleToFill;
    
    
    
    self.SearchView = [[UIView alloc]init];
    self.SearchView.backgroundColor = RGBColor(192, 255, 62, 1);
    [self.TopView addSubview:self.SearchView];
    [self.SearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TopView).mas_offset(10);
        make.top.equalTo(self.TopView).mas_offset(18);
        make.right.equalTo(self.TopView).mas_offset(-10);
        make.bottom.equalTo(self.TopView.mas_bottom).mas_offset(-8);
    }];
    self.SearchView.contentMode = UIViewContentModeScaleToFill;
    self.SearchView.layer.cornerRadius = 15.0f;
    self.SearchView.layer.masksToBounds= YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PushtoSearch)];
    [self.SearchView addGestureRecognizer:tap];
    
    self.searchlbl= [[UILabel alloc]init];
    [self.searchlbl setText:@"请输入搜索内容"];
    [self.SearchView addSubview:self.searchlbl];
    self.searchlbl.font = [UIFont systemFontOfSize:14.8];
    [self.searchlbl setTextColor:[UIColor grayColor]];
    [self.searchlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.SearchView).mas_offset(19);
        make.top.equalTo(self.SearchView).mas_offset(9);
    }];
    self.searchlbl.contentMode = UIViewContentModeScaleToFill;

    
    
    
}
-(void)PushtoSearch{
    SearchView *searchVC = [[SearchView alloc]init];
    [self presentViewController:searchVC animated:NO completion:nil];
}


-(void)refreshData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.RefreshControl endRefreshing];
    });

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
    self.Offset = newoffsetY;
    if (newoffsetY >=140) {
        newoffsetY = 140;
    }else if (newoffsetY <= 0){
        newoffsetY = 0;
    }
    if (scrollView == self.baseTableView) {
        if (newoffsetY >=0 &&newoffsetY <=140) {
            [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.bottom.equalTo(self.view.mas_top).mas_offset(200-newoffsetY);
            }];
//            NSLog(@"%f",offsetY);
//            if (scrollView.isScrollEnabled && (newoffsetY >20 && newoffsetY <140)) {
//                [UIView animateWithDuration:0.7 animations:^{
//                    [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.bottom.equalTo(self.view.mas_top).mas_offset(60);
//                    }];
//                    [self.TopView.superview layoutIfNeeded];
//                }];
//            }
        }

    }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.baseTableView){
        if ((self.Offset >20 && self.Offset <140)) {
//            [self.TopView.superview layoutIfNeeded];
                            [UIView animateWithDuration:0.7 animations:^{
//                                [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
//                                    make.bottom.equalTo(self.view.mas_top).mas_offset(60);
//                                }];
                            scrollView.contentOffset= CGPointMake(0, -60);
                                [self.TopView.superview layoutIfNeeded];
                            }];
                        }

        
        }
    }




- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
}
@end
