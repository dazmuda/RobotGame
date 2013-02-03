//
//  Direction.h
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class ControlView;

@interface Direction : UIButton

@property (assign, nonatomic) NSInteger changeX;
@property (assign, nonatomic) NSInteger changeY;
@property (strong, nonatomic) ControlView *cv;

- (void)movePlayer;
- (id)initWithFrame:(CGRect)frame andCV:(ControlView *)cv andChangeY:(NSInteger)y andChangeX:(NSInteger)x ;

@end
