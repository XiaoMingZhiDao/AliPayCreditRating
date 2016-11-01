//
//  ViewController.m
//  AliPayCreditRating
//
//  Created by MDJ on 2016/11/1.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "ViewController.h"
#import "MDJProgressChat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
    
    NSArray *names = @[@"良好",@"优秀",@"极好"];
    
    MDJProgressChat *chat = [MDJProgressChat sharedProgressChatWithFrame:rect andNames:names andEndValue:0.3];
    [self.view addSubview:chat];
}


@end
