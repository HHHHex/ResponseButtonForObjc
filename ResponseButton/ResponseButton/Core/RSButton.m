//
//  RSButton.m
//  ResponseButton
//
//  Created by Heinz on 2017/11/17.
//  Copyright © 2017年 Heinz. All rights reserved.
//

#import "RSButton.h"

typedef void(^Block)(RSButton *);

@interface RSButton()

@property (nonatomic, strong) UIActivityIndicatorView *active;

@end

@implementation RSButton
{
    NSUInteger _timeOut;
    NSUInteger _count;
    NSString *_normal;
    NSString *_waiting;
    NSString *_disable;
    ResponseButtonStyle _rsStyle;
    Block _block;
    NSTimer *_timer;
}

- (instancetype)initWithStyle:(ResponseButtonStyle)style color:(UIColor*)color frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _rsStyle = style;
        self.frame = frame;
        _timeOut = 60;
        _count = 60;
        _normal = @"";
        _waiting = @"";
        _disable = @"";
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setBackgroundImage:[self colorImage:color] forState:UIControlStateNormal];
        [self setBackgroundImage:[self colorImage:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
        [self setBackgroundImage:[self colorImage:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [self setTitle:_normal forState:UIControlStateNormal];
        if (style == RSStyleActive) {
            [self addSubview:self.active];
        }
    }
    return self;
}

- (UIActivityIndicatorView *)active {
    if (_active == nil) {
        _active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _active.frame = self.frame;
        _active.hidesWhenStopped = true;
    }
    return _active;
}


- (void)setTimeOut:(NSUInteger)time complete:(void(^)(RSButton *))complete {
    _timeOut = time;
    _count = time;
    _block = complete;
}


- (void)setTitlesNormal:(NSString *)normal waiting:(NSString *)waiting disable:(NSString *)disable {
    _normal = normal;
    _waiting = waiting;
    _disable = disable;
    [self setTitle:_normal forState:UIControlStateNormal];
    
}


- (void)setRsState:(ResponseButtonState)rsState {
    if (_rsState != rsState) {
        _rsState = rsState;
        if (rsState == RSStateNormal) {//正常状态是可以点击的
            self.enabled = YES;
            [self stopRun];
        } else if (rsState == RSStateWaiting) {//按下状态无法点击
            self.enabled = NO;
            [self stopRun];
            [self setTitle:_waiting forState:UIControlStateDisabled];
        } else if (rsState == RSStateDisable) {//不可用状态无法点击
            self.enabled = NO;
            [self stopRun];
            [self setTitle:_disable forState:UIControlStateDisabled];
        } else if (rsState == RSStateRuning) {//运行状态无法点击
            self.enabled = NO;
            [self startRun];
        }
    }
}

- (void)countTime {
    if (_count == 0) {
        [self stopRun];
        self.rsState = RSStateNormal;
        if (_block) { _block(self); }
    } else {
        _count--;
        if (_rsStyle == RSStyleCount) {
            [self setTitle:[NSString stringWithFormat:@"%lds", _count] forState:UIControlStateDisabled];
        }
    }
}

- (void)startRun {
    if (_rsStyle == RSStyleCount) {
        if (_count != 0) {//不设置超时时间则不执行超时数秒
            [self countTime];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
        }
    } else if (_rsStyle == RSStyleActive) {
        [self setTitle:@"" forState:UIControlStateDisabled];
        [self.active startAnimating];
    }
}
- (void)stopRun {
    if (_rsStyle == RSStyleActive) {
        [self.active stopAnimating];
    }
    if (_timer != nil) {
        _count = _timeOut;
        [_timer invalidate];
        _timer = nil;
    }
}

- (UIImage *)colorImage:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}






@end
