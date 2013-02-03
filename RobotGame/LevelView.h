//
//  LevelView.h
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class LevelViewController, Arrow, Position;

@interface LevelView : UIView

@property (strong, nonatomic) LevelViewController *lvc;

- (void)renderGrid;

@end
