//
//  CustomScrollView.m
//  HelloYeah
//
//  Created by Sekorm on 16/11/2.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "CustomCollectionView.h"

@implementation CustomCollectionView


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.shouldReceiveGesture) {
        return self.shouldReceiveGesture(gestureRecognizer);
    }
    return YES;
}

@end
