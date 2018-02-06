

#import "LxGameViewController.h"
#import "UIImage+Default.h"
#import "ASButtonNode+ClickHelp.h"
#import "UIViewController+Default.h"
#import "UIFont+Default.h"
#import "LxCardModel.h"
#import "LxCardGameHelper.h"
#import "WeBackGroundMusicManage.h"
#import "LxResultPushNode.h"
#import "LxWebViewController.h"
//#import "KCWebViewController.swift"
#import "LxBlackjackGame-Swift.h"

CGPoint const kRobotPoint  = {220,30};
CGPoint const kHumanPoint = {220,140};
CGFloat const kSpaceOfCards = 25;

@interface LxGameViewController ()
/**
 *@description 分数显示
 **/
@property (strong, nonatomic) UILabel *scoreLabel;
/**
 *@description 投注显示
 **/
@property (strong, nonatomic) UILabel *betLabel;
/**
 *@description 开始按钮
 **/
@property (strong, nonatomic) ASButtonNode *startBtn;

/**
 *@description 叫牌按钮
 **/
@property (strong, nonatomic) ASButtonNode *hitBtn;

/**
 *@description 所有筹码添加按钮
 **/
@property (strong, nonatomic) NSArray <ASButtonNode *>*chipsBtnArray;

/**
 *@description 存放所有已下注筹码
 **/
@property (strong, nonatomic) NSMutableArray <ASImageNode *>* tempChipsNodeArray;

/**
 *@description 发牌处UI
 **/
@property (strong, nonatomic) ASImageNode *cardsNode;
/**
 *@description 存放所有投注筹码UI
 **/
@property (strong, nonatomic) NSMutableArray <ASImageNode *>* betChipsNodeArray;
//
///**
// *@description 临时存放卡牌对象ui
// **/
//@property (strong, nonatomic) LxCardNode *tempCardNode;
/**
 *@description 存放所有卡牌model
 **/
@property (strong, nonatomic) NSMutableArray <LxCardModel *>*totalCardModelArray;

/**
 *@description 存放机器的卡牌model
 **/
@property (strong, nonatomic) NSMutableArray <LxCardModel *>* robotModelArray;
/**
 *@description 机器计分背景
 **/
@property (strong, nonatomic) ASImageNode *robotScoreBgNode;
/**
 *@description 机器计分显示
 **/
@property (strong, nonatomic) UILabel *robotScoreLabel;
/**
 *@description 人类计分背景
 **/
@property (strong, nonatomic) ASImageNode *humanScoreBgNode;
/**
 *@description 人类计分显示
 **/
@property (strong, nonatomic) UILabel *humanScoreLabel;
/**
 *@description 存放人类卡牌model
 **/
@property (strong, nonatomic) NSMutableArray <LxCardModel *>*humanModelArray;
@property (strong, nonatomic) ASButtonNode *muteBtn;


/**
 *@description 是否已发牌
 **/
@property (assign, nonatomic) BOOL isPrepareHit;
/**
 *@description 是否机器自动发牌
 **/
@property (assign, nonatomic) BOOL isRobotTurn;
@end

@implementation LxGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefault];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([WeBackGroundMusicManage sharedInstance].volume == 0) {
        _muteBtn.selected = YES;
    }else
    {
        _muteBtn.selected = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

#pragma mark - GetMethod
- (NSMutableArray <LxCardModel *>*)totalCardModelArray
{
    if (_totalCardModelArray.count < 20) {
        [_totalCardModelArray removeAllObjects];
        _totalCardModelArray = [LxCardGameHelper getRandomCardsModelArray];
    }
    return _totalCardModelArray;
}

- (LxCardModel *)getNextCardModel
{
    LxCardModel *nextModel = [self.totalCardModelArray lastObject];
    [self.totalCardModelArray removeLastObject];
    
    LxCardNode *cardNode = [[LxCardNode alloc] init];
    [cardNode setupCardWithCardType:nextModel.type tag:nextModel.tag];
    nextModel.cardNode = cardNode;
    return nextModel;
}


#pragma mark - Function
- (void)setupDefault
{
    _robotModelArray = [[NSMutableArray alloc] init];
    _humanModelArray = [[NSMutableArray alloc] init];
    _betChipsNodeArray = [[NSMutableArray alloc] init];
    _tempChipsNodeArray = [[NSMutableArray alloc] init];
    /** 背景 **/
    ASImageNode *bgNode = [[ASImageNode alloc] init];
    UIImage *bgImage = [UIImage lx_imageFromBundleWithName:@"bgGame@2x"];
    bgNode.image = bgImage;
    bgNode.frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight);
    [self.view addSubnode:bgNode];
    
    /** 右上角静音按钮 **/
    ASButtonNode *muteBtn = [[ASButtonNode alloc] init];
    UIImage *muteImage = [UIImage lx_imageFromBundleWithName:@"btnSound@2x"];
    [muteBtn setImage:muteImage forState:UIControlStateNormal];
    [self.view addSubnode:muteBtn];
    [muteBtn addTarget:self
                action:@selector(clickMuteAction:)
      forControlEvents:ASControlNodeEventTouchUpInside];
    muteBtn.frame = CGRectMake(mScreenWidth - muteImage.size.width - 20,
                               20,
                               muteImage.size.width,
                               muteImage.size.height);
    
    /** 返回主菜单按钮 **/
    ASButtonNode *menuBtn = [[ASButtonNode alloc] init];
    UIImage *menuImage = [UIImage lx_imageFromBundleWithName:@"btnMenu@2x"];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(CGRectGetMinX(muteBtn.frame) - 20 - menuImage.size.width,
                               20,
                               menuImage.size.width,
                               menuImage.size.height);
    [menuBtn addTarget:self
                 action:@selector(clickMenuAction:)
       forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:menuBtn];
    
    /** 分数底图 **/
    ASImageNode *scoreBgNode = [[ASImageNode alloc] init];
    UIImage *scoreImage = [UIImage lx_imageFromBundleWithName:@"moneyBar@2x"];
    scoreBgNode.image = scoreImage;
    scoreBgNode.frame = CGRectMake(10, 20, scoreImage.size.width, scoreImage.size.height);
    [self.view addSubnode:scoreBgNode];
    
    /** 分数显示 **/
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 1, 82, 25)];
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.font = [UIFont lx_hyShuYuanOfSize:24];
    _scoreLabel.text = @"660";
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.adjustsFontSizeToFitWidth = YES;
    [scoreBgNode.view addSubview:_scoreLabel];
    
    
    /** 筹码添加按钮 **/
    ASButtonNode *chip_h = [[ASButtonNode alloc] init];
    UIImage *chipImage = [UIImage lx_imageFromBundleWithName:@"chip100@2x"];
    [chip_h setImage:chipImage forState:UIControlStateNormal];
    chip_h.frame = CGRectMake(mScreenWidth - 10 - chipImage.size.width,
                              mScreenHeight - 10 - chipImage.size.height,
                              chipImage.size.width,
                              chipImage.size.height);
    chip_h.view.tag = 100;
    chip_h.layer.cornerRadius = chipImage.size.width / 2.f;
    chip_h.layer.masksToBounds = YES;
    [chip_h addTarget:self action:@selector(chipsClick:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:chip_h];
    
    ASButtonNode *chip_f = [[ASButtonNode alloc] init];
    UIImage *chip_fImage = [UIImage lx_imageFromBundleWithName:@"chip50@2x"];
    [chip_f setImage:chip_fImage forState:UIControlStateNormal];
    chip_f.frame = CGRectMake(mScreenWidth - 10 * 2 - chip_fImage.size.width * 2,
                              mScreenHeight - 10 - chip_fImage.size.height,
                              chip_fImage.size.width,
                              chip_fImage.size.height);
    chip_f.view.tag = 50;
    chip_f.layer.cornerRadius = chip_fImage.size.width / 2.f;
    chip_f.layer.masksToBounds = YES;
    [chip_f addTarget:self action:@selector(chipsClick:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:chip_f];
    
    ASButtonNode *chip_t = [[ASButtonNode alloc] init];
    UIImage *chip_tImage = [UIImage lx_imageFromBundleWithName:@"chip20@2x"];
    [chip_t setImage:chip_tImage forState:UIControlStateNormal];
    chip_t.frame = CGRectMake(mScreenWidth - 10 * 3 - chip_tImage.size.width * 3,
                              mScreenHeight - 10 - chip_tImage.size.height,
                              chip_tImage.size.width,
                              chip_tImage.size.height);
    chip_t.view.tag = 20;
    chip_t.layer.cornerRadius = chip_tImage.size.width / 2.f;
    chip_t.layer.masksToBounds = YES;
    [chip_t addTarget:self action:@selector(chipsClick:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:chip_t];
    
    ASButtonNode *chip_e = [[ASButtonNode alloc] init];
    UIImage *chip_eImage = [UIImage lx_imageFromBundleWithName:@"chip10@2x"];
    [chip_e setImage:chip_eImage forState:UIControlStateNormal];
    chip_e.frame = CGRectMake(mScreenWidth - 10 * 4 - chip_eImage.size.width * 4,
                              mScreenHeight - 10 - chip_eImage.size.height,
                              chip_eImage.size.width,
                              chip_eImage.size.height);
    chip_e.view.tag = 10;
    chip_e.layer.cornerRadius = chip_eImage.size.width / 2.f;
    chip_e.layer.masksToBounds = YES;
    [chip_e addTarget:self action:@selector(chipsClick:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:chip_e];
    
    _chipsBtnArray = @[chip_h,chip_f,chip_t,chip_e];
    
    /** 添加叫牌安妮**/
    _hitBtn = [[ASButtonNode alloc] init];
    UIImage *hitImage = [UIImage lx_imageFromBundleWithName:@"hit@2x"];
    [_hitBtn setImage:hitImage forState:UIControlStateNormal];
    _hitBtn.frame = CGRectMake(CGRectGetMaxX(chip_t.frame) - hitImage.size.width/2.f, CGRectGetMidY(chip_e.frame) - hitImage.size.height/2.f, hitImage.size.width, hitImage.size.height);
    [_hitBtn addTarget:self action:@selector(clickHit:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:_hitBtn];
    _hitBtn.hidden = YES;
    
    
    /** 添加筹码分数添加 **/
    ASImageNode *betNode = [[ASImageNode alloc] init];
    UIImage *betImage = [UIImage lx_imageFromBundleWithName:@"betBar@2x"];
    betNode.image = betImage;
    betNode.frame = CGRectMake((mScreenWidth - betImage.size.width)/2.f, mScreenHeight * 0.65, betImage.size.width, betImage.size.height);
    [self.view addSubnode:betNode];
    
    _betLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 25)];
    _betLabel.textColor = [UIColor whiteColor];
    _betLabel.font = [UIFont lx_hyShuYuanOfSize:24];
    _betLabel.text = @"0";
    _betLabel.textAlignment = NSTextAlignmentCenter;
    _betLabel.adjustsFontSizeToFitWidth = YES;
    [betNode.view addSubview:_betLabel];
    
    /** 人机点数显示 **/
    _robotScoreBgNode = [[ASImageNode alloc] init];
    UIImage *robotScoreBgImage = [UIImage lx_imageFromBundleWithName:@"valueBar@2x"];
    _robotScoreBgNode.image = robotScoreBgImage;
    _robotScoreBgNode.frame = CGRectMake(kRobotPoint.x - robotScoreBgImage.size.width,
                                          kRobotPoint.y + 10 + robotScoreBgImage.size.height,
                                          robotScoreBgImage.size.width,
                                          robotScoreBgImage.size.height);
    [self.view addSubnode:_robotScoreBgNode];
    _robotScoreBgNode.hidden = YES;
    
    _robotScoreLabel = [[UILabel alloc] initWithFrame:_robotScoreBgNode.bounds];
    _robotScoreLabel.textColor = [UIColor whiteColor];
    _robotScoreLabel.font = [UIFont lx_boldMicrosoftYaHeiFontOfSize:60];
    _robotScoreLabel.textAlignment = NSTextAlignmentCenter;
    _robotScoreLabel.text = @"0";
    [_robotScoreBgNode.view addSubview:_robotScoreLabel];
    
    
    _humanScoreBgNode = [[ASImageNode alloc] init];
    UIImage *humanScoreBgImage = [UIImage lx_imageFromBundleWithName:@"valueBar@2x"];
    _humanScoreBgNode.image = humanScoreBgImage;
    _humanScoreBgNode.frame = CGRectMake(kHumanPoint.x - humanScoreBgImage.size.width,
                                         kHumanPoint.y + 10 + humanScoreBgImage.size.height,
                                         humanScoreBgImage.size.width,
                                         humanScoreBgImage.size.height);
    [self.view addSubnode:_humanScoreBgNode];
    _humanScoreBgNode.hidden = YES;
    
    _humanScoreLabel = [[UILabel alloc] initWithFrame:_humanScoreBgNode.bounds];
    _humanScoreLabel.textColor = [UIColor whiteColor];
    _humanScoreLabel.font = [UIFont lx_boldMicrosoftYaHeiFontOfSize:60];
    _humanScoreLabel.textAlignment = NSTextAlignmentCenter;
    _humanScoreLabel.text = @"0";
    [_humanScoreBgNode.view addSubview:_humanScoreLabel];
    
    
    /** 发牌处UI **/
    _cardsNode  = [[ASImageNode alloc] init];
    UIImage *cardImage = [UIImage lx_imageFromBundleWithName:@"cards@2x"];
    _cardsNode.image = cardImage;
    _cardsNode.frame = CGRectMake(mScreenWidth * 0.8, mScreenHeight * 0.2, cardImage.size.width, cardImage.size.height);
    [self.view addSubnode:_cardsNode];
    
    
    /** 添加开始按钮 **/
    _startBtn = [[ASButtonNode alloc] init];
    UIImage *startImage = [UIImage lx_imageFromBundleWithName:@"deal@2x"];
    [_startBtn setImage:startImage forState:UIControlStateNormal];
    [_startBtn setImage:[UIImage lx_imageFromBundleWithName:@"stand@2x"] forState:UIControlStateSelected];
    _startBtn.frame = CGRectMake(10, mScreenHeight - 20 - startImage.size.height, startImage.size.width, startImage.size.height);
    [_startBtn addTarget:self action:@selector(clickDeal:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:_startBtn];
    
    ASButtonNode *tempClickBtn = [ASButtonNode new];
    tempClickBtn.view.tag = 10;
    [self chipsClick:tempClickBtn];
    
    
//    ASButtonNode *webBtn = [[ASButtonNode alloc] init];
//    webBtn.frame = CGRectMake(mScreenWidth - 60, (mScreenHeight - 50)/2.f, 50,50);
//    webBtn.backgroundColor = [UIColor redColor];
//    [webBtn addTarget:self action:@selector(webBtnClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
//    [self.view addSubnode:webBtn];
    
}

- (void)webBtnClicked:(ASButtonNode *)btn
{
    LxWebViewController *webVC = [[LxWebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:NO];
}

- (void)sendCard:(LxCardNode *)card WithoriginPoint:(CGPoint)originPoint autoDraw:(BOOL)autoDraw
{
    [self.view addSubview:card];
    [self.view insertSubview:card belowSubview:_cardsNode.view];
    CGRect rect = card.frame;
    rect.origin = _cardsNode.frame.origin;
    card.frame = rect;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         CGRect newRect = card.frame;
                         newRect.origin = originPoint;
                         card.frame = newRect;
                     } completion:^(BOOL finished) {
                         if (autoDraw) {
                             [card changeSideToFront:YES];
                             [self calculPoint];
                         }
                         if (_isRobotTurn) {
                             [self robotTurnHit];
                         }
                     }];
    
}

- (void)calculPoint
{
    NSInteger pointCount = 0;
    for (LxCardModel *tempModel in _robotModelArray) {
        if (tempModel.cardNode.isFront) {
            pointCount += tempModel.pointCount;
        }
    }
    _robotScoreLabel.text = [NSString stringWithFormat:@"%ld",pointCount];
    if (pointCount > 21) {
        [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:PlayVoiceVikter];
        [self resetTempChipsWithGameStatus:LxGameWin];
        [LxResultPushNode showResultWithType:LxGameWin block:^(BOOL isFinish) {
            [self resetUI];
        }];
    }
    
    pointCount = 0;
    for (LxCardModel *tempModel in _humanModelArray) {
        if (tempModel.cardNode.isFront) {
            pointCount += tempModel.pointCount;
        }
    }
    _humanScoreLabel.text = [NSString stringWithFormat:@"%ld",pointCount];
    if (pointCount > 21) {
        [self resetTempChipsWithGameStatus:LxGameLose];
        [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:playVoiceError];
        [LxResultPushNode showResultWithType:LxGameLose block:^(BOOL isFinish) {
            [self resetUI];
        }];
    }
}


- (void)resetTempChipsWithGameStatus:(LxGameStatus)gameStatus
{
    CGFloat offsetY = 0;
    NSInteger offsetScore = 0;
    _isRobotTurn = NO;
    switch (gameStatus) {
        case LxGameWin:
        {
            offsetY = -150;
            offsetScore = [_betLabel.text integerValue] * 2;
        }
            break;
            case LxGameLose:
        {
            offsetY = mScreenHeight + 150;
            offsetScore = 0;
        }
            break;
            case LxGamePush:
        {
            offsetY = - 150;
            offsetScore = [_betLabel.text integerValue];
        }
            break;
  
        default:
            break;
    }
    [UIView animateWithDuration:0.8
                     animations:^{
                         for (ASImageNode *tempChip in _tempChipsNodeArray) {
                             CGRect rect = tempChip.frame;
                             rect.origin = CGPointMake((mScreenWidth - rect.size.width)/2.f, offsetY);
                             tempChip.frame = rect;
                         }
                     } completion:^(BOOL finished) {
                         _scoreLabel.text = [NSString stringWithFormat:@"%ld",[_scoreLabel.text integerValue] + offsetScore];
                         for (ASImageNode *tempChip in _tempChipsNodeArray) {
                             [tempChip removeFromSupernode];
                         }
                         [_tempChipsNodeArray removeAllObjects];
                     }];
}

- (void)resetUI
{
    _isPrepareHit = NO;
    _isRobotTurn = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.8
                         animations:^{
                             for (ASButtonNode *btn in _chipsBtnArray) {
                                 btn.hidden= NO;
                             }
                             _betLabel.text = @"0";
                             _hitBtn.hidden = YES;
                             _robotScoreBgNode.hidden = YES;
                             _humanScoreBgNode.hidden = YES;
                             [_startBtn setImage:[UIImage lx_imageFromBundleWithName:@"deal@2x"] forState:UIControlStateNormal];
                             _robotScoreLabel.text = @"0";
                             _humanScoreLabel.text = @"0";
                             for (LxCardModel *humanCardModel in _humanModelArray) {
                                 CGRect rect = humanCardModel.cardNode.frame;
                                 rect.origin = CGPointMake(512 - rect.size.width/2.f, - 200);
                                 humanCardModel.cardNode.frame = rect;
                             }
                             for (LxCardModel *robotModel in _robotModelArray) {
                                 CGRect rect = robotModel.cardNode.frame;
                                 rect.origin = CGPointMake(512 - rect.size.width/2.f, - 200);
                                 robotModel.cardNode.frame = rect;
                             }
                         } completion:^(BOOL finished) {
                             ASButtonNode *tempBtn = [[ASButtonNode alloc] init];
                             tempBtn.view.tag = 10;
                             [self chipsClick:tempBtn];
                             for (LxCardModel *humanCardModel in _humanModelArray) {
                                 [humanCardModel.cardNode removeFromSuperview];
                             }
                             for (LxCardModel *robotModel in _robotModelArray) {
                                 [robotModel.cardNode removeFromSuperview];
                             }
                             [_humanModelArray removeAllObjects];
                             [_robotModelArray removeAllObjects];
                              _startBtn.enabled = YES;
                         }];
        
        
        
        
        
    });
}

- (void)startGamePrepare
{
    LxCardModel *rFirstModel = [self getNextCardModel];
    [_robotModelArray addObject:rFirstModel];
    [self sendCard:rFirstModel.cardNode WithoriginPoint:CGPointMake(kRobotPoint.x + _robotModelArray.count * kSpaceOfCards, kRobotPoint.y) autoDraw:YES];
    
    LxCardModel *rSecondModel = [self getNextCardModel];
    [_robotModelArray addObject:rSecondModel];
    [self sendCard:rSecondModel.cardNode  WithoriginPoint:CGPointMake(kRobotPoint.x + _robotModelArray.count * kSpaceOfCards, kRobotPoint.y) autoDraw:NO];
    
    LxCardModel *hFirstModel = [self getNextCardModel];
    [_humanModelArray addObject:hFirstModel];
    [self sendCard:hFirstModel.cardNode WithoriginPoint:CGPointMake(kHumanPoint.x + _humanModelArray.count * kSpaceOfCards, kHumanPoint.y) autoDraw:YES];
    
    LxCardModel *hSecondModel = [self getNextCardModel];
    [_humanModelArray addObject:hSecondModel];
    [self sendCard:hSecondModel.cardNode WithoriginPoint:CGPointMake(kHumanPoint.x + _humanModelArray.count * kSpaceOfCards, kHumanPoint.y) autoDraw:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        for (ASButtonNode *btn in _chipsBtnArray) {
            btn.hidden = YES;
        }
        _hitBtn.hidden = NO;
        _robotScoreBgNode.hidden = NO;
        _humanScoreBgNode.hidden = NO;
    }];
}

- (void)robotTurnHit
{
    
    if ([_robotScoreLabel.text integerValue] > 21) {
        return;
    }
    
    for (LxCardModel *tempCardModel in _robotModelArray) {
        if (!tempCardModel.cardNode.isFront) {
            [tempCardModel.cardNode changeSideToFront:YES];
        }
    }
    [self calculPoint];
    
    
    if ([_robotScoreLabel.text integerValue] > [_humanScoreLabel.text integerValue]) {
        [self resetTempChipsWithGameStatus:LxGameLose];
        [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:playVoiceError];
        [LxResultPushNode showResultWithType:LxGameLose block:^(BOOL isFinish) {
            [self resetUI];
        }];
    }else if ([_robotScoreLabel.text integerValue] >= 18 &&
              [_robotScoreLabel.text integerValue] == [_humanScoreLabel.text integerValue])
    {
        [self resetTempChipsWithGameStatus:LxGamePush];
        [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:PlayVoiceVikter];
        [LxResultPushNode showResultWithType:LxGamePush block:^(BOOL isFinish) {
            [self resetUI];
        }];
    }else if ([_robotScoreLabel.text integerValue] <= [_humanScoreLabel.text integerValue])
    {

    LxCardModel *rFirstModel = [self getNextCardModel];
    [_robotModelArray addObject:rFirstModel];
    [self sendCard:rFirstModel.cardNode WithoriginPoint:CGPointMake(kRobotPoint.x + _robotModelArray.count * kSpaceOfCards, kRobotPoint.y) autoDraw:YES];
    }
}

#pragma mark - ClickAction
- (void)clickMuteAction:(ASButtonNode *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [[WeBackGroundMusicManage sharedInstance] setVolume:0];
    }else{
        [[WeBackGroundMusicManage sharedInstance] setVolume:0.4];
    }
    
}

- (void)chipsClick:(ASButtonNode *)btn
{
     [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:playVoiceClick];
    if ([_scoreLabel.text integerValue] - btn.view.tag >= 0) {
        _scoreLabel.text = [NSString stringWithFormat:@"%ld",[_scoreLabel.text integerValue] - btn.view.tag];
        _betLabel.text = [NSString stringWithFormat:@"%ld",[_betLabel.text integerValue] + btn.view.tag];
        
        ASImageNode *chipNode = [[ASImageNode alloc] init];
        UIImage *chipImage = [UIImage lx_imageFromBundleWithName:[NSString stringWithFormat:@"chip%ld@2x",btn.view.tag]];
        chipNode.image = chipImage;
        [self.view addSubnode:chipNode];
        chipNode.frame = CGRectMake(- 100, mScreenHeight/2.f, chipImage.size.width, chipImage.size.height);
        CGFloat offsetx = 60 + arc4random() % 80;
        CGFloat offsetY = 100 + arc4random() % 150;
        [_tempChipsNodeArray addObject:chipNode];
        [UIView animateWithDuration:1.0 animations:^{
           chipNode.view.center = CGPointMake(offsetx
                                              , offsetY);
        }];
    }
    
}

- (void)clickDeal:(ASButtonNode *)btn
{
     [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:playVoiceClick];
    if ([_betLabel.text integerValue] <= 0) {
        return;
    }
    _isPrepareHit = !_isPrepareHit;
    
    if (_isPrepareHit) {
         [self startGamePrepare];
        [btn setImage:[UIImage lx_imageFromBundleWithName:@"stand@2x"] forState:UIControlStateNormal];
    }else
    {
        _isRobotTurn = YES;
        [self robotTurnHit];
        btn.enabled = NO;
    }
  
    
}

- (void)clickHit:(ASButtonNode *)btn
{
     [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:playVoiceClick];
    LxCardModel *hFirstModel = [self getNextCardModel];
    [_humanModelArray addObject:hFirstModel];
    [self sendCard:hFirstModel.cardNode WithoriginPoint:CGPointMake(kHumanPoint.x + _humanModelArray.count * kSpaceOfCards, kHumanPoint.y) autoDraw:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (void)clickMenuAction:(ASButtonNode *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - origin

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}
- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
