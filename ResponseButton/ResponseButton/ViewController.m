//
//  ViewController.m
//  ResponseButton
//
//  Created by Heinz on 2017/11/17.
//  Copyright © 2017年 Heinz. All rights reserved.
//

#import "ViewController.h"
#import "RSButton.h"

@interface ViewController ()

@end

@implementation ViewController
{
    RSButton *_button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIColor *color = [UIColor colorWithRed:25/255. green:191/255. blue:114/255. alpha:1];
    CGRect frame = CGRectMake(0, 0, 120, 50);
    _button = [[RSButton alloc] initWithStyle:RSStyleActive color:color frame:frame];
    [self.view addSubview:_button];
    _button.center = self.view.center;
    [_button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitlesNormal:@"normal" waiting:@"waiting" disable:@"disable"];
    [_button setTimeOut:10 complete:^(RSButton *sender) {
        NSLog(@"button time out");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tap:(RSButton *)sender {
    sender.rsState = RSStateRuning;
}



- (IBAction)left:(UIButton *)sender {
    _button.rsState = RSStateNormal;
}
- (IBAction)center:(UIButton *)sender {
    _button.rsState = RSStateWaiting;
}
- (IBAction)right:(UIButton *)sender {
    _button.rsState = RSStateDisable;
}

@end
