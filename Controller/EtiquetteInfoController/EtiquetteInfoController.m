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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initBaseScrollView];
    [self initUI];
}
-(NSArray *)setDetailDic{
    NSArray *array = @[@{   @"content_id":@"Han",
                            @"title":@"汉族的礼仪文化",
                            @"content":@""
                           },
                       @{   @"content_id":@"Menggu",
                            @"title":@"蒙古族的礼仪文化",
                            @"content":@"蒙古族是一个历史悠久而又富有传奇色彩的民族，过着“逐水草而迁徙”的游牧生活。中国的大部分草原都留下了蒙古族牧民的足迹，因而被誉为“草原骄子”。每年七、八月牲畜肥壮的季节举行“那达慕”大会是蒙古族历史悠久的传统节日，这是人们为了庆祝丰收而举行的文体娱乐大会。\n“那达慕”大会上有惊险动人的赛马、摔跤，令人赞赏的射箭，有争强斗胜的棋艺，有引人入胜的歌舞，显示出草原民族独有的特色。蒙古族被称为草原上的民族，主要聚居于内蒙古自治区和新疆、青海、甘肃、黑龙江、吉林、辽宁等省（区）的蒙古族自治州、县，余者散居于宁夏、河北、四川、云南、北京等省、市、区。\n婚姻禁忌：古代禁忌为氏族内部不通婚，男子只能娶他部落女子。嫁到该氏族的妇女，从此不可脱离该氏族。若夫死，只能改嫁丈夫的近亲。旧时，新郎娶亲时，须挎佩刀与弓箭。到女家，摘下刀箭放于马窗西侧，走时再挎。娶亲归来仍将其放于马窗西侧，3天人禁触动。3天后，新娘将其收起，作为吉祥物和镇器永久保存。该族忌讳离婚，视其为最不道德、不吉祥的事。产忌：产妇生产期，忌外人入内，忌门均挂有标志：生男，挂弓箭，以示男儿之勇；生女，挂红布条，以示女儿之巧。云南蒙古族则在门上挂一篾帽，生男挂左，生女挂右。不满月不准外人入内，商业部不准从产妇家借物，否则“踩断奶路”或“带走奶”。产褥污秽，须远处掩埋，以免污渎天、佛，招致灾难。产妇、婴儿住处须挂帷幔，与外人隔绝。丧葬禁忌：寿衣为兰布裤、白布衫，不穿棉衣。儿女不许伸手给死者穿寿衣。忌长时间停灵，一般不超过一个时辰（两小时），即卯时死，卯时出。入殓时忌尸从门过，要从窗户抬出。出殡时，忌灵车上死者头朝前，而须脚朝前。青海蒙古族实行天葬，送葬者将尸体送至葬场后，须立即返身跨越点起的人火堆，以除污秽，后急速回家，不能回头。服丧期，孝男孝女禁娱乐，禁着艳服。生活习俗禁忌：忌食虾、蟹、鱼、海味等，吃肉时须用刀，给人递刀时忌刀尖冲接刀者，应反之。厌恶黑色，认为黑色是不祥的颜色。忌用碗在水缸、锅中取水。忌碗口朝下扣放。忌从衣、帽、碗、桌、粮袋、锅台、磨台、井口、绳上跨过。忌以鞋、袜、裤为枕。忌讳别人（包括客人）骑着马在蒙古包门口下马和骑马闯进羊群，忌讳手持马鞭进入毡房。蒙古人客人不经允许不可擅自进入包内，在蒙古包内不能随便就坐，不能蹲、不能将腿伸向西北方或炉灶。不能从主人的衣帽、被褥、枕头上跨过，不能在包房内吐痰，出包房不能踩门槛。蒙古族人还忌讳别人用烟袋、刀剪、筷子等指头部。"
                           }
                       ];
    return [array copy];
}
-(instancetype)initWithContent_Id:(NSString *)content_id{
    if (self = [super init]) {
        self.contentid = content_id;
    }
    return self;

}
-(void)setTitleandContentwithBlock:(void(^) (NSString * title, NSMutableAttributedString *AttrStr ))block{
    NSArray *array = [self setDetailDic];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@",@"content_id",_contentid];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:predicate]];
    NSDictionary *dic = mutableArray[0];
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
        self.titleLabl.backgroundColor = [UIColor whiteColor];
        self.titleLabl.font = [UIFont systemFontOfSize:28];
        [self.titleLabl sizeToFit];
        self.contentLabl.numberOfLines = 0;
        self.contentLabl.attributedText =AttrStr;
        [self.contentLabl sizeToFit];
        CGFloat title_height = self.titleLabl.bounds.size.height;
        CGFloat content_height = self.contentLabl.bounds.size.height;
        [self.backgroundView addSubview:self.titleLabl];
        [self.view addSubview:self.contentLabl];
        [self.titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView).mas_offset(50);
            make.left.equalTo(self.backgroundView).mas_offset(30);
//            make.width.mas_equalTo(200);
//            make.height.mas_equalTo(30);
            make.bottom.equalTo(self.backgroundView).offset(content_height + title_height + 70);
        }];
        [self.contentLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabl.mas_bottom).mas_offset(30);
            make.left.equalTo(self.view).with.mas_offset(15);
            make.right.equalTo(self.view).mas_offset(-15);
        }];
    }];
    
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
