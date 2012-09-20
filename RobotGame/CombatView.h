//
//  CombatView.h
//  Robots
//
//  Created by Diana Zmuda on 9/10/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;
@class Mob;
@class LevelViewController;

@protocol CombatViewDelegate <NSObject>

-(void)diedInCombat;
-(void)wonInCombat;

@end

@interface CombatView : UIView

@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) Mob *mob;
//@property (weak, nonatomic) LevelViewController *lvc;
@property (weak, nonatomic) NSObject <CombatViewDelegate> *delegate;

-(void)setupWithBlock:(void(^)(void))block;

@end
