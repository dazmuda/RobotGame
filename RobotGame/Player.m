//
//  Player.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Player.h"
#import <QuartzCore/QuartzCore.h>
#import "Position.h"
#import "Item.h"

@implementation Player

-(void)beginStats {
    self.currentHP = 20;
    self.maxHP = 20;
    self.maxShield = 10;
    self.eHit = 2;
    self.mHit = 2;
    self.pHit = 2;
    self.crit = 1;
    self.scrap = 10;
    self.level = 1;
    self.xp = 0;
    
    self.points = 1;
    self.ePoints = 0;
    self.mPoints = 0;
    self.pPoints = 0;
    self.eBuff = FALSE;
    self.mBuff = FALSE;
    self.pBuff = FALSE;
    self.eMove = FALSE;
    self.mMove = FALSE;
    self.pMove = FALSE;
    
    self.items = [NSMutableArray new];
    Item *item1 = [[Item alloc] initWithName:@"Lame Electric Gun" andType:1 andDamage:1];
    Item *item2 = [[Item alloc] initWithName:@"Lame Magnetic Gun" andType:2 andDamage:1];
    self.equipped = [[NSMutableDictionary alloc] initWithObjects:@[ item1, item2 ] forKeys:@[ @"left", @"right" ]];
    self.position = [Position withX:1 andY:1];
}

@end
