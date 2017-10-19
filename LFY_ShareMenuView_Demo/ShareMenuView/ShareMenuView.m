//
//  ShareMenuView.m
//  LFY_ShareMenuView_Demo
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 com.cooper.dtag. All rights reserved.
//

#import "ShareMenuView.h"
#import "Masonry.h"

#define AnimateDuration 0.4
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ShareMenuHeight 150


//任意颜色宏
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ShareMenuView()

@property(nonatomic, strong) UIButton *backView;
@property(copy,nonatomic) NSArray *titleArray;
@property(copy,nonatomic) NSArray *imageArray;
@end


@implementation ShareMenuView



-(instancetype)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray{
    self = [super init];
    if(self){
        self.titleArray = titleArray;
        self.imageArray = imageArray;
        [self setup];
    }
    return self;
}

-(void)setup{
    
    _backView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.alpha = 0.3;
    _backView.backgroundColor = [UIColor blackColor];
    [_backView addTarget:self action:@selector(backViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ShareMenuHeight);
    self.backgroundColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    

    
    for (int i = 0; i <self.imageArray.count; i ++) {
        
        UIButton *itemView = [UIButton buttonWithType:UIButtonTypeCustom];
        itemView.backgroundColor = [UIColor clearColor];
        itemView.tag = i;
        [itemView addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemView];
        
        //图标
        UIImageView *icon = [[UIImageView alloc]init];
        icon.backgroundColor = [UIColor clearColor];
//        icon.image = [UIImage imageNamed:shareIconArray[i]];
        icon.backgroundColor = randomColor;
        [itemView addSubview:icon];
        
        //标题
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont systemFontOfSize:13.0f];
        title.backgroundColor = [UIColor clearColor];
        [title sizeToFit];
        title.text = self.titleArray[i];
        [itemView addSubview:title];
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@70);
            make.width.equalTo(@(SCREEN_WIDTH*1/4));
            make.left.equalTo(self.mas_left).offset((SCREEN_WIDTH*(i%4)/4));
            make.top.equalTo(self.mas_top).offset(70*(i/4));
            //            if (i == shareIconArray.count - 1) {
            //                make.bottom.equalTo(self.mas_bottom).offset(-10);
            //            }
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@40);
            make.top.equalTo(itemView.mas_top).offset(10);
            make.centerX.equalTo(itemView.mas_centerX);
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(itemView.mas_centerX);
            make.top.equalTo(icon.mas_bottom).offset(5);
            make.bottom.equalTo(itemView.mas_bottom);
        }];
        
    }

    
}

- (void)backViewClicked:(id)sender{
    [self hide];
}

- (void)hide{
    
    [UIView animateWithDuration:AnimateDuration animations:^{
        
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ShareMenuHeight);
        _backView.alpha = 0;

    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];

    }];
}

- (void)show{

    
    [[[UIApplication sharedApplication] keyWindow] addSubview:_backView];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:self aboveSubview:_backView];
    
    [UIView animateWithDuration:AnimateDuration animations:^{
        _backView.alpha = 0.3;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - ShareMenuHeight, SCREEN_WIDTH, ShareMenuHeight);
        
    } completion:^(BOOL finished) {

    }];
}

- (void)share:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (self.shareButtonClickedBlock) {
        self.shareButtonClickedBlock(button.tag);
    }
}


@end
