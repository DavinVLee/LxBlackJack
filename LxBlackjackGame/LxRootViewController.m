
#import "LxRootViewController.h"
#import "ASButtonNode+ClickHelp.h"
#import "LxGameViewController.h"
#import "UIViewController+Default.h"
#import "WeBackGroundMusicManage.h"
#import "WeAVAudioPlayer.h"

@interface LxRootViewController ()
@property (strong, nonatomic) ASButtonNode *muteBtn;
@property (strong, nonatomic) WeAVAudioPlayer *bgPlayer;
@end

@implementation LxRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefault];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _bgPlayer.volume = [WeBackGroundMusicManage sharedInstance].volume;
    [_bgPlayer play];
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
    [self interfaceOrientation:UIInterfaceOrientationMaskLandscapeRight];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_bgPlayer pause];
}

#pragma mark - layout
- (void)setupDefault
{
    NSURL *voiceUrl = [[NSBundle mainBundle] URLForResource:@"MX054_31" withExtension:@"mp3"];
    _bgPlayer = [[WeAVAudioPlayer alloc] initWithContentsOfURL:voiceUrl error:nil];
    _bgPlayer.volume = [WeBackGroundMusicManage sharedInstance].volume;
    [_bgPlayer prepareToPlay];
    _bgPlayer.numberOfLoops = -1;
    [_bgPlayer play];
    
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
    _muteBtn = [[ASButtonNode alloc] init];
    UIImage *muteImage = [UIImage lx_imageFromBundleWithName:@"btnSound@2x"];
    [_muteBtn setImage:muteImage forState:UIControlStateNormal];
    [self.view addSubnode:_muteBtn];
    [_muteBtn addTarget:self
                action:@selector(clickMuteAction:)
      forControlEvents:ASControlNodeEventTouchUpInside];
    _muteBtn.frame = CGRectMake(mScreenWidth - muteImage.size.width - 20,
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
    [[WeBackGroundMusicManage sharedInstance] playVoiceWithType:playVoiceClick];
}

- (void)clickMuteAction:(ASButtonNode *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [[WeBackGroundMusicManage sharedInstance] setVolume:0];
    }else{
        [[WeBackGroundMusicManage sharedInstance] setVolume:0.4];
    }
    _bgPlayer.volume = [WeBackGroundMusicManage sharedInstance].volume;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
