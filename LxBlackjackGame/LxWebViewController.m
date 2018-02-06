

#import "LxWebViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "lxBottomBar.h"
#import "LxAlertController.h"

@interface LxWebViewController ()<WKUIDelegate,WKNavigationDelegate,LxBottomBarDelegate>

@property (strong, nonatomic) WKWebView *webView;

@property (strong, nonatomic) lxBottomBar *bottomBar;

@property (strong, nonatomic) UIProgressView *progressView;
@end

@implementation LxWebViewController
#pragma mark - OverWrite


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefault];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)setupDefault
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, mScreenWidth, mScreenHeight - 20)];
    NSURL *url = [NSURL URLWithString:@"https://qwe231.com/"];//@"http://amjsc88.com" @"https://a38278.com"
    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    [self.view addSubview:_webView];
    _webView.allowsBackForwardNavigationGestures = NO;
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    _bottomBar = [[lxBottomBar alloc] initWithFrame:CGRectMake(0, mScreenHeight - 64, mScreenWidth, 64)];
    _bottomBar.backgroundColor = [UIColor colorWithRed:249/256.f green:249/256.f blue:249/256.f alpha:1];
    [_bottomBar setupDefault];
    [self.view addSubview:_bottomBar];_bottomBar.delegate = self;
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_equalTo(_bottomBar.mas_top).mas_offset(0);
    }];
    
    [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_equalTo(mScreenWidth > mScreenHeight ? 0 : 44);
    }];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateOrientaion:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

   
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


- (void)updateOrientaion:(UIInterfaceOrientation)interfaceOrientation
{
//    /;/    if ([UIDevice currentDevice].orientation != UIInterfaceOrientationPortrait&&
//        ([UIDevice currentDevice].orientation != UIDeviceOrientationFaceUp)) {
//        
        if (mScreenWidth > mScreenHeight) {
            [_bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }else
        {
            [_bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(44);
            }];
        }
        
//    }else
//    {
//        [_bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(44);
//        }];
//    }
    
    NSLog(@"调转了方向");
    [_bottomBar setNeedsDisplay];
    [_bottomBar setNeedsLayout];
}


- (void)btnClickIndex:(NSInteger)index{

    switch (index) {
        case 1:
           {
               NSURL *url = [NSURL URLWithString:@"http://amjsc88.com"];
               [_webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
               
           }
            break;
            case 2:
        {
            if ([_webView canGoBack]) {
                [_webView goBack];
            }
        }
            break;
            case 3:
        {
            if ([_webView canGoForward]) {
                [_webView goForward];
            }
        }
            break;
            case 4:
        {
            [_webView reload];
        }
            break;
//            + (LxAlertController *)lx_alertShowWithTitle:(NSString *)title
//        message:(NSString *)message
//        actionTitles:(NSArray <NSString *>*)actionTitles
//        actionStyles:(NSArray *)actionStyles
//        clickIndexBlock:(void(^)(NSInteger clickIndex))block;
        default:
        {
            LxAlertController *alertVc =[LxAlertController lx_alertShowWithTitle:@"" message:@"是否退出应用?" actionTitles:@[@"确定",@"取消"] actionStyles:@[@(UIAlertViewStyleDefault),@(UIAlertActionStyleCancel)] clickIndexBlock:^(NSInteger clickIndex) {
                if (clickIndex == 0) {
                    exit(0);
                }
            }];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
            break;
    }
    
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
    self.progressView.progress = 0;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
    self.progressView.hidden = YES;
    self.progressView.progress = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationLandscapeLeft;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskLandscape;
//}
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
