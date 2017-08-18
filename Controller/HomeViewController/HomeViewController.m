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

@interface HomeViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UISearchBar *topSearch ;
@property (nonatomic,strong) UITableView *baseTableView;
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
    self.view.backgroundColor = [UIColor grayColor];
    [self initSearchBar];
    [self initbaseTableView];
}

-(void)initbaseTableView{
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    self.baseTableView.delegate = self;
    [self.view addSubview:self.baseTableView];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.mas_equalTo(self.topSearch.mas_bottom).offset(5);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(void)initSearchBar{
    self.topSearch = [[UISearchBar alloc]init];
    UIImage *img = [Tool GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    [self.topSearch setBackgroundImage:img];
    self.topSearch.delegate = self;
    [self.view addSubview:self.topSearch];
    [self.topSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(15);
        make.left.and.right.equalTo(self.view);
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
#pragma mark - UITableViewDelegate&&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"123213";
    return cell;
}
@end
