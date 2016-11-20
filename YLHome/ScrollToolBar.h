//
//  ScrollToolBar.h
//  HelloYeah
//
//  Created by Sekorm on 16/10/31.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScrollToolBarNotificationKey @"kScrollToolBarChangeSelectedIndex"
@interface ScrollToolBar : UIScrollView
@property (nonatomic,strong) NSArray<NSString *> *itemArray;
@property (nonatomic,assign) NSInteger  selectedIndex;

@end
