# Response Button
* 状况响应按钮，主要用作验证码获取，或者其他点击进行网络请求的按钮，
* 是`UIButton`的子类，可以对外观像修改UIButton那样修改
* 可以在设定的时间超时后执行block,默认block执行前会调用按钮为正常状态

## 调用接口
```Objective-C
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
*@normal 正常状态的标题
*@waiting 待定状态的标题
*@disable 不可用状态的标题
*/
- (void)setTitlesNormal:(NSString *)normal waiting:(NSString *)waiting disable:(NSString *)disable;

```
