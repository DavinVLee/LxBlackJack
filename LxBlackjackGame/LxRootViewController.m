//
//  LxRootViewController.m
//  LxBlackjackGame
//
//  Created by HaiLunDev on 2017/11/1.
//  Copyright © 2017年 DavinLee. All rights reserved.
//

#import "LxRootViewController.h"
#import "ASButtonNode+ClickHelp.h"
#import "LxGameViewController.h"
#import "UIViewController+Default.h"

@interface LxRootViewController ()

@end

@implementation LxRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefault];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - layout
- (void)setupDefault
{
    ASImageNode *bgNode = [[ASImageNode alloc] init];
    bgNode.frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight);
    UIImage *bgImage = [UIImage lx_imageFromBundleWithName:@"bgMenu"];
    bgNode.image = bgImage;
    [self.view addSubnode:bgNode];
    
    ASButtonNode *playBtn = [[ASButtonNode alloc] init];
    playBtn.frame = CGRectMake((mScreenWidth - 132)/2.f, mScreenHeight * 0.65, 132, 44);
    UIImage *playImage = [UIImage lx_imageFromBundleWithName:@"btnPlay@2x"];
    [playBtn setImage:playImage forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(clickPlayAction:) forControlEvents:ASControlNodeEventTouchUpInside];
    [self.view addSubnode:playBtn];
    
    /** 中间logo显示 **/
    ASImageNode *logoNode = [[ASImageNode alloc] init];
    UIImage *logoImage = [UIImage lx_imageFromBundleWithName:@"gameTitle@2x"];
    logoNode.image = logoImage;
    logoNode.frame = CGRectMake((mScreenWidth - logoImage.size.width)/2.f,
                                80,
                                logoImage.size.width,
                                logoImage.size.height);
    [self.view addSubnode:logoNode];
    logoNode.view.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:3.0
                          delay:0
         usingSpringWithDamping:0.76
          initialSpringVelocity:5.3
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         logoNode.view.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         
                     }];
    
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

}


#pragma mark - ClickAction
- (void)clickPlayAction:(ASButtonNode *)btn
{

    LxGameViewController *gameVc = [[LxGameViewController alloc] init];
    [self lx_transitionWithType:@"rippleEffect"
                      WithSubtype:nil
                         Duration:2.5
                          ForView:self.navigationController.view];
    [self.navigationController pushViewController:gameVc animated:YES];
}

- (void)clickMuteAction:(ASButtonNode *)btn
{
    btn.selected = !btn.selected;
    
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
