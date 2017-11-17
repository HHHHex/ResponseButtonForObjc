//
//  RSButton.h
//  ResponseButton
//
//  Created by Heinz on 2017/11/17.
//  Copyright © 2017年 Heinz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RSStateNormal,
    RSStateWaiting,
    RSStateDisable,
    RSStateRuning
} ResponseButtonState;

typedef enum : NSUInteger {
    RSStyleCount,
    RSStyleActive
} ResponseButtonStyle;

@interface RSButton : UIButton

@property(nonatomic, assign) ResponseButtonState rsState;

- (instancetype)initWithStyle:(ResponseButtonStyle)style color:(UIColor*)color frame:(CGRect)frame;

- (void)setTimeOut:(NSUInteger)time complete:(void(^)(RSButton*))complete;

- (void)setTitlesNormal:(NSString *)normal waiting:(NSString *)waiting disable:(NSString *)disable;


@end
