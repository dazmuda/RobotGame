//
//  DataStore.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "DataStore.h"
#import "World.h"
#import "Level.h"
#import "Item.h"
#import "Mob.h"
#import "Player.h"
#import "Position.h"
#import "Square.h"
#import <Parse/Parse.h>

NSManagedObjectContext* storeContext;
NSManagedObjectModel* storeModel;

@interface DataStore ()
+(NSManagedObjectContext*)context;
+(NSManagedObjectModel*)model;
@end

@implementation DataStore

+(NSArray*)parseScores {
    PFQuery* query = [PFQuery queryWithClassName:@"Score"];
    NSArray* scores = [query findObjects];
    return scores;
}

+(NSManagedObjectModel*)model {
    if (!storeModel) {
        storeModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return storeModel;
}

+(NSManagedObjectContext*)context {
    if (!storeContext) {
        //this searches for what places can I save things permanently
        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        
        //we want to save this in the USER directory
        //then it saves it in the first file that is retrieved
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        
        //this is the actual file in teh system that things get stored at
        NSURL* storeURL = [NSURL fileURLWithPath:[documentDirectory stringByAppendingString:@"dataStore.data"]];
        
        //persistant store coordinator knows how to talk to the database
        //this guy comes between the model and the actual sql database (it manages our store)
        NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[DataStore model]];
        
        NSError* err;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&err]) {
            [NSException raise:@"Open failed!"
                        format:@"Reason: %@", [err localizedDescription]];
        } else {
            storeContext = [NSManagedObjectContext new];
            [storeContext setPersistentStoreCoordinator:psc];
            // so we just got the context
            //context is what we use for fetching and creating new things from the database
            [storeContext setUndoManager:nil];
        }
    }
    
    return storeContext;
}

+(NSArray*)allWorlds {
    //lets make a request
    NSFetchRequest* req = [NSFetchRequest new];
    //we are using teh store model to make requests from the database
    req.entity = [[DataStore model].entitiesByName objectForKey:@"World"];
    
    NSError* err;
    //now execute the request using the context
    NSArray* result = [[DataStore context] executeFetchRequest:req error:&err];
    //this gave you an array of the results of the request
    if (!result) {
        [NSException raise:@"Fetch failed!"
                    format:@"Reason: %@", [err localizedDescription]];
    }
    
    return result;
}

+(NSArray*)allScores {
    //lets make a request
    NSFetchRequest* req = [NSFetchRequest new];
    //we are using teh store model to make requests from the database
    req.entity = [[DataStore model].entitiesByName objectForKey:@"Score"];
    
    NSError* err;
    //now execute the request using the context
    NSArray* result = [[DataStore context] executeFetchRequest:req error:&err];
    //this gave you an array of the results of the request
    if (!result) {
        [NSException raise:@"Fetch failed!"
                    format:@"Reason: %@", [err localizedDescription]];
    }
    
    return result;
}

+(World*)newWorld {
    World* new = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Level*)newLevel {
    Level *new = [NSEntityDescription insertNewObjectForEntityForName:@"Level" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Item*)newItem {
    Item *new = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Mob*)newMob {
    Mob *new = [NSEntityDescription insertNewObjectForEntityForName:@"Mob" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Player*)newPlayer {
    Player *new = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Position*)newPosition {
    Position *new = [NSEntityDescription insertNewObjectForEntityForName:@"Position" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Square*)newSquare {
    Square *new = [NSEntityDescription insertNewObjectForEntityForName:@"Square" inManagedObjectContext:[DataStore context]];
    return new;
}

+(Score*)newScore {
    Score *new = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:[DataStore context]];
    return new;
}

+(void)save {
    NSError* err;
    if (![[DataStore context] save:&err]) {
        [NSException raise:@"Save failed!"
                    format:@"Reason: %@", [err localizedDescription]];
    }
}

+(void)destroy:(World*)world {
    [[DataStore context] deleteObject:world];
}

@end
