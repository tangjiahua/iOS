//
//  BITFilmDataProvider.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/13.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "BITFilmDataProvider.h"

@implementation BITFilmDataProvider

+ (instancetype)sharedProvider {
    static BITFilmDataProvider *_sharedProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProvider = [[BITFilmDataProvider alloc] init];
    });

    return _sharedProvider;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _avengersModel = [[BITFilmModel alloc] initWithName:@"Catalina" imageName:@"Catalina.jpg" iconImageName:@"Catalina.jpg" filmDescription:@"一声响指，宇宙间半数生命灰飞烟灭。几近绝望的复仇者们在惊奇队长的帮助下找到灭霸归隐之处，却得知六颗无限宝石均被销毁，希望彻底破灭。如是过了五年，迷失在量子领域的蚁人意外回到现实世界，他的出现为幸存的复仇者们点燃了希望。与美国队长冰释前嫌的托尼找到了穿越时空的方法，星散各地的超级英雄再度集结，他们分别穿越不同的时代去搜集无限宝石。而在这一过程中，平行宇宙的灭霸察觉了他们的计划。注定要载入史册的最终决战，超级英雄们为了心中恪守的信念前仆后继…… "];
        _aquamanModel = [[BITFilmModel alloc] initWithName:@"海王" imageName:@"aquaman.jpg" iconImageName:@"icon_aquaman" filmDescription:@"许多年前，亚特兰蒂斯女王（和人类相知相恋，共同孕育了爱情的结晶——后来被陆地人称为海王的亚瑟·库瑞。在成长的过程中，亚瑟接受海底导师维科的严苛训练，时刻渴望去看望母亲，然而作为混血的私生子这却是奢望。与此同时，亚瑟的同母异父兄弟奥姆成为亚特兰蒂斯的国王，他不满陆地人类对大海的荼毒与污染，遂谋划联合其他海底王国发动对陆地的全面战争。为了阻止他的野心，维科和奥姆的未婚妻湄拉将亚瑟带到海底世界。宿命推动着亚瑟，去寻找失落已久的三叉戟，建立一个更加开明的海底王国……"];
        _ironManModel = [[BITFilmModel alloc] initWithName:@"钢铁侠3" imageName:@"ironman.jpg" iconImageName:@"icon_ironman" filmDescription:@"自纽约事件以来，托尼·斯塔克为前所未有的焦虑症所困扰。他疯狂投入钢铁侠升级版的研发，为此废寝忘食，甚至忽略了女友佩珀·波茨的感受。与此同时，臭名昭著的恐怖头目曼达林（制造了一连串的爆炸袭击事件，托尼当年最忠诚的保镖即在最近的一次袭击中身负重伤。未过多久，托尼、佩珀以及曾与他有过一面之缘的女植物学家玛雅在家中遭到猛烈的炮火袭击，几乎丧命，而这一切似乎都与22年前那名偶然邂逅的科学家阿尔德里奇·基连及其终极生物的研究有关。即使有精密先进的铠甲护身，也无法排遣发自心底的焦虑。被击碎一切的托尼，如何穿越来自地狱的熊熊烈火…… "];
        _captainAmericaModel = [[BITFilmModel alloc] initWithName:@"美国队长3" imageName:@"captain.jpg" iconImageName:@"icon_captain" filmDescription:@"美国队长史蒂夫·罗杰斯带领着全新组建的复仇者联盟，继续维护世界和平。然而，一次执行任务时联盟成员不小心造成大量平民伤亡，从而激发政治压力，政府决定通过一套监管系统来管理和领导复仇者联盟。联盟内部因此分裂为两派：一方由史蒂夫· 罗杰斯领导，他主张维护成员自由，在免受政府干扰的情况下保护世界；另一方则追随托尼·斯塔克，他令人意外地决定支持政府的监管和责任制体系。神秘莫测的巴基似乎成为内战的关键人物……"];
    }
    return self;
}

@end
