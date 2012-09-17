//
//  WorldDataStore.m
//  RobotGame
//
//  Created by Diana Zmuda on 9/17/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "WorldDataStore.h"
#import "World.h"

NSManagedObjectContext* worldContext;
NSManagedObjectModel* worldModel;

@interface WorldDataStore ()
+(NSManagedObjectContext*)context;
+(NSManagedObjectModel*)model;
@end

@implementation WorldDataStore

+(NSManagedObjectModel*)model {
    if (!worldModel) {
        worldModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return worldModel;
}

+(NSManagedObjectContext*)context {
    if (!worldContext) {
        //this searches for what places can I save things permanently
        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        
        //we want to save this in the USER directory
        //then it saves it in the first file that is retrieved
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        
        //this is the actual file in teh system that things get stored at
        NSURL* storeURL = [NSURL fileURLWithPath:[documentDirectory stringByAppendingString:@"worldDataStore.data"]];
        
        //persistant store coordinator knows how to talk to the database
        //this guy comes between the model and the actual sql database (it manages our store)
        NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[WorldDataStore model]];
        
        NSError* err;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&err]) {
            [NSException raise:@"Open failed!"
                        format:@"Reason: %@", [err localizedDescription]];
        } else {
            worldContext = [NSManagedObjectContext new];
            [worldContext setPersistentStoreCoordinator:psc];
            // so we just got the context
            //context is what we use for fetching and creating new things from the database
            [worldContext setUndoManager:nil];
        }
    }
    
    return worldContext;
}

+(NSArray*)allWorlds {
    //lets make a request
    NSFetchRequest* req = [NSFetchRequest new];
    //we are using teh store model to make requests from the database
    req.entity = [[WorldDataStore model].entitiesByName objectForKey:@"Friend"];
    
    NSError* err;
    //now execute the request using the context
    NSArray* result = [[WorldDataStore context] executeFetchRequest:req error:&err];
    //this gave you an array of the results of the request
    if (!result) {
        [NSException raise:@"Fetch failed!"
                    format:@"Reason: %@", [err localizedDescription]];
    }
    
    return result;
}

+(World*)createWorld {
    //so to create the firend, you need the context
    //NSEntitiy description identifies the name of the type of new entity (which is connected to the model)
    World* newWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:[WorldDataStore context]];
    
    return newWorld;
}

@end
