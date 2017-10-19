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

@interface ImageWithLabel()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ImageWithLabel

-(instancetype)initImageLabelWithFrame:(CGRect)frame image:(UIImage *)image labelText:(NSString *)labelText{
    self = [super init];
    if(self){
        self.imageView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
            imageView;
        });
        
        self.label = ({
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.text = labelText;
            [self addSubview:label];
            label;
        });
    }
    return self;

}


#pragma mark -- layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
 
    self.imageView.backgroundColor = randomColor;
    

    [self.label sizeToFit];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@40);
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end

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
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@70);
            make.width.equalTo(@(SCREEN_WIDTH*1/4));
            make.left.equalTo(self.mas_left).offset((SCREEN_WIDTH*(i%4)/4));
            make.top.equalTo(self.mas_top).offset(70*(i/4));

        }];

        //frame没起作用！
        ImageWithLabel * imageWithLabel  = [[ImageWithLabel alloc]initImageLabelWithFrame:itemView.frame image:self.imageArray[i] labelText:self.titleArray[i]];
        [itemView addSubview:imageWithLabel];
        
        [imageWithLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(itemView);
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
