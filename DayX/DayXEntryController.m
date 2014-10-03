//
//  DayXEntryController.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXEntryController.h"
#import "Stack.h"

@interface DayXEntryController()

@end

@implementation DayXEntryController

+ (DayXEntryController *)sharedInstance {
    static DayXEntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DayXEntryController alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)entries {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
}

- (Entry *)addEntryWithTitle:(NSString *)title content:(NSString *)content dateStamp:(NSDate *)dateStamp {
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    entry.title = title;
    entry.content = content;
    entry.dateStamp = dateStamp;
    
    [self synchronize];
    
    return entry;
}

- (void)removeEntry:(Entry *)entry {
//    [[Stack sharedInstance].managedObjectContext deleteObject:entry];
    // This is the same as the previous line with a single MOC. With multiple, this one is safer.
    [entry.managedObjectContext deleteObject:entry];
    [self synchronize];
}

- (void)removeAllEntries {
    for (Entry *entry in self.entries) {
        [[Stack sharedInstance].managedObjectContext deleteObject:entry];
    }
}

- (void)synchronize {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

@end
