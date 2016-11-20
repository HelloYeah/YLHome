//
//  HomeTableInfoTool.m
//  HelloYeah
//
//  Created by Sekorm on 16/11/17.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "HomeTableInfoTool.h"

@implementation HomeTableInfoTool

static HomeTableInfoTool *homeTableInfoTool = nil;

+ (instancetype)shareInstance
{
    @synchronized (self) {
        if (homeTableInfoTool == nil) {
            homeTableInfoTool = [[self alloc] init];
        }
    }
    
    return homeTableInfoTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (homeTableInfoTool == nil) {
            homeTableInfoTool = [super allocWithZone:zone];
        }
    }
    return homeTableInfoTool;
}

- (id)copy
{
    return homeTableInfoTool;
}

- (id)mutableCopy{
    return homeTableInfoTool;
}

- (NSMutableArray *)dataSouceArray{

    if (_dataSouceArray == nil) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


- (NSMutableArray<NSString *> *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)offsetYArray{
    if (_offsetYArray == nil) {
        _offsetYArray = [NSMutableArray array];
    }
    return _offsetYArray;

}

@end
