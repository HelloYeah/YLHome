//
//  CarouselView.h
//
//  Created by 叶良 on 16/3/17.
//  Copyright © 2016年 叶良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarouselView;

@interface CarouselView : UIView
@property (nonatomic,strong) NSMutableArray * dataSouce;
- (void)removeHeaderCover;
@end
