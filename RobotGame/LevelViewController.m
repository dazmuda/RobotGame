//
//  LevelViewController.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "LevelViewController.h"
#import "Level+Methods.h"
#import "LevelView.h"
#import "Player+Methods.h"
#import "ControlView.h"
#import "PlayerView.h"
#import "DataStore.h"
#import "World.h"
#import "WorldViewController.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (id)initWithWorld:(World *)world andWVC:(WorldViewController *)wvc
{
    self = [super init];
    self.world = world;
    self.wvc = wvc;
    
    self.level = self.world.level;
    self.level.lvc = self;
    self.player = self.world.player;
    
    self.levelView = [[LevelView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.levelView.bounds = CGRectMake(0, 0, 320, 480);
    self.levelView.lvc = self;
    [self.levelView renderGrid];
    
    ControlView *controlView = [[ControlView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    controlView.lvc = self;
    [controlView makeArrowButtons];
    
    [self.player loadPosition];
    PlayerView *playerView = [[PlayerView alloc] initWithFrame:CGRectMake(2*72, 3*72, 72, 72)];
    playerView.lvc = self;
    
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [parentView addSubview:self.levelView];
    [parentView addSubview:controlView];
    [parentView addSubview:playerView];
    self.view = parentView;
    
    CGRect newBounds = self.levelView.bounds;
    newBounds.origin.x = (self.player.position.x - 2)*72;
    newBounds.origin.y = (self.player.position.y - 3)*72;
    self.levelView.bounds = newBounds;
    
    return self;
}

- (void)diedInCombat
{
    //dismissing combatview
    [self dismissViewControllerAnimated:YES completion:^{
        //call a method inside of the worldviewcontroller!!!
        [self.wvc diedInWorld:self.world];
    }];
}

- (void)wonInCombat
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [DataStore save];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
