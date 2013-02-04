//
//  ControlView.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "ControlView.h"
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
    }
    return self;
}

- (void)makeArrowButtons
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    Direction *upDirection = [[Direction alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height/3) andCV:self andChangeY:-1 andChangeX:0];
    [self addSubview:upDirection];
    Direction *downDirection = [[Direction alloc] initWithFrame:CGRectMake(0, 2*screenSize.height/3, screenSize.width, screenSize.height/3) andCV:self andChangeY:1 andChangeX:0];
    [self addSubview:downDirection];
    Direction *leftDirection = [[Direction alloc] initWithFrame:CGRectMake(0, screenSize.height/3, screenSize.width/2 -40, screenSize.height/3) andCV:self andChangeY:0 andChangeX:-1];
    [self addSubview:leftDirection];
    Direction *rightDirection = [[Direction alloc] initWithFrame:CGRectMake(screenSize.width/2 +75, screenSize.height/3, screenSize.width/2 -40, screenSize.height/3) andCV:self andChangeY:0 andChangeX:1];
    [self addSubview:rightDirection];
    UIButton *worldButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width-50, screenSize.height-50, 50, 50)];
    [worldButton addTarget:self.lvc.wvc action:@selector(exitedGame) forControlEvents:UIControlEventTouchUpInside];
    [worldButton setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    [self addSubview:worldButton];
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
