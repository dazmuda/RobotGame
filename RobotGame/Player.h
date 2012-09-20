//
//  Player.h
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, World, Position, PlayerView;

@interface Player : NSManagedObject

@property int currentHP;
@property int maxHP;
@property int maxShield;
@property int scrap;
@property int level;
@property int xp;
@property int eHit;
@property int mHit;
@property int pHit;
@property int mPoints;
@property int ePoints;
@property int pPoints;
@property int points;
@property BOOL eBuff;
@property BOOL mBuff;
@property BOOL pBuff;
@property int crit;
@property BOOL eMove;
@property BOOL mMove;
@property BOOL pMove;
@property int x;
@property int y;
@property (nonatomic, retain) World *world;
@property (nonatomic, retain) Item *leftArm;
@property (nonatomic, retain) Item *rightArm;
@property (nonatomic, retain) Item *inv1;
@property (nonatomic, retain) Item *inv2;
@property (nonatomic, retain) Item *inv3;
@property (nonatomic, retain) Item *inv4;

@property Position *position;
@property (strong) PlayerView *pv;
-(void)beginStats;
-(BOOL)didLevelUp;
-(void)loadPosition;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addInventoryObject:(Item *)value;
- (void)removeInventoryObject:(Item *)value;

@end
