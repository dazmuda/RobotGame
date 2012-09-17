//
//  Player.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Position;
@class PlayerView;

@interface Player : NSManagedObject

@property (strong) NSMutableArray *items;
@property (strong) NSMutableDictionary *equipped;

@property double currentHP;
@property int maxHP;
@property int maxShield;
@property int eHit;
@property int mHit;
@property int pHit;
@property int crit;
@property int scrap;
@property int level;
@property double xp;

@property int points;
@property int ePoints;
@property int mPoints;
@property int pPoints;
@property BOOL eBuff;
@property BOOL mBuff;
@property BOOL pBuff;
@property BOOL eMove;
@property BOOL mMove;
@property BOOL pMove;

@property (strong) PlayerView *pv;
@property (strong) Position *position;

-(void)beginStats;

@end
