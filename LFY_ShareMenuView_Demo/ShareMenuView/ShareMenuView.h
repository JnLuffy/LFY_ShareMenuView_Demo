//
//  ShareMenuView.h
//  LFY_ShareMenuView_Demo
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 com.cooper.dtag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWithLabel : UIView

/**
 图片和文字一起的View

 @param frame 指定位置和尺寸
 @param image 图片
 @param labelText 图片描述
 @return ImageWithLabel
 */
-(instancetype)initImageLabelWithFrame:(CGRect)frame image:(UIImage *)image labelText:(NSString *)labelText;

@end



@interface ShareMenuView : UIView


@property(nonatomic, copy) void (^ shareButtonClickedBlock)(NSInteger index);

- (void)hide;
- (void)show;


/**
 分享面板的构造方法

 @param titleArray 分享app的名称数组
 @param imageArray 分享app图标数组
 @return ShareMenuView
 */
-(instancetype)initWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;

@end
