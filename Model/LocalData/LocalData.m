//
//  LocalData.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/25.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "LocalData.h"
static LocalData *_LocalData = nil;
@implementation LocalData
+ (LocalData *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _LocalData = [[LocalData alloc]init];
    });
    return _LocalData;
}


-(void)getArticalwithContent_id:(NSString *)Content_id completion:(void (^) (id responseArray, NSError * error))block{
    NSDictionary *ArticalDic = [NSDictionary dictionary];
    for (NSDictionary *dic in [self setDetailDic]) {
        @autoreleasepool{
            if ([dic[@"content_id"]isEqualToString:Content_id]) {
                ArticalDic = [dic copy];
                break;
            }
        }
    }
    if (block) {
        block  (ArticalDic, nil);
    }
}


-(void)getDataArrayWithcompletion:(void(^) (NSArray * responseArray))completionblock{
    NSArray *array = [NSArray arrayWithArray:[self setDetailDic]];
    if (completionblock) {
        completionblock(array);
    }
}


-(NSArray *)setDetailDic{
    NSArray *array = @[@{   @"content_id":@"Han",
                            @"title":@"汉族的礼仪文化",
                            @"content":@""
                            },
                       @{   @"content_id":@"Menggu",
                            @"title":@"蒙古族的礼仪文化",
                            @"content":@"\t蒙古族是一个历史悠久而又富有传奇色彩的民族，过着“逐水草而迁徙”的游牧生活。中国的大部分草原都留下了蒙古族牧民的足迹，因而被誉为“草原骄子”。每年七、八月牲畜肥壮的季节举行“那达慕”大会是蒙古族历史悠久的传统节日，这是人们为了庆祝丰收而举行的文体娱乐大会。\n\t“那达慕”大会上有惊险动人的赛马、摔跤，令人赞赏的射箭，有争强斗胜的棋艺，有引人入胜的歌舞，显示出草原民族独有的特色。蒙古族被称为草原上的民族，主要聚居于内蒙古自治区和新疆、青海、甘肃、黑龙江、吉林、辽宁等省（区）的蒙古族自治州、县，余者散居于宁夏、河北、四川、云南、北京等省、市、区。\n\t婚姻禁忌：古代禁忌为氏族内部不通婚，男子只能娶他部落女子。嫁到该氏族的妇女，从此不可脱离该氏族。若夫死，只能改嫁丈夫的近亲。旧时，新郎娶亲时，须挎佩刀与弓箭。到女家，摘下刀箭放于马窗西侧，走时再挎。娶亲归来仍将其放于马窗西侧，3天人禁触动。3天后，新娘将其收起，作为吉祥物和镇器永久保存。该族忌讳离婚，视其为最不道德、不吉祥的事。\n\t产忌：产妇生产期，忌外人入内，忌门均挂有标志：生男，挂弓箭，以示男儿之勇；生女，挂红布条，以示女儿之巧。云南蒙古族则在门上挂一篾帽，生男挂左，生女挂右。不满月不准外人入内，商业部不准从产妇家借物，否则“踩断奶路”或“带走奶”。产褥污秽，须远处掩埋，以免污渎天、佛，招致灾难。产妇、婴儿住处须挂帷幔，与外人隔绝。\n\t丧葬禁忌：寿衣为兰布裤、白布衫，不穿棉衣。儿女不许伸手给死者穿寿衣。忌长时间停灵，一般不超过一个时辰（两小时），即卯时死，卯时出。入殓时忌尸从门过，要从窗户抬出。出殡时，忌灵车上死者头朝前，而须脚朝前。青海蒙古族实行天葬，送葬者将尸体送至葬场后，须立即返身跨越点起的人火堆，以除污秽，后急速回家，不能回头。服丧期，孝男孝女禁娱乐，禁着艳服。\n\t生活习俗禁忌：忌食虾、蟹、鱼、海味等，吃肉时须用刀，给人递刀时忌刀尖冲接刀者，应反之。厌恶黑色，认为黑色是不祥的颜色。忌用碗在水缸、锅中取水。忌碗口朝下扣放。忌从衣、帽、碗、桌、粮袋、锅台、磨台、井口、绳上跨过。忌以鞋、袜、裤为枕。忌讳别人（包括客人）骑着马在蒙古包门口下马和骑马闯进羊群，忌讳手持马鞭进入毡房。蒙古人客人不经允许不可擅自进入包内，在蒙古包内不能随便就坐，不能蹲、不能将腿伸向西北方或炉灶。不能从主人的衣帽、被褥、枕头上跨过，不能在包房内吐痰，出包房不能踩门槛。蒙古族人还忌讳别人用烟袋、刀剪、筷子等指头部。"
                            }
                       ];
    return array;
}
@end
