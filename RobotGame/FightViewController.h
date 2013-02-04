//
//  FightViewController.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/3/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

@class Player, Mob, LevelViewController;

@protocol FightViewDelegate <NSObject>

- (void)diedInCombat;
- (void)wonInCombat;

@end

@interface FightViewController : UIViewController

@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) Mob *mob;
//@property (weak, nonatomic) LevelViewController *lvc;
@property (weak, nonatomic) NSObject <FightViewDelegate> *delegate;

- (void)setupWithBlock:(void(^)(void))block;
- (id)initWithMob:(Mob *)mob andPlayer:(Player *)player;

@end
