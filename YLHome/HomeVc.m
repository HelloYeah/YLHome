//
//  HomeVc.m
//  XRCarouselViewDemo
//
//  Created by Sekorm on 16/10/31.
//  Copyright © 2016年 叶良. All rights reserved.
//

#import "HomeVc.h"
#import "CarouselView.h"
@interface HomeVc ()
@property (nonatomic, strong) CarouselView *carouselView;
@end

@implementation HomeVc

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 20 , SCREEN_WIDTH,SCREEN_HEIGHT  -  20 - 49)];
    [self.view addSubview:self.carouselView];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [_carouselView removeHeaderCover];
}

@end
