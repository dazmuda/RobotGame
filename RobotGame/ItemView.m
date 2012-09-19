//
//  ItemView.m
//  Robots
//
//  Created by Diana Zmuda on 9/14/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "ItemView.h"
#import "StatsView.h"
#import <QuartzCore/QuartzCore.h>
#import "Player.h"
#import "Item.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andItem:(Item*)item {
    self = [super initWithFrame:frame];
    //set the item
    self.item = item;
    
    //place a picture of the item
    CALayer *itemLayer = [CALayer new];
    itemLayer.bounds = CGRectMake(0,0,50,50);
    itemLayer.frame = CGRectMake(0,0,50,50);
    UIImage *itemImage = [UIImage imageNamed:@"red.png"];
    itemLayer.contents = (__bridge id)([itemImage CGImage]);
    [self.layer addSublayer:itemLayer];
    
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *someTouch = [touches anyObject];
    CGPoint touchPoint = [someTouch locationInView:self.sv];
    int newX = touchPoint.x;
    int newY = touchPoint.y;
    self.frame = CGRectMake(newX-25, newY-25, 50, 50);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //if the item was dragged into an arm spot
    BOOL insideRight = CGRectContainsPoint(self.sv.right, self.center);
    BOOL insideLeft = CGRectContainsPoint(self.sv.left, self.center);
    BOOL insideInv = CGRectContainsPoint(self.sv.inv, self.center);
    
    //place these items into a dictionary
    //have item
    
    if (insideRight) {
        self.frame = CGRectMake(50, 100, 50, 50);
        //if the item is in your inventory
        if ([self.player.inventory containsObject:self.item]) {
            //place the current right arm item in inv
            [self.player.inventory addObject:self.player.rightArm];
            //remove the current item from inventory
            [self.player.inventory removeObject:self.item];
            //place current item in right arm slot
            self.player.rightArm = self.item;
            
        //if the current item is in your left arm
        } else if (self.item == self.player.leftArm) {
            //switch the right and left arm items
            self.player.leftArm = self.player.rightArm;
            self.player.rightArm = self.item;
        }
        
    }
    if (insideLeft == 1) {
        //lock to spot!
        self.frame = CGRectMake(0, 100, 50, 50);
        
        //if the item was in your inventory
        if ([self.player.inventory containsObject:self.item]) {
            //place old equipt in inv
            [self.player.inventory addObject:self.player.leftArm];
            //remove item from inv
            [self.player.inventory removeObject:self.item];
            //place current item in left arm slot
            self.player.leftArm = self.item;
            
        //if the item was equipped in your right arm
        } else if (self.item == self.player.rightArm) {
            self.player.rightArm = self.player.leftArm;
            self.player.leftArm = self.item;
        }

    }
    if (insideInv == 1) {
        //make sure you are not going inv to inv
        if ([self.player.inventory containsObject:self.item] == FALSE) {
            //lock to spot
            self.frame = CGRectMake(0, 50, 50, 50);
            //add the object to your inventory
            [self.player.inventory addObject:self.item];
            //remove the object from left if it was there
            
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
