//
//  ViewController.m
//  LFY_ShareMenuView_Demo
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 com.cooper.dtag. All rights reserved.
//

#import "ViewController.h"
#import "ShareMenuView.h"

@interface ViewController ()
@property(nonatomic,strong)ShareMenuView *menuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(50, 50, 100, 50);
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSArray *shareTitleArray = [[NSArray alloc]initWithObjects:@"QQ",@"QQ空间",@"微信",@"朋友圈",@"复制链接", nil ];
    NSArray *shareIconArray = [[NSArray alloc]initWithObjects:@"news_control_center_qq",@"news_control_center_zone",@"news_control_center_wechat",@"news_control_center_wechatQ",@"news_control_center_link",  nil];
    
    _menuView  = [[ShareMenuView alloc]initWithTitleArray:shareTitleArray imageArray:shareIconArray];
    _menuView.shareButtonClickedBlock =  ^(NSInteger index){
        NSLog(@"click index = %li",(long)index);
    };
    
}


- (void)btnAction:(id)sender{
    [_menuView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
