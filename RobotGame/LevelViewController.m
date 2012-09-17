//
//  LevelViewController.m
//  Robots
//
//  Created by Diana Zmuda on 9/7/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "LevelViewController.h"
#import "Level.h"
#import "LevelView.h"
#import "Player.h"
#import <QuartzCore/QuartzCore.h>
#import "ControlView.h"
#import "PlayerView.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        Level *level = [Level new];
        level.lvc = self;
        self.level = level;
        
        self.levelView = [[LevelView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        self.levelView.bounds = CGRectMake(0, 0, 320, 480);
        self.levelView.lvc = self;
        [self.levelView renderGrid];
        
        ControlView *controlView = [[ControlView alloc] initWithFrame:CGRectMake(100, 300, 90, 90)];
        
        controlView.lvc = self;
        
        //initialize your player (using views now, rather than layers)
        self.player = [Player new];
        [self.player beginStats];
        PlayerView *playerView = [[PlayerView alloc] initWithFrame:CGRectMake(72, 72, 72, 72)];
        playerView.lvc = self;
        
        UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [parentView addSubview:self.levelView];
        [parentView addSubview:controlView];
        [parentView addSubview:playerView];
        self.view = parentView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
