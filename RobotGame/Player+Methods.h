//
//  Player+Methods.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/2/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

#import "Player.h"
#import "Position.h"
#import "PlayerView.h"

@interface Player (Methods)

- (void)beginStats;
- (BOOL)didLevelUp;
- (void)loadPosition;
- (void)increaseEPoints;
- (void)increaseMPoints;
- (void)increasePPoints;

@end
