//
//  ItemView.m
//  Robots
//
//  Created by Diana Zmuda on 9/14/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "ItemView.h"
#import "StatsViewController.h"
#import "Player.h"
#import "Item+Methods.h"
#import "LevelViewController.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andItem:(Item *)item andSV:(StatsViewController *)svc
{
    self = [super initWithFrame:frame];
    //set the item
    self.item = item;
    self.svc = svc;
    
    //place a picture of the item
//    CALayer *itemLayer = [CALayer new];
//    itemLayer.bounds = CGRectMake(0,0,50,50);
//    itemLayer.frame = CGRectMake(0,0,50,50);
//    UIImage *itemImage = [UIImage imageNamed:@"phit.png"];
//    itemLayer.contents = (__bridge id)([itemImage CGImage]);
//    [self.layer addSublayer:itemLayer];
    
    //place a pic using the item's layer
    [self.item setupLayer];
    self.item.layer.frame = CGRectMake(0,0,50,50);
    [self.layer addSublayer:self.item.layer];
    
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *someTouch = [touches anyObject];
    CGPoint touchPoint = [someTouch locationInView:self.svc.view];
    int newX = touchPoint.x;
    int newY = touchPoint.y;
    self.frame = CGRectMake(newX-25, newY-25, 50, 50);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if the item was dragged into an arm spot
    BOOL insideRight = CGRectContainsPoint(self.svc.right, self.center);
    BOOL insideLeft = CGRectContainsPoint(self.svc.left, self.center);
    
    //try to put it inside right arm
    if (insideRight) {
        //lock to right arm spot
        self.frame = self.svc.right;
        //your item is in the left arm
        if (self.item == self.svc.lvc.player.leftArm) {
            //place the right arm item in your left arm
            self.svc.lvc.player.leftArm = self.svc.lvc.player.rightArm;
            //place the current item in the right arm
            self.svc.lvc.player.rightArm = self.item;
            [self.svc setupView];
        //your item is in the first inv slot
        } else if (self.item == self.svc.lvc.player.inv1) {
            //place the right arm item in your inv slot
            self.svc.lvc.player.inv1 = self.svc.lvc.player.rightArm;
            self.svc.lvc.player.rightArm = self.item;
            [self.svc setupView];
        } else if (self.item == self.svc.lvc.player.inv2) {
            self.svc.lvc.player.inv2 = self.svc.lvc.player.rightArm;
            self.svc.lvc.player.rightArm = self.item;
            [self.svc setupView];
        } else if (self.item == self.svc.lvc.player.inv3) {
            self.svc.lvc.player.inv3 = self.svc.lvc.player.rightArm;
            self.svc.lvc.player.rightArm = self.item;
            [self.svc setupView];
        } else if (self.item == self.svc.lvc.player.inv4) {
            self.svc.lvc.player.inv4 = self.svc.lvc.player.rightArm;
            self.svc.lvc.player.rightArm = self.item;
            [self.svc setupView];
        }
    }
    
    //try to put it inside left arm
    if (insideLeft == 1) {
        //lock to left arm spot
        self.frame = self.svc.left;
        //your item is in the right arm
        if (self.item == self.svc.lvc.player.rightArm) {
            //place the left arm item in your right arm
            self.svc.lvc.player.rightArm = self.svc.lvc.player.leftArm;
            //place the current item in the left arm
            self.svc.lvc.player.leftArm = self.item;
            [self.svc setupView];
        //your item is in the first inv slot
        } else if (self.item == self.svc.lvc.player.inv1) {
            //place the left arm item in your inv slot
            self.svc.lvc.player.inv1 = self.svc.lvc.player.leftArm;
            self.svc.lvc.player.leftArm = self.item;
            [self.svc setupView];
        } else if (self.item == self.svc.lvc.player.inv2) {
            self.svc.lvc.player.inv2 = self.svc.lvc.player.leftArm;
            self.svc.lvc.player.leftArm = self.item;
            [self.svc setupView];
        } else if (self.item == self.svc.lvc.player.inv3) {
            self.svc.lvc.player.inv3 = self.svc.lvc.player.leftArm;
            self.svc.lvc.player.leftArm = self.item;
            [self.svc setupView];
        } else if (self.item == self.svc.lvc.player.inv3) {
            self.svc.lvc.player.inv3 = self.svc.lvc.player.leftArm;
            self.svc.lvc.player.leftArm = self.item;
            [self.svc setupView];
        }

    }
    
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
