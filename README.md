#仿“支付宝信用”界面展示
##  使用案例
``` objc
    // 修改frame ,需要MDJProgressChat.m 顶部修改字号即可
    CGRect rect = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
    
     NSArray *names = @[@"良好",@"优秀",@"极好"];
    
     MDJProgressChat *chat = [MDJProgressChat sharedProgressChatWithFrame:rect andNames:names andEndValue:0.3];
    [self.view addSubview:chat];

```
![image](https://github.com/XiaoMingZhiDao/AliPayCreditRating/blob/master/1.png)
