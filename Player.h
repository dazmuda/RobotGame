//
//  Player.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Position.h"
#import "PlayerView.h"

@class Item, World;

@interface Player : NSManagedObject

@property (nonatomic, assign) NSInteger crit;
@property (nonatomic, assign) NSInteger currentHP;
@property (nonatomic, assign) BOOL eBuff;
@property (nonatomic, assign) NSInteger eHit;
@property (nonatomic, assign) BOOL eMove;
@property (nonatomic, assign) NSInteger ePoints;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger maxHP;
@property (nonatomic, assign) NSInteger maxShield;
@property (nonatomic, assign) BOOL mBuff;
@property (nonatomic, assign) NSInteger mHit;
@property (nonatomic, assign) BOOL mMove;
@property (nonatomic, assign) NSInteger mPoints;
@property (nonatomic, assign) BOOL pBuff;
@property (nonatomic, assign) NSInteger pHit;
@property (nonatomic, assign) BOOL pMove;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger pPoints;
@property (nonatomic, assign) NSInteger scrap;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger xp;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, retain) Item *inv1;
@property (nonatomic, retain) Item *inv2;
@property (nonatomic, retain) Item *inv3;
@property (nonatomic, retain) Item *inv4;
@property (nonatomic, retain) Item *leftArm;
@property (nonatomic, retain) Item *rightArm;
@property (nonatomic, retain) World *world;

//not in Coredata
@property (strong, nonatomic) Position *position;
@property (strong, nonatomic) PlayerView *pv;

@end
