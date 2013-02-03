//
//  ItemView.h
//  Robots
//
//  Created by Diana Zmuda on 9/14/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class StatsView, Item;

@interface ItemView : UIView

@property StatsView *sv;
@property Item *item;

- (id)initWithFrame:(CGRect)frame andItem:(Item *)item andSV:(StatsView *)sv;

@end
