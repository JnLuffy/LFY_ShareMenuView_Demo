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
    
    _menuView  = [[ShareMenuView alloc]init];
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
