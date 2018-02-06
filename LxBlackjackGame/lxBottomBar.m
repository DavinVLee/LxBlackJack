

#import "lxBottomBar.h"
#import "Masonry.h"
#import "UIButton+EnlargeEdge.h"
@interface lxBottomBar ()

@property (strong, nonatomic) UIButton *homeBtn;
@property (strong, nonatomic) UILabel *homeLabel;

@property (strong, nonatomic) UIButton *lastStepBtn;
@property (strong, nonatomic) UILabel *lastStepLabel;

@property (strong, nonatomic) UIButton *nextStepBtn;
@property (strong, nonatomic) UILabel *nextStepLabel;

@property (strong, nonatomic) UIButton *refreshBtn;
@property (strong, nonatomic) UILabel *refreshLabel;

@property (strong, nonatomic) UIButton *exitBtn;
@property (strong, nonatomic) UILabel *exitLabel;

@end

@implementation lxBottomBar

- (void)setupDefault
{
    
    
    _homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _homeBtn.adjustsImageWhenHighlighted = YES;
    [_homeBtn setImage:[UIImage imageNamed:@"homePic@2x"] forState:UIControlStateNormal];
    _homeBtn.frame = CGRectMake(20, 7, 30, 30);
    [_homeBtn lx_setEnlargeEdge:10];
    _homeBtn.tag = 1;
    [_homeBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_homeBtn];
    
    UILabel *homdelabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"主页";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment= NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 28, 14);

        label;
        
    });
     [self addSubview:homdelabel];
    [homdelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.top.mas_equalTo(_homeBtn.mas_bottom).mas_offset(-2);
        make.centerX.mas_equalTo(_homeBtn.mas_centerX).mas_offset(0);
    }];
   
    
    
    _lastStepBtn = [[UIButton alloc] init];
    [_lastStepBtn setImage:[UIImage imageNamed:@"backPic@2x"] forState:UIControlStateNormal];
    _lastStepBtn.frame = CGRectMake(20, 7, 30, 30);
    _lastStepBtn.tag = 2;
    [_lastStepBtn lx_setEnlargeEdge:10];
    [_lastStepBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_lastStepBtn];
    
    UILabel *lastStepLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"后退";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment= NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 28, 14);
        
        label;
        
    });
    [self addSubview:lastStepLabel];
    [lastStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.top.mas_equalTo(_lastStepBtn.mas_bottom).mas_offset(-2);
        make.centerX.mas_equalTo(_lastStepBtn.mas_centerX).mas_offset(0);
    }];
    
    _nextStepBtn = [[UIButton alloc] init];
    [_nextStepBtn setImage:[UIImage imageNamed:@"gotoPic1@2x"] forState:UIControlStateNormal];
    _nextStepBtn.frame = CGRectMake(20, 7, 30, 30);
    _nextStepBtn.tag = 3;
    [_nextStepBtn lx_setEnlargeEdge:10];
    [_nextStepBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextStepBtn];
    
    UILabel *nextStepLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"前进";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment= NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 28, 14);
        
        label;
        
    });
    [self addSubview:nextStepLabel];
    [nextStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.top.mas_equalTo(_nextStepBtn.mas_bottom).mas_offset(-2);
        make.centerX.mas_equalTo(_nextStepBtn.mas_centerX).mas_offset(0);
    }];
    
    
    _refreshBtn = [[UIButton alloc] init];
    [_refreshBtn setImage:[UIImage imageNamed:@"refreshPic@2x"] forState:UIControlStateNormal];
    _refreshBtn.tag = 4;
    [_refreshBtn lx_setEnlargeEdge:10];
    [_refreshBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _refreshBtn.frame = CGRectMake(20, 7, 30, 30);
    [self addSubview:_refreshBtn];
    
    UILabel *refreshLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"刷新";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment= NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 28, 14);
        
        label;
        
    });
    [self addSubview:refreshLabel];
    [refreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.top.mas_equalTo(_refreshBtn.mas_bottom).mas_offset(-2);
        make.centerX.mas_equalTo(_refreshBtn.mas_centerX).mas_offset(0);
    }];
    
    _exitBtn = [[UIButton alloc] init];
    [_exitBtn setImage:[UIImage imageNamed:@"exit@2x"] forState:UIControlStateNormal];
    _exitBtn.frame = CGRectMake(20, 7, 30, 30);
    [_exitBtn lx_setEnlargeEdge:10];
    _exitBtn.tag = 5;
    [_exitBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_exitBtn];
    
    UILabel *exitLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"退出";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment= NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 28, 14);
        
        label;
        
    });
    [self addSubview:exitLabel];
    [exitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 14));
        make.top.mas_equalTo(_exitBtn.mas_bottom).mas_offset(-2);
        make.centerX.mas_equalTo(_exitBtn.mas_centerX).mas_offset(0);
    }];
    
    
    CGFloat width = mScreenWidth;
    CGFloat space = (width - 5 * 30) / 6.f;
    [_homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(space);
        make.top.mas_equalTo(self.mas_top).mas_offset(1);
        make.right.mas_equalTo(_lastStepBtn.mas_left).mas_offset(-space);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_lastStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.mas_top).mas_offset(1);
        make.right.mas_equalTo(_nextStepBtn.mas_left).mas_offset(-space);
        make.left.mas_equalTo(_homeBtn.mas_right).mas_offset(space);
    }];
    
    [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.mas_offset(1);
        make.left.mas_equalTo(_lastStepBtn.mas_right).mas_offset(space);
        make.right.mas_equalTo(_refreshBtn.mas_left).mas_offset(-space);
    }];
    
    [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.mas_top).mas_offset(1);
        make.left.mas_equalTo(_nextStepBtn.mas_right).mas_offset(space);
        make.right.mas_equalTo(_exitBtn.mas_left).mas_offset(-space);
    }];
    
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.mas_offset(1);
        make.left.mas_equalTo(_refreshBtn.mas_right).mas_offset(space);
        make.right.mas_equalTo(self.mas_right).mas_offset(-space);
    }];
    
    
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = mScreenWidth;
    CGFloat space = (width - 5 * 30) / 6.f;
    [_homeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(space);
        make.right.mas_equalTo(_lastStepBtn.mas_left).mas_offset(-space);
    }];
    
    [_lastStepBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nextStepBtn.mas_left).mas_offset(-space);
        make.left.mas_equalTo(_homeBtn.mas_right).mas_offset(space);
    }];
    
    [_nextStepBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lastStepBtn.mas_right).mas_offset(space);
        make.right.mas_equalTo(_refreshBtn.mas_left).mas_offset(-space);
    }];
    
    [_refreshBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nextStepBtn.mas_right).mas_offset(space);
        make.right.mas_equalTo(_exitBtn.mas_left).mas_offset(-space);
    }];
    
    [_exitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(_refreshBtn.mas_right).mas_offset(space);
         make.right.mas_equalTo(self.mas_right).mas_offset(-space);
    }];
}

- (void)btnClicked:(UIButton *)btn
{
    if (_delegate) {
        [_delegate btnClickIndex:btn.tag];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
