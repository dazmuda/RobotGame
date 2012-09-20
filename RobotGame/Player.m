//
//  Player.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "Player.h"
#import "Item.h"
#import "World.h"
#import "Position.h"
#import "Score.h"
#import "DataStore.h"

@implementation Player

@dynamic currentHP;
@dynamic maxHP;
@dynamic maxShield;
@dynamic scrap;
@dynamic level;
@dynamic xp;
@dynamic eHit;
@dynamic mHit;
@dynamic pHit;
@dynamic mPoints;
@dynamic ePoints;
@dynamic pPoints;
@dynamic points;
@dynamic eBuff;
@dynamic mBuff;
@dynamic pBuff;
@dynamic crit;
@dynamic eMove;
@dynamic mMove;
@dynamic pMove;
@dynamic world;
@dynamic leftArm;
@dynamic rightArm;
@dynamic x;
@dynamic y;
@dynamic inv1;
@dynamic inv2;
@dynamic inv3;
@dynamic inv4;

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
    
    self.x = 1;
    self.y = 1;
    //right now x and y aren't being changed or saved
    
    self.rightArm = [Item newWithType:2 andDamage:1];
    self.leftArm = [Item newWithType:1 andDamage:1];
    [self loadPosition];
}

-(void)loadPosition {
    self.position = [Position withX:self.x andY:self.y];
}

-(BOOL)didLevelUp {
    int requiredXP = self.level*50;
    if (self.xp >=requiredXP) {
        self.xp -=requiredXP;
        self.level += 1;
        self.points += 1;
        self.crit += 1;
        self.maxHP += self.level*2;
        self.maxShield += self.level;
        self.currentHP = self.maxHP;
        self.world.score.level += 1;
        [DataStore save];
        return TRUE;
    } else {
        return FALSE;
    }
}

@end
