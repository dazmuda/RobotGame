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
    //int insideRight = CGRectIntersectsRect(self.frame, self.sv.rightArm.frame);
    //int insideLeft = CGRectIntersectsRect(self.frame, self.sv.leftArm.frame);
    int insideRight = CGRectIntersectsRect(self.frame, self.sv.right);
    int insideLeft = CGRectIntersectsRect(self.frame, self.sv.left);
    int insideInv = CGRectIntersectsRect(self.frame, self.sv.inv);
    if (insideRight == 1) {
        self.frame = CGRectMake(50, 100, 50, 50);
        //self.layer.sublayers = nil;
        if ([self.player.items containsObject:self.item] == TRUE) {
            [self.player.items addObject:[self.player.equipped objectForKey:@"right"]];
            [self.player.items removeObject:self.item];
        } else {
            NSArray *keys = [self.player.equipped allKeysForObject:self.item];
            for (NSString* key in keys) {
                [self.player.equipped removeObjectForKey:key];
            }
        }
        [self.player.equipped setValue:self.item forKey:@"right"];
        
    }
    if (insideLeft == 1) {
        //lock to spot!
        self.frame = CGRectMake(0, 100, 50, 50);
        
        //if the item was in your inventory
        if ([self.player.items containsObject:self.item] == TRUE) {
            //place old equipt in inv
            [self.player.items addObject:[self.player.equipped objectForKey:@"left"]];
            //place inv item as equipt
            //[self.player.equipped setValue:self.item forKey:@"left"];
            //remove item from inv
            [self.player.items removeObject:self.item];
            
            //if the item was equipped
        } else {
            //find out which hand it was in
            NSArray *keys = [self.player.equipped allKeysForObject:self.item];
            for (NSString* key in keys) {
                //unequ from other hand
                [self.player.equipped removeObjectForKey:key];
                //equip it in the left hand
                //[self.player.equipped setValue:self.item forKey:@"left"];
            }
        }
        [self.player.equipped setValue:self.item forKey:@"left"];
    }
    if (insideInv == 1) {
        //lock to spot!
        self.frame = CGRectMake(0, 50, 50, 50);
        //make sure you are not going inv to inv
        if ([self.player.items containsObject:self.item] == FALSE) {
            //add the object to your inventory
            [self.player.items addObject:self.item];
            //find which arm held the object
            NSArray *keys = [self.player.equipped allKeysForObject:self.item];
            //and remove that object
            for (NSString* key in keys) {
                [self.player.equipped removeObjectForKey:key];
            }
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
