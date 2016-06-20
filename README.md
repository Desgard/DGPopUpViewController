# DGPopUpViewController
DGPopUpViewController---卡片式弹出窗口

---
## Description

扁平化卡片式弹出窗口注册页面，思路来自[dribbble的原型图](https://dribbble.com/shots/2770326-Sign-up-prototype)，感谢作者[Sarah](https://dribbble.com/sarahjess)提供思路。
代码思路可以查看我的博文[The Card Interface For Signing Up](https://desgard.com/2016/06/18/DGPopUpViewController/)

This is DGPopUpViewController demo, a flat card pop-up view.
Thanks for designer Sara, whose prototype [drawing in dribbble](https://dribbble.com/shots/2770326-Sign-up-prototype) give me inspiration.
And thanks for [halfrost](https://halfrost.com/#blog)'s help in programming.
If you want to know how to achieve, you can check out this article - [The Card Interface For Signing Up](https://desgard.com/2016/06/18/DGPopUpViewController/).

## Screenshot

<img src="demo20.gif" alt="img" width="240px">

## Introduce

在弹出层View中，我们需要做的就是在上面增加控件。弹出层需要持有的控件有三个：标题Label、自定义TextField、按钮Button。另外，需要他自身需要处理点击按钮正常退出的动画。这种弹出层退出方式与在控制器中的退出方式很显然响应者不同。在用户主动请求退出的过程中，用户主要是以控制器View作为交互对象，而点击Next按钮后的退出时与弹出层View为交互对象。这样写能让我们的代码更清晰，可读性加强。

```Objective-C
#pragma mark - Close Animation
- (void) closeAnimation {
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration: 0.6
                          delay: 0.3
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         self.superview.alpha = 1;
                     }
                     completion: ^(BOOL finished) {
                         [[NSNotificationCenter defaultCenter] postNotificationName: @"end_animation" object: nil];
                         [self removeFromSuperview];
                     }];
    
}
{% endhighlight %}

### 自定义控件

这里用到的自定义有两个，第一个是NEXT的`Button`。仔细观察一下原型图，Button主要有两个特点：

* 渐出动画是在PopUpView之前就开始，而且是独立渐出
* Button的背景色是一种渐变色

对于第一个动效，只需要在PopUpView启动退出动画之前，先执行Button内部的退出动画。动画无论退出还是出现都是类似的`CGAffineTransformMakeScale`效果，无需讲述。

{% highlight ruby %}
#pragma mark - Animation
- (void) pressAnimation {
    NSLog(@"click");
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration: 0.6
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                     }
                     completion: ^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"NEXT_Button" object: nil];
}
```

渐变色的处理我们可以使用`CAGradientLayer`这个类。`CAGradientLayer`是用来生成两种或更多颜色平滑渐变，使用改类的好处在于绘制时使用了硬件加速（[官方文档](https://developer.apple.com/reference/quartzcore/cagradientlayer)）。我们只要依次写出各个关键点，就可以确定颜色的一个渐变方向。直接看代码，很容易就能看懂。

```Objective-C
#pragma mark - Set Color
- (void) setColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.locations = @[@0.3, @0.8];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed: 56 / 255.f green: 195 / 255.f blue: 227 / 255.f alpha: 1].CGColor,
                             (__bridge id)[UIColor colorWithRed: 16 / 255.f green: 156 / 255.f blue: 197 / 255.f alpha: 1].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    [self.layer addSublayer: gradientLayer];
}
```

我们最后来说说自定义的`TextField`，`TextField`我们仅仅是在下方增加了一个类似于进度条的动画。具体的逻辑是这样，当我们手势响应一个`TextField`之后，我们就会启动动画，让进度条滑动到定点位置。而当我们退出响应该TextField的时候，先要检查text部分是否为空，然后在决定进度条是否要保存状态。先给出代码，解释一下。

```Objective-C
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing: (UITextField *)textField {
    // 确定动画类型
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath: @"transform.scale.x"];
    // 确定锚点
    [self.progressLine.layer setAnchorPoint: CGPointMake(0, 0.5)];
    // 持续时间
    basic.duration = 0.3;
    // 重复次数
    basic.repeatCount = 1;
    // 结束后是否删除
    basic.removedOnCompletion = NO;
    // 状态点数值
    basic.fromValue = [NSNumber numberWithFloat: 1];
    basic.toValue = [NSNumber numberWithFloat: 280];
    // 完成时保存状态
    basic.fillMode = kCAFillModeForwards;
    // 增加缓动函数
    basic.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    [self.progressLine.layer addAnimation: basic forKey: nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.textField.text isEqualToString: @""]) {
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath: @"transform.scale.x"];
        [self.progressLine.layer setAnchorPoint: CGPointMake(0, 0.5)];
        basic.duration = 0.3;
        basic.repeatCount = 1;
        basic.removedOnCompletion = NO;
        basic.fromValue = [NSNumber numberWithFloat: 280];
        basic.toValue = [NSNumber numberWithFloat: 1];
        basic.fillMode = kCAFillModeForwards;
        basic.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
        [self.progressLine.layer addAnimation: basic forKey: nil];
    }
}
```


