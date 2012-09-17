//
//  ItemView.h
//  Robots
//
//  Created by Diana Zmuda on 9/14/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatsView;
@class Player;
@class Item;

@interface ItemView : UIView

@property StatsView* sv;
@property Item* item;
@property Player* player;

- (id)initWithFrame:(CGRect)frame andItem:(Item*)item;

@end
