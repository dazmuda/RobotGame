//
//  ItemView.h
//  Robots
//
//  Created by Diana Zmuda on 9/14/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class StatsViewController, Item;

@interface ItemView : UIView

@property StatsViewController *svc;
@property Item *item;

- (id)initWithFrame:(CGRect)frame andItem:(Item *)item andSV:(StatsViewController *)svc;

@end
