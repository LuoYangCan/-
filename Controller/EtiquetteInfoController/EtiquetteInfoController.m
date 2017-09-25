//
//  EtiquetteInfoController.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/6.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "EtiquetteInfoController.h"
#import "Tool.h"
#import <Masonry.h>
#import "LocalData.h"

@interface EtiquetteInfoController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UILabel *titleLabl;        /**< 标题  */
@property (nonatomic,strong) UILabel *contentLabl;        /**< 内容  */
@property (nonatomic,strong) UIScrollView *backgroundView;        /**< 背景  */
@property (nonatomic,strong) NSString *contentid;        /**< 代号  */
@end

@implementation EtiquetteInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

-(void)setup{
    self.view.backgroundColor = [UIColor clearColor];
    [self initBaseScrollView];
    [self initUI];
}

-(instancetype)initWithContent_Id:(NSString *)content_id{
    if (self = [super init]) {
        self.contentid = content_id;
    }
    return self;

}
-(void)setTitleandContentwithBlock:(void(^) (NSString * title, NSMutableAttributedString *AttrStr ))block{
//    NSArray *array = [self setDetailDic];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@",@"content_id",_contentid];
//    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:predicate]];
//    NSDictionary *dic = mutableArray[0];
   __block NSDictionary *dic = [NSDictionary dictionary];
    [[LocalData getInstance]getArticalwithContent_id:_contentid completion:^(id responseArray, NSError *error) {
        if (!error) {
            dic = responseArray;
        }
    }];
    NSString *str = dic[@"content"];
    //设置内容
    NSMutableAttributedString *AttrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [AttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 0)];
    //段落
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    //行间距
    para.lineSpacing = 7;
    para.paragraphSpacing = 17;
    para.alignment = NSTextAlignmentLeft;
    [AttrStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, [dic[@"content"] length])];
    
    //设置标题
    NSString *title = dic[@"title"];
    if (block) {
        block(title, AttrStr);
    }
}
-(void)initUI{
    _titleLabl = [[UILabel alloc]init];
    _contentLabl = [[UILabel alloc]init];
    @weakify(self);
    [self setTitleandContentwithBlock:^(NSString *title, NSMutableAttributedString *AttrStr) {
        @strongify(self);
        self.titleLabl.text = title;
        self.titleLabl.font = [UIFont systemFontOfSize:28];
        [self.titleLabl sizeToFit];
        self.contentLabl.numberOfLines = 0;
        self.contentLabl.attributedText =AttrStr;
        [self.contentLabl sizeToFit];
        UIButton *button = [[UIButton alloc]init];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.backgroundView addSubview:self.titleLabl];
        [self.backgroundView addSubview:self.contentLabl];
        [self.titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView).mas_offset(50);
            make.left.equalTo(self.backgroundView).mas_offset(40);
//            make.width.mas_equalTo(200);
//            make.height.mas_equalTo(30);
//            make.bottom.equalTo(self.backgroundView).offset(content_height + title_height + 70);
        }];
        [self.contentLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabl.mas_bottom).mas_offset(30);
            make.left.equalTo(self.view).mas_offset(45);
            make.bottom.equalTo(self.backgroundView).mas_offset(-70);
            make.right.equalTo(self.view).mas_offset(-20);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(self.view);
            make.right.equalTo(self.contentLabl.mas_left);
            make.height.mas_equalTo(70);
        }];
    }];
    
    
    
}


-(void)back{
//    @weakify(self)
//    [UIView animateWithDuration:0.7 animations:^{
//     @strongify(self)
//        [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view.mas_right);
//        }];
//    } completion:^(BOOL finished) {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    }];
     [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)initBaseScrollView{
    self.backgroundView = [[UIScrollView alloc]init];
    self.backgroundView.backgroundColor = [UIColor orangeColor];
    self.backgroundView.delegate = self;
//    self.backgroundView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.and.right.equalTo(self.view);
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
