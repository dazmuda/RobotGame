//
//  Player+Methods.m
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Player+Methods.h"
#import "Item+Methods.h"
#import "Position.h"
#import "World.h"
#import "Score.h"
#import "DataStore.h"

@implementation Player (Methods)

- (void)beginStats {
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

- (void)loadPosition {
    self.position = [Position withX:self.x andY:self.y];
}

- (BOOL)didLevelUp {
    int requiredXP = self.level*50;
    if (self.xp >=requiredXP) {
        self.xp -=requiredXP;
        self.level += 1;
        self.points += 1;
        self.crit += 1;
        self.maxHP += self.level*2;
        self.maxShield += self.level;
        self.currentHP = self.maxHP;
        self.world.score.level = self.world.score.level + 1;
        [DataStore save];
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)increaseEPoints {
    if (self.points >0) {
        self.ePoints += 1;
        self.points -= 1;
        self.eHit += 1;
        self.crit += 1;
        if (self.ePoints == 3) {
            self.eBuff = TRUE;
        }
        if (self.ePoints == 6) {
            self.eMove = TRUE;
        }
    }
}

- (void)increaseMPoints {
    if (self.points >0) {
        self.mPoints += 1;
        self.points -= 1;
        self.mHit += 1;
        self.maxShield += 1;
        if (self.mPoints == 3) {
            self.mBuff = TRUE;
        }
        if (self.mPoints == 6) {
            self.mMove = TRUE;
        }
    }
}

- (void)increasePPoints {
    if (self.points >0) {
        self.pPoints += 1;
        self.points -= 1;
        self.pHit += 1;
        self.maxHP += 2;
        if (self.mPoints == 3) {
            self.mBuff = TRUE;
        }
        if (self.mPoints == 6) {
            self.mMove = TRUE;
        }
    }
}

@end
