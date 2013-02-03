//
//  StatsView.h
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class LevelViewController;
@class ItemView;

@interface StatsView : UIView

@property (strong, nonatomic) LevelViewController *lvc;
@property (strong, nonatomic) UIViewController *vc;

@property (assign, nonatomic) CGRect left;
@property (assign, nonatomic) CGRect right;

@property (strong, nonatomic) ItemView *inv1Item;
@property (strong, nonatomic) ItemView *inv2Item;
@property (strong, nonatomic) ItemView *inv3Item;
@property (strong, nonatomic) ItemView *inv4Item;

-(void)setupView;

@end
