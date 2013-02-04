//
//  LevelViewController.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class Level, LevelView, Player, World, WorldViewController;
#import "FightViewController.h"

@interface LevelViewController : UIViewController <FightViewDelegate>

@property (strong, nonatomic) Level *level;
@property (strong, nonatomic) LevelView *levelView;
@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) World *world;
@property (strong, nonatomic) WorldViewController *wvc;

- (id)initWithWorld:(World *)world andWVC:(WorldViewController *)wvc;

//yod don't have to declare these methods since you're a delegate that def has these methods
//-(void)diedInCombat;
//-(void)wonInCombat;

@end
