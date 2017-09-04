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
-(void)setup{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self initSearchBar];
}
-(void)initTableView{
    _SearchTable = [[UITableView alloc]init];
    _SearchTable.delegate = self;
    _SearchTable.dataSource = self;
    [self.view addSubview:_SearchTable];
    [_SearchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(60);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}
-(void)initSearchBar{
    _SearchBar = [[UISearchBar alloc]init];
    _SearchBar.delegate = self;
    [self.view addSubview:_SearchBar];
    [_SearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(10);
        make.top.equalTo(self.view).mas_offset(17);
        make.right.equalTo(self.view).mas_offset(-65);
        make.bottom.equalTo(_SearchTable.mas_top).mas_offset(-5);
    }];
    [Tool getClearSearchBar:_SearchBar];
    [Tool setSearchBar:_SearchBar InsideBackgroundColor:RGBColor(219, 219, 219, 1)];
    _SearchBar.placeholder = @"请输入搜索内容\t\t\t\t\t\t";
    
    UIButton *searchLabl = [[UIButton alloc]init];
    [searchLabl setTitle:@"取消" forState:UIControlStateNormal];
    [searchLabl setTitleColor:RGBColor(211, 211, 211, 1) forState:UIControlStateNormal];
    [searchLabl addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchLabl];
    [searchLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_SearchBar.mas_right).mas_offset(8);
//        make.right.equalTo(self.view);
        make.top.equalTo(_SearchBar.mas_top);
        make.height.equalTo(_SearchBar.mas_height);
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


- (NSArray *)setSearchArray{
    NSArray * array = @[@{ @"title":@"汉族",
                           @"content_id":@"Han"},
                        @{ @"title":@"藏族",
                           @"content_id":@"Zang"},
                        @{ @"title":@"蒙古族",
                           @"content_id":@"Menggu"},
                        @{ @"title":@"回族",
                           @"content_id":@"Hui"},
                        @{ @"title":@"苗族",
                           @"content_id":@"Miao"},
                        @{ @"title":@"傈僳族",
                           @"content_id":@"Lisu"}

                        ];
    return [array copy];
}
#pragma mark - UITableViewDelegate&&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (!cell) {
        cell = [[SearchTableViewCell alloc]initWithArray:_searchArray andRow:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchStr = searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@",@"title",searchStr];
    if (_searchArray != nil) {
        [_searchArray removeAllObjects];
    }
    NSArray *array = [self setSearchArray];
    _searchArray = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:predicate]];
    NSLog(@"return    %@",_searchArray);
    [_SearchTable reloadData];
    
}
@end
