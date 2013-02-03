//
//  WorldViewController.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/18/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "WorldViewController.h"
#import "World.h"
#import "DataStore.h"
#import "LevelViewController.h"
#import "Level+Methods.h"
#import "Player+Methods.h"
#import "DataStore.h"
#import "Score.h"

@interface WorldViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property NSArray *allWorlds;
@property NSArray *allScores;
@property UITableView *worldTable;
@property UITableView *scoreTable;
@property UITextField *nameField;

@end

@implementation WorldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allWorlds = [DataStore allWorlds];
    self.allScores = [DataStore parseScores];
    
    UIImage *bgImage = [UIImage imageNamed:@"loadscreen.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    self.worldTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 260, 130) style:UITableViewStylePlain];
    self.worldTable.dataSource = self;
    self.worldTable.delegate = self;
    [self.view addSubview: self.worldTable];
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 30, 30)];
    [newButton setImage:[UIImage imageNamed:@"enter.png"] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(presentKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
    
    self.scoreTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, 260, 130) style:UITableViewStylePlain];
    self.scoreTable.dataSource = self;
    self.scoreTable.delegate = self;
    [self.view addSubview: self.scoreTable];
    
    //create an invisible textfield for their name
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(-50,-50,10,10)];
    self.nameField.delegate = self;
    [self.view addSubview: self.nameField];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.worldTable) {
        return [self.allWorlds count];
    } else {
        return [self.allScores count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.worldTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"world"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"world"];
        }
        cell.imageView.image = nil;
        World *currentWorld = [self.allWorlds objectAtIndex: indexPath.row];
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"MM/dd hh:mm a"];
        NSString *dateString = [dateFormat stringFromDate:currentWorld.date];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", currentWorld.name, dateString];
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"score"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"score"];
        }
        cell.imageView.image = nil;
        
        //this displays all the scores on your device
//        Score *currentScore = [self.allScores objectAtIndex: indexPath.row];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@ - Level %d, VPs %d", currentScore.name, currentScore.level, currentScore.wins];
        
        //this displays all the scores that have been uploaded to parse
        PFObject* score = [self.allScores objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - Level %@, VPs %@", [score objectForKey:@"name"], [score objectForKey:@"level"], [score objectForKey:@"wins"]];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.worldTable) {
        World *currentWorld = [self.allWorlds objectAtIndex:indexPath.row];
        [currentWorld.player loadPosition];
        [currentWorld.level createGridFromSquares];
        LevelViewController *lvc = [[LevelViewController alloc] initWithWorld:currentWorld andWVC:self];
        [self.worldTable deselectRowAtIndexPath:indexPath animated:YES];
        [self presentModalViewController:lvc animated:YES];
    } else {
        [self.scoreTable deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)presentKeyboard
{
    self.nameField.text = @"";
    //bring the textfield up
    self.nameField.frame = CGRectMake(205,85,200,100);
    //show the keyboard
    [self.nameField becomeFirstResponder];
    //then the next method is called
}

//dismiss on enter using delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //only after you press return
    //should you create the actual coredata objects
    [self allocateDataSpace];
    self.nameField.frame = CGRectMake(-50,-50,10,10);
    return YES;
}

- (void)allocateDataSpace
{
    Score *score = [DataStore newScore];
    score.date = [NSDate date];
    score.level = 1;
    score.wins = 0;
    score.name = self.nameField.text;
    
    World *world = [DataStore newWorld];
    world.date = [NSDate date];
    world.score = score;
    world.name = self.nameField.text;
    
    Level *level = [DataStore newLevel];
    [level createSquares];
    [level createGridFromSquares];
    world.level = level;
    
    Player *player = [DataStore newPlayer];
    [player beginStats];
    world.player = player;
    
    [DataStore save];
    self.allWorlds = [DataStore allWorlds];
    [self.worldTable reloadData];
    self.allScores = [DataStore parseScores];
    [self.scoreTable reloadData];
}

- (void)diedInWorld:(World *)world
{
    //save their score in parse
    PFObject *score = [PFObject objectWithClassName:@"Score"];
    [score setObject:[NSNumber numberWithInt:world.score.level] forKey:@"level"];
    [score setObject:world.score.date forKey:@"date"];
    [score setObject:world.score.name forKey:@"name"];
    [score setObject:[NSNumber numberWithInt:world.score.wins] forKey:@"wins"];
    [score save];
    
    //destroy savegame
    [DataStore destroy:world];
    [DataStore save];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.allWorlds = [DataStore allWorlds];
    [self.worldTable reloadData];
    self.allScores = [DataStore parseScores];
    [self.scoreTable reloadData];
}

- (void)exitedGame
{
    [DataStore save];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.allWorlds = [DataStore allWorlds];
    [self.worldTable reloadData];
    self.allScores = [DataStore parseScores];
    [self.scoreTable reloadData];
}

@end
