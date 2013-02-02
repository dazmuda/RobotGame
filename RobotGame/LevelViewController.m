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
#import "Player.h"
#import "ControlView.h"
#import "PlayerView.h"
#import "DataStore.h"
#import "World.h"
#import "WorldViewController.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(id)initWithWorld:(World*)world andWVC:(WorldViewController*)wvc {
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
    
    ControlView *controlView = [[ControlView alloc] initWithFrame:CGRectMake(120, 380, 200, 100)];
    controlView.lvc = self;
    [controlView makeArrowButtons];
    
    PlayerView *playerView = [[PlayerView alloc] initWithFrame:CGRectMake(72, 72, 72, 72)];
    playerView.lvc = self;
    
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [parentView addSubview:self.levelView];
    [parentView addSubview:controlView];
    [parentView addSubview:playerView];
    self.view = parentView;
    
    return self;
}

-(void)diedInCombat {
    //dismissing combatview
    [self dismissViewControllerAnimated:YES completion:^{
        //call a method inside of the worldviewcontroller!!!
        [self.wvc diedInWorld:self.world];
    }];
}

-(void)wonInCombat {
    [self dismissViewControllerAnimated:YES completion:nil];
    [DataStore save];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
