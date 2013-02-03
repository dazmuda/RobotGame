//
//  ControlView.h
//  Robots
//
//  Created by Diana Zmuda on 9/11/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

@class LevelViewController;

@interface ControlView : UIView

@property (strong, nonatomic) LevelViewController *lvc;

- (void)makeArrowButtons;

@end
