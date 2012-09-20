//
//  StatsView.h
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LevelViewController;
@class ItemView;

@interface StatsView : UIView

@property LevelViewController *lvc;

@property CGRect left;
@property CGRect right;

@property ItemView *inv1Item;
@property ItemView *inv2Item;
@property ItemView *inv3Item;
@property ItemView *inv4Item;

-(void)setupView;

@end
