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

/**这个属性用来修改按钮的状态*/
@property(nonatomic, assign) ResponseButtonState rsState;

/**初始化方法
 *@style running状态的表示形式
 *@color 按钮的颜色
 *@frame
 */
- (instancetype)initWithStyle:(ResponseButtonStyle)style color:(UIColor*)color frame:(CGRect)frame;


/**设置超时时间和超时后执行的方法
 *@time 超时时间
 *@complete 超时之后执行的方法，可以为空
 */
- (void)setTimeOut:(NSUInteger)time complete:(void(^)(RSButton*))complete;


/**设置按钮的三个标题
 *@normal 正常可点击状态下的标题
 *@waiting 待定，不可点击状态下的标题
 *@disable 不可用，不可点击状态下的标题
 */
- (void)setTitlesNormal:(NSString *)normal waiting:(NSString *)waiting disable:(NSString *)disable;


@end
