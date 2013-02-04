//
//  StatsViewController.h
//  RobotGame
//
//  Created by Diana Zmuda on 2/3/13.
//  Copyright (c) 2013 Diana Zmuda. All rights reserved.
//

@class LevelViewController, ItemView;

@interface StatsViewController : UIViewController

@property (strong, nonatomic) LevelViewController *lvc;

@property (assign, nonatomic) CGRect left;
@property (assign, nonatomic) CGRect right;

@property (strong, nonatomic) ItemView *inv1Item;
@property (strong, nonatomic) ItemView *inv2Item;
@property (strong, nonatomic) ItemView *inv3Item;
@property (strong, nonatomic) ItemView *inv4Item;

-(void)setupView;

@end
