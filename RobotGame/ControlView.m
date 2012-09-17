//
//  ControlView.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "ControlView.h"
#import <QuartzCore/QuartzCore.h>
#import "LevelViewController.h"
#import "Player.h"
#import "LevelView.h"
#import "Position.h"
#import "Level.h"
#import "Square.h"
#import "Mob.h"
#import "Item.h"
#import "Direction.h"

@implementation ControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self makeArrowButtons];
    }
    return self;
}

- (void) makeArrowButtons {
    Direction *upDirection = [[Direction alloc] initWithFrame:CGRectMake(30, 0, 30, 30) andCV:self andChangeY:-1 andChangeX:0];
    [self addSubview:upDirection];
    Direction *downDirection = [[Direction alloc] initWithFrame:CGRectMake(30, 60, 30, 30) andCV:self andChangeY:1 andChangeX:0];
    [self addSubview:downDirection];
    Direction *leftDirection = [[Direction alloc] initWithFrame:CGRectMake(0, 30, 30, 30) andCV:self andChangeY:0 andChangeX:-1];
    [self addSubview:leftDirection];
    Direction *rightDirection = [[Direction alloc] initWithFrame:CGRectMake(60, 30, 30, 30) andCV:self andChangeY:0 andChangeX:1];
    [self addSubview:rightDirection];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
