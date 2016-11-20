//
//  HomeTableView.h
//  HelloYeah
//
//  Created by Sekorm on 16/10/31.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollToolBar;
@interface HomeTableView : UIView
@property (nonatomic, strong) UIColor *headerColor;
@property (nonatomic, assign) CGFloat tableOriginalY;
@property (nonatomic,strong) ScrollToolBar * scrollToolBar;

- (void)setTableDatasouce:(NSArray *)datasouce;
- (void)setTableOffsetY:(CGFloat)offsetY;
@end
