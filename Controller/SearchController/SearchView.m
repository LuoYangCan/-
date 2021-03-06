//
//  SearchView.m
//  InternationalEtiquette
//
//  Created by 孤岛 on 2017/8/24.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "SearchView.h"
#import <Masonry.h>
#import "Tool.h"
#import "SearchTableViewCell.h"
#import "EtiquetteInfoController.h"
#import "LocalData.h"

@interface SearchView ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *SearchTable;        /**< 搜索列表  */
@property (nonatomic,strong) UISearchBar *SearchBar;        /**< 搜索框    */
@property (nonatomic,strong) NSMutableArray *searchArray;        /**< 搜索结果  */
@end

@implementation SearchView
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [[NSMutableArray alloc]init];
    }
    return _searchArray;
}
-(void)setup{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self initSearchBar];
}
-(void)initTableView{
    self.SearchTable = [[UITableView alloc]init];
    self.SearchTable.rowHeight = 40;
    self.SearchTable.delegate = self;
    self.SearchTable.dataSource = self;
    [self.view addSubview:self.SearchTable];
    @weakify(self);
    [self.SearchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        if (@available (iOS 11, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(60);
        }else{
        make.top.equalTo(self.view).mas_offset(60);
        }
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}
-(void)initSearchBar{
    self.SearchBar = [[UISearchBar alloc]init];
    self.SearchBar.delegate = self;
    [self.view addSubview:self.SearchBar];
    @weakify(self)
    [self.SearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (@available (iOS 11, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(20);
        }else{
            make.top.equalTo(self.view).mas_offset(20);
        }
        make.left.equalTo(self.view).mas_offset(10);
        make.right.equalTo(self.view).mas_offset(-65);
        make.bottom.equalTo(self.SearchTable.mas_top).mas_offset(-10);
    }];
    [Tool getClearSearchBar:self.SearchBar];
    [Tool setSearchBar:self.SearchBar InsideBackgroundColor:RGBColor(219, 219, 219, 1)];
    self.SearchBar.placeholder = @"请输入搜索内容\t\t\t\t\t\t";
    
    UIButton *searchLabl = [[UIButton alloc]init];
    [searchLabl setTitle:@"取消" forState:UIControlStateNormal];
    [searchLabl setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [searchLabl addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchLabl];
    [searchLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.SearchBar.mas_right).mas_offset(8);
//        make.right.equalTo(self.view);
        make.top.equalTo(self.SearchBar.mas_top);
        make.height.equalTo(self.SearchBar.mas_height);
    }];
    
}

-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
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
    return self.searchArray.count;
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (!cell) {
        cell = [[SearchTableViewCell alloc]initWithArray:self.searchArray andRow:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.searchArray[indexPath.row];
    NSString *contentid = dic[@"content_id"];
    EtiquetteInfoController *VC =[[EtiquetteInfoController alloc]initWithContent_Id:contentid];
    [self presentViewController:VC animated:YES completion:^{
        NSLog(@"%@\n\n\n",contentid);
    }];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchStr = searchBar.text;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@",@"title",searchStr];
//    if (_searchArray != nil) {
//        [_searchArray removeAllObjects];
//    }
//    NSArray *array = [self setSearchArray];
//    _searchArray = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:predicate]];
//    if ([_searchArray isEqualToArray:@[]]) {
//        [_searchArray addObject:@{@"title":@"没有相关信息",
//                                    @"content_id":@"nil"}];
//    }
    @weakify(self);
    [[LocalData getInstance]getSearchMessagewithArray:self.searchArray Searchstr:searchStr completion:^(NSError *error, id responseArray) {
        @strongify(self);
        self.searchArray = responseArray;
        [self.SearchTable reloadData];
    }];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
        NSString *searchStr = searchText;
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@",@"title",searchStr];
//        if (_searchArray != nil) {
//            [_searchArray removeAllObjects];
//        }
//        NSArray *array = [self setSearchArray];
//        _searchArray = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:predicate]];
//        if ([_searchArray isEqualToArray:@[]]) {
//            [_searchArray addObject:@{@"title":@"没有相关信息",
//                                      @"content_id":@"nil"}];
//        }
    @weakify(self);
    [[LocalData getInstance]getSearchMessagewithArray:self.searchArray Searchstr:searchStr completion:^(NSError *error, id responseArray) {
        @strongify(self);
        self.searchArray = [responseArray mutableCopy];
        [self.SearchTable reloadData];
    }];

}
@end
