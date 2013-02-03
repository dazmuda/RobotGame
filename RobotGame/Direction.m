//
//  Direction.m
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Direction.h"
#import "ControlView.h"
#import "LevelViewController.h"
#import "Player+Methods.h"
#import "Position.h"
#import "Level+Methods.h"
#import "LevelView.h"
#import "PlayerView.h"

@implementation Direction

- (id)initWithFrame:(CGRect)frame andCV:(ControlView *)cv andChangeY:(int)y andChangeX:(int)x
{
    self = [super initWithFrame:frame];
    self.adjustsImageWhenHighlighted = NO;
    self.cv = cv;
    self.changeY = y;
    self.changeX = x;
    [self setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(movePlayer) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)movePlayer
{
    //CGPoint newOrigin = self.cv.lvc.player.layer.frame.origin;
    CGPoint newOrigin = self.cv.lvc.player.pv.frame.origin;
    
    //change the position
    self.cv.lvc.player.position.y += self.changeY;
    self.cv.lvc.player.position.x += self.changeX;
    //pick up object or challenge mob
    [self.cv.lvc.level checkPlayerPos:self.cv.lvc.player.position];
    
    //if it isn't a wall then move the screen
    if ([self.cv.lvc.level isItWall:self.cv.lvc.player.position] == FALSE) {
        newOrigin.y += 72*self.changeY;
        newOrigin.x += 72*self.changeX;
        //move the screen
        CGRect newBounds = self.cv.lvc.levelView.bounds;
        newBounds.origin.y += 72*self.changeY;
        newBounds.origin.x += 72*self.changeX;
        [UIView animateWithDuration:.2 animations:^{
            self.cv.lvc.levelView.bounds = newBounds;}];
        
    //if it is a wall then undo that position change
    } else if ([self.cv.lvc.level isItWall:self.cv.lvc.player.position] == TRUE) {
        self.cv.lvc.player.position.y -= self.changeY;
        self.cv.lvc.player.position.x -= self.changeX;
    }
    
    CGRect newFrame = CGRectMake(newOrigin.x,newOrigin.y,72,72);
    
    //move the player
    //self.cv.lvc.player.layer.frame = newFrame;
    self.cv.lvc.player.pv.frame = newFrame;
    [self.cv.lvc.levelView setNeedsDisplay];
    
    //save the player's changed position
    self.cv.lvc.player.x = self.cv.lvc.player.position.x;
    self.cv.lvc.player.y = self.cv.lvc.player.position.y;
    NSLog(@"PLAYER LOC IS (%d, %d)", self.cv.lvc.player.position.x, self.cv.lvc.player.position.y);
}

@end
