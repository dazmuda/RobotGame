//
//  Direction.h
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ControlView;

@interface Direction : UIButton

@property NSInteger changeX;
@property NSInteger changeY;
@property ControlView *cv;

- (void)movePlayer;
- (id)initWithFrame:(CGRect)frame andCV:(ControlView *)cv andChangeY:(NSInteger)y andChangeX:(NSInteger)x ;

@end
