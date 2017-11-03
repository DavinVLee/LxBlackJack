//
//  LxGameViewController.m
//  LxBlackjackGame
//
//  Created by HaiLunDev on 2017/11/2.
//  Copyright © 2017年 DavinLee. All rights reserved.
//

#import "LxGameViewController.h"
#import "UIImage+Default.h"
#import "ASButtonNode+ClickHelp.h"
#import "UIViewController+Default.h"
#import "UIFont+Default.h"

@interface LxGameViewController ()
/**
 *@description 分数显示
 **/
@property (strong, nonatomic) UILabel *scoreLabel;

@end

@implementation LxGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefault];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Function
- (void)setupDefault
{
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
    _scoreLabel.text = @"0";
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.adjustsFontSizeToFitWidth = YES;
    [scoreBgNode.view addSubview:_scoreLabel];
    
}

#pragma mark - ClickAction
- (void)clickMuteAction:(ASButtonNode *)btn
{
    btn.selected = !btn.selected;
    
}

- (void)clickMenuAction:(ASButtonNode *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
