//
//  UpgradeView.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/21/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "UpgradeView.h"
#import "DataStore.h"
#import "LevelViewController.h"
#import "Player+Methods.h"

@interface UpgradeView () <AVAudioPlayerDelegate>

@property (strong, nonatomic) UILabel *epoints;
@property (strong, nonatomic) UILabel *mpoints;
@property (strong, nonatomic) UILabel *ppoints;
@property (strong, nonatomic) UILabel *points;

@property (strong, nonatomic) AVAudioPlayer* zapPlayer;
@property (strong, nonatomic) AVAudioPlayer* bangPlayer;
@property (strong, nonatomic) AVAudioPlayer* laserPlayer;

@end

@implementation UpgradeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *bgImage = [UIImage imageNamed:@"stats.png"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        
        NSString *zaudioFilePath = [[NSBundle mainBundle] pathForResource:@"zap" ofType:@"wav"];
        NSURL *zaudioFileURL = [NSURL fileURLWithPath:zaudioFilePath];
        
        self.zapPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:zaudioFileURL error:nil];
        self.zapPlayer.delegate = self;
        [self.zapPlayer prepareToPlay];
        
        NSString *baudioFilePath = [[NSBundle mainBundle] pathForResource:@"bang" ofType:@"wav"];
        NSURL *baudioFileURL = [NSURL fileURLWithPath:baudioFilePath];
        
        self.bangPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:baudioFileURL error:nil];
        self.bangPlayer.delegate = self;
        [self.bangPlayer prepareToPlay];
        
        NSString *laudioFilePath = [[NSBundle mainBundle] pathForResource:@"laser" ofType:@"wav"];
        NSURL *laudioFileURL = [NSURL fileURLWithPath:laudioFilePath];
        
        self.laserPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:laudioFileURL error:nil];
        self.laserPlayer.delegate = self;
        [self.laserPlayer prepareToPlay];

    }
    return self;
}

- (void) setupView
{
    //remove the old inv items
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //place the buttons
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(70, 102, 50, 50);
    [button1 setImage:[UIImage imageNamed:@"ehit.png"] forState:UIControlStateNormal];
    button1.adjustsImageWhenHighlighted = NO;
    [button1 addTarget:self action:@selector(increaseEPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(150, 102, 50, 50);
    [button2 setImage:[UIImage imageNamed:@"mhit.png"] forState:UIControlStateNormal];
    button2.adjustsImageWhenHighlighted = NO;
    [button2 addTarget:self action:@selector(increaseMPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(240, 102, 50, 50);
    [button3 setImage:[UIImage imageNamed:@"phit.png"] forState:UIControlStateNormal];
    button3.adjustsImageWhenHighlighted = NO;
    [button3 addTarget:self action:@selector(increasePPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(270, 430, 50, 50);
    [button5 setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    button5.adjustsImageWhenHighlighted = NO;
    [button5 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button5];
    
    //place the labels
    self.epoints = [[UILabel alloc] initWithFrame:CGRectMake(82, 45, 100, 30)];
    self.epoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.epoints.textColor = [UIColor yellowColor];
    [self addSubview:self.epoints];
    
    self.mpoints = [[UILabel alloc] initWithFrame:CGRectMake(170, 45, 100, 30)];
    self.mpoints.textColor = [UIColor redColor];
    self.mpoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.mpoints];
    
    self.ppoints = [[UILabel alloc] initWithFrame:CGRectMake(270, 45, 100, 30)];
    self.ppoints.textColor = [UIColor greenColor];
    self.ppoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.ppoints];
    
    self.points = [[UILabel alloc] initWithFrame:CGRectMake(240, 25, 100, 30)];
    self.points.textColor = [UIColor whiteColor];
    self.points.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.points];
    
    [self updateLabels];
}

-(void)increaseEPoints
{
    [self.zapPlayer play];
    [self.lvc.player increaseEPoints];
    [self updateLabels];
}

-(void)increaseMPoints
{
    [self.laserPlayer play];
    [self.lvc.player increaseMPoints];
    [self updateLabels];
}

-(void)increasePPoints
{
    [self.bangPlayer play];
    [self.lvc.player increasePPoints];
    [self updateLabels];
}

-(void)updateLabels
{
    self.epoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.ePoints];
    self.mpoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.mPoints];
    self.ppoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.pPoints];
    self.points.text = [NSString stringWithFormat:@"%d", self.lvc.player.points];
}

-(void)dismiss
{
    [DataStore save];
    [self.lvc dismissModalViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
