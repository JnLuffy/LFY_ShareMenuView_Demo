//
//  ShareMenuView.h
//  LFY_ShareMenuView_Demo
//
//  Created by apple on 17/7/4.
//  Copyright © 2017年 com.cooper.dtag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMenuView : UIView

@property(nonatomic, copy) void (^ shareButtonClickedBlock)(NSInteger index);

- (void)hide;
- (void)show;


@end
