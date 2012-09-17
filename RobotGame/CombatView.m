//
//  CombatView.m
//  Robots
//
//  Created by Diana Zmuda on 9/10/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "CombatView.h"
#import <QuartzCore/QuartzCore.h>
#import "Player.h"
#import "Mob.h"
#import "LevelViewController.h"
#import "Item.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface CombatView () <AVAudioPlayerDelegate>

@property double mobHP;
@property double mobShields;
@property double playerShields;
@property double eWeapon;
@property double mWeapon;
@property double pWeapon;
@property BOOL mobStunned;

@property UILabel *playerHPLabel;
@property UILabel *playerShieldsLabel;
@property UILabel *mobHPLabel;
@property UILabel *mobShieldsLabel;

@property UIButton *eButton;
@property UIButton *mButton;
@property UIButton *pButton;

@property CALayer *currentAnimation;
@property (strong) AVAudioPlayer* zapPlayer;
@property (strong) AVAudioPlayer* bangPlayer;
@property (strong) AVAudioPlayer* laserPlayer;

@end

@implementation CombatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bgImage = [UIImage imageNamed:@"fightpurple.png"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        
        //        NSURL* documentDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        //        NSURL* audioURL = [documentDir URLByAppendingPathComponent:@"zap.wav"];
        
        NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"zap" ofType:@"wav"];
        NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePath];
        
        self.zapPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:nil];
        self.zapPlayer.delegate = self;
        [self.zapPlayer prepareToPlay];
        
        //        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"zap" ofType:@"wav"];
        //        NSSound *sound = [[NSSound alloc] initWithContentsOfFile:resourcePath byReference:YES];
        // Do something with sound, like [sound play] and release.
        
        //        NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"zap" ofType:@"wav"];
        //        NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePath];
    }
    return self;
}

-(void) setupWithBlock:(void (^)(void))block {
    //set up the temporary stats
    self.mobHP = self.mob.maxHP;
    self.mobShields = self.mob.maxShield;
    self.mobStunned = FALSE;
    self.playerShields = self.player.maxShield;
    self.eWeapon = 0;
    self.mWeapon = 0;
    self.pWeapon = 0;
    
    //these are the items equipped
    Item *leftItem = [self.player.equipped objectForKey:@"left"];
    Item *rightItem = [self.player.equipped objectForKey:@"right"];
    //add to your weapon damage for the left weapon
    if (leftItem.type == 1) {
        self.eWeapon += leftItem.damage;
    } else if (leftItem.type == 2) {
        self.mWeapon += leftItem.damage;
    } else if (leftItem.type == 3) {
        self.pWeapon += leftItem.damage;
    }
    //and for the right
    if (rightItem.type == 1) {
        self.eWeapon += rightItem.damage;
    } else if (rightItem.type == 2) {
        self.mWeapon += rightItem.damage;
    } else if (rightItem.type == 3) {
        self.pWeapon += rightItem.damage;
    }
    
    //place a picture of the player
    //    CALayer *bgLayer = [CALayer new];
    //    bgLayer.bounds = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height);
    //    bgLayer.frame = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height);
    //    UIImage *redCombat = [UIImage imageNamed:@"fightred.png"];
    //    bgLayer.contents = (__bridge id)([redCombat CGImage]);
    //    [self.layer addSublayer:bgLayer];
    
    //if either equipped item is of the right type
    if (leftItem.type == 1 || rightItem.type == 1) {
        //place the button
        self.eButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.eButton.frame = CGRectMake(51, 51, 50, 50);
        [self.eButton setImage:[UIImage imageNamed:@"ehit.png"] forState:UIControlStateNormal];
        self.eButton.adjustsImageWhenHighlighted = NO;
        [self.eButton addTarget:self action:@selector(playerEHit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.eButton];
    }
    
    if (leftItem.type == 2 || rightItem.type == 2) {
        self.mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mButton.frame = CGRectMake(101, 51, 50, 50);
        [self.mButton setImage:[UIImage imageNamed:@"mhit.png"] forState:UIControlStateNormal];
        self.mButton.adjustsImageWhenHighlighted = NO;
        [self.mButton addTarget:self action:@selector(playerMHit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.mButton];
    }
    
    if (leftItem.type == 3 || rightItem.type == 3) {
        self.pButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pButton.frame = CGRectMake(151, 51, 50, 50);
        [self.pButton setImage:[UIImage imageNamed:@"phit.png"] forState:UIControlStateNormal];
        self.pButton.adjustsImageWhenHighlighted = NO;
        [self.pButton addTarget:self action:@selector(playerPHit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pButton];
    }
    
    //add the labels
    self.playerHPLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 200, 30)];
    self.playerHPLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.playerHPLabel];
    self.playerShieldsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 330, 200, 30)];
    self.playerShieldsLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.playerShieldsLabel];
    self.mobHPLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 360, 200, 30)];
    self.mobHPLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.mobHPLabel];
    self.mobShieldsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 390, 200, 30)];
    self.mobShieldsLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.mobShieldsLabel];
    
    //call the block that removes the mob from the level map
    block();
    
    [self updateLabels];
    [self setNeedsDisplay];
}

-(void)updateLabels {
    self.playerHPLabel.text = [NSString stringWithFormat:@"player hp = %f", self.player.currentHP];
    self.playerShieldsLabel.text = [NSString stringWithFormat:@"player shield = %f", self.playerShields];
    self.mobHPLabel.text = [NSString stringWithFormat:@"mob hp = %f", self.mobHP];
    self.mobShieldsLabel.text = [NSString stringWithFormat:@"mob shield = %f", self.mobShields];
}

//you could also set up the labels using layers
-(void)placeLabelLayer {
    //this is a label layer
    CATextLayer *statLabel = [[CATextLayer alloc] init];
    [statLabel setString:@"sweet combat numbers"];
    [statLabel setFont:@"Helvetica-Bold"];
    [statLabel setFrame:CGRectMake(50, 300, 300, 100)];
    [statLabel setFontSize:20];
    [statLabel setForegroundColor:[[UIColor blackColor] CGColor]];
    //statLabel.position = CGPointMake(100,100);
    [self.layer addSublayer:statLabel];
    //find out how to use UIlabels in CALayers
    [self setNeedsDisplay];
}

-(void)playerEHit {
    //disable the button until animation is complete
    self.eButton.enabled = FALSE;
    
    int isCrit = 0;
    int critNum = arc4random() % (100-self.player.crit);
    if (critNum == 0) {
        isCrit = 1;
    }
    
    if (self.mobShields <= 0) {
        self.mobHP = self.mobHP - self.player.eHit - isCrit*self.player.eHit - self.eWeapon;
    } else {
        self.mobShields = self.mobShields - self.player.eHit - isCrit*self.player.eHit - self.eWeapon;
        if (self.mobShields <= 0) {
            float excess = 0 - self.mobShields;
            self.mobHP -= excess;
        }
    }
    
    //special buff
    if (isCrit == 1 && self.player.eBuff == TRUE) {
        self.mobStunned = TRUE;
    }
    
    self.currentAnimation = [CALayer new];
    self.currentAnimation.frame = CGRectMake(50,300,50,50);
    UIImage *electricity = [UIImage imageNamed:@"ehit.png"];
    self.currentAnimation.contents = (__bridge id)([electricity CGImage]);
    [self.layer addSublayer:self.currentAnimation];
    
    //lets animate that!
    CAKeyframeAnimation *slider = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //set yourself as the delegate so you can do stuff when the animation stops
    slider.delegate = self;
    CGPoint orig = CGPointMake(50,300);
    CGPoint point1 = CGPointMake(20, 200);
    CGPoint point2 = CGPointMake(100, 150);
    NSArray *spots = @[[NSValue valueWithCGPoint:orig],[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2]];
    [slider setValues:spots];
    [slider setDuration:1];
    [slider setKeyTimes:@[@(0.0),@(0.6),@(1.0)]];
    [self.currentAnimation addAnimation:slider forKey:@"slider"];
    //set the position to the end point so it doesn't snap back
    self.currentAnimation.position = CGPointMake(100,150);
    
    //PLAY ZE SOUND
    [self.zapPlayer play];
    
    [self mobHit];
}

-(void)playerMHit {
    self.mButton.enabled = FALSE;
    int isCrit = 0;
    int critNum = arc4random() % (100-self.player.crit);
    if (critNum == 0) {
        isCrit = 1;
    }
    
    if (self.mobShields <= 0) {
        self.mobHP = self.mobHP - self.player.mHit - isCrit*self.player.mHit - self.eWeapon;
    } else {
        self.mobShields = self.mobShields - self.player.mHit - isCrit*self.player.mHit - self.eWeapon;
        if (self.mobShields <= 0) {
            float excess = 0 - self.mobShields;
            self.mobHP -= excess;
        }
    }
    
    //special buff
    if (self.player.mBuff == TRUE) {
        self.playerShields += 1;
    }
    
    [self updateLabels];
    [self setNeedsDisplay];
    
    [self mobHit];
}

-(void)playerPHit {
    self.pButton.enabled = FALSE;
    //determine if its a crit
    int isCrit = 0;
    int critNum = arc4random() % (100-self.player.crit);
    if (critNum == 0) {
        isCrit = 1;
    }
    
    if (self.mobShields <= 0) {
        //if their shields are out hit them
        self.mobHP = self.mobHP - self.player.pHit - isCrit*self.player.pHit - self.eWeapon;
    } else {
        //else hit their shields
        self.mobShields = self.mobShields - self.player.pHit - isCrit*self.player.pHit - self.eWeapon;
        //special buff case
        if (self.player.pBuff == TRUE) {
            self.mobHP = self.mobHP - .25*self.player.pHit -.25*self.eWeapon;
        }
        //if this shield hit destroyed shields, the excess hits them
        if (self.mobShields <= 0) {
            float excess = 0 - self.mobShields;
            self.mobHP -= excess;
        }
    }
    
    //update the labels
    [self updateLabels];
    [self setNeedsDisplay];
    
    //trigger the mob's hit
    [self mobHit];
}

-(void)mobHit {
    //it only hits you if it isn't stunned
    if (self.mobStunned == FALSE) {
        if (self.playerShields <= 0) {
            //if your shields are out, direct hit
            self.player.currentHP = self.player.currentHP - self.mob.damage;
        } else {
            //else it hits your shields
            self.playerShields = self.playerShields - self.mob.damage;
            //if this shield hit destroyed shields, the excess hits directly
            if (self.playerShields <= 0) {
                float excess = 0 - self.playerShields;
                self.player.currentHP -= excess;
            }
        }
    }
    //if the mob was stunned it is no longer stunned
    self.mobStunned = FALSE;
}

//this method is called every time the animation finishes
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    self.eButton.enabled = TRUE;
    self.mButton.enabled = TRUE;
    self.pButton.enabled = TRUE;
    //it removes the layer
    [self.currentAnimation removeFromSuperlayer];
    [self updateLabels];
    if (self.mobHP <= 0) {
        [self.lvc dismissModalViewControllerAnimated:YES];
    }
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
