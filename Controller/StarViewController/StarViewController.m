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


@interface StarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *starTableview;        /**< 收藏列表  */
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
   [self initTableView];
    [self initUI];
}

-(UITableView *)starTableview{
    if (!_starTableview) {
        _starTableview = [[UITableView alloc]init];
    }
    return _starTableview;
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *starLabl = [[UILabel alloc]init];
    starLabl.text = @"我的收藏";
    [starLabl sizeToFit];
    [self.view addSubview:starLabl];
    [starLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(28);
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


-(void)initTableView{
    self.starTableview.delegate = self;
    self.starTableview.dataSource = self;
    self.starTableview.rowHeight = 60;
    [self.view addSubview:self.starTableview];
    [self.starTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).with.mas_offset(40);
    }];
}
#pragma mark - UITableViewDelegate&&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"starCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
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
