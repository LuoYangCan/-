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
#import "EtiquetteInfoController.h"
#import "LocalData.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong) UISearchBar *topSearch ;
@property (nonatomic,strong) UITableView *baseTableView;
@property (nonatomic,strong) UIView *TopView;        /**< 顶部View  */
@property (nonatomic,assign) CGFloat marginTop;        /**< contentInset.top  */
@property (nonatomic,strong) UIView *SearchView;        /**< 搜索框  */
@property (nonatomic,assign) CGFloat Offset;        /**< 滑动  */
@property (nonatomic,strong) UILabel *searchlbl;        /**< 搜索文字  */
@property (nonatomic,strong) UIRefreshControl *RefreshControl;        /**< 下拉刷新  */
@property (nonatomic,strong) NSMutableArray *dataArray;        /**< 数据数组  */
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        __block NSArray *arr = [NSArray array];
        [[LocalData getInstance]getDataArrayWithcompletion:^(NSArray *responseArray) {
            arr = responseArray;
        }];
        _dataArray = [[NSMutableArray alloc]initWithArray:arr];
    }
    return _dataArray;
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


-(void)initbaseTableView{
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor whiteColor];
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
//    [self.RefreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.RefreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.baseTableView addSubview:self.RefreshControl];
}






-(void)initTopView{
    
    
    self.TopView = [[UIView alloc]init];
    self.TopView.backgroundColor =RGBColor(235, 235, 235, 1);
    [self.baseTableView addSubview:self.TopView];
    [self.TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        //make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_top).mas_offset(200);
       // make.bottom.mas_equalTo(self.baseTableView.mas_top);
    }];
    self.TopView.contentMode = UIViewContentModeScaleToFill;
    
    
    
    self.SearchView = [[UIView alloc]init];
    self.SearchView.backgroundColor = RGBColor(190, 190, 190, 1);
    [self.TopView addSubview:self.SearchView];
    [self.SearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TopView).mas_offset(10);
        make.top.equalTo(self.TopView).mas_offset(18);
        make.right.equalTo(self.TopView).mas_offset(-10);
        make.bottom.equalTo(self.TopView.mas_bottom).mas_offset(-10);
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

//
//-(void)refreshData{
//    [self didUpdateDataWithcompletionHandler:^(BOOL isFinished) {
//        if (isFinished) {
//            [self.RefreshControl endRefreshing];
//        }
//    }];
//    
//
//}

-(void)didUpdateDataWithcompletionHandler:(void (^) (BOOL isFinished) )completionblock{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"刷新啦");
        if (completionblock) {
            completionblock(YES);
        }
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArray[indexPath.row];
    HomeTableViewCell *cell = [[HomeTableViewCell alloc]initWithDic:dic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *content_id = dic[@"content_id"];
    EtiquetteInfoController *etiVC = [[EtiquetteInfoController alloc]initWithContent_Id:content_id];
    [self presentViewController:etiVC animated:YES completion:nil];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.marginTop != scrollView.contentInset.top) {
        self.marginTop =scrollView.contentInset.top;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat newoffsetY = offsetY + self.marginTop;
    self.Offset = newoffsetY;
    CGFloat scrollOffset = newoffsetY;
    if (scrollOffset >=140) {
        scrollOffset = 140;
    }else if (scrollOffset <= 0){
        scrollOffset = 0;
    }
    if (scrollView == self.baseTableView) {
        if (scrollOffset >=0 &&scrollOffset <=140) {
            [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.bottom.equalTo(self.view.mas_top).mas_offset(200-scrollOffset);
            }];
//            NSLog(@"%f",newoffsetY);
//            NSLog(@"%f",scrollView.contentOffset.y);
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
        if (!decelerate) {
            if ((self.Offset >20 && self.Offset <140)) {
                [self.TopView.superview layoutIfNeeded];
                [UIView animateWithDuration:0.7 animations:^{
                    //                                [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                    //                                    make.bottom.equalTo(self.view.mas_top).mas_offset(60);
                    //                                }];
                    scrollView.contentOffset= CGPointMake(0, -60);
                    [self.TopView.superview layoutIfNeeded];
                }completion:^(BOOL finished) {
                    //                                scrollView.scrollEnabled = YES;
                }];
            }
        }

        
        
        if (scrollView.contentOffset.y <= -320) {
            [self.RefreshControl beginRefreshing];
            [self didUpdateDataWithcompletionHandler:^(BOOL isFinished) {
                if(isFinished){
                    [self.RefreshControl endRefreshing];
                }
            }];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.baseTableView){

        if ((self.Offset >20 && self.Offset <140)) {
            NSLog(@"%f",self.Offset);
            //            scrollView.scrollEnabled = NO;
            [self.TopView.superview layoutIfNeeded];
            [UIView animateWithDuration:0.7 animations:^{
                //                                [self.TopView mas_updateConstraints:^(MASConstraintMaker *make) {
                //                                    make.bottom.equalTo(self.view.mas_top).mas_offset(60);
                //                                }];
                scrollView.contentOffset= CGPointMake(0, -60);
                [self.TopView.superview layoutIfNeeded];
            }completion:^(BOOL finished) {
                //                                scrollView.scrollEnabled = YES;
            }];
        }
        
        
//        if (scrollView.contentOffset.y <= -320) {
//            [self.RefreshControl beginRefreshing];
//            self.RefreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.RefreshControl endRefreshing];
//            });
//        }
    }
}



//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
//    
//}
@end
