//
//  DayXEntryController.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXEntryController.h"

#define EntryListKey @"entries"
#define EntryKey @"entry"
#define TitleKey @"title"
#define ContentKey @"content"

@interface DayXEntryController()

@property (nonatomic, strong) NSArray *entries;

@end

@implementation DayXEntryController

+ (DayXEntryController *)sharedInstance {
    static DayXEntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DayXEntryController alloc] init];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)addEntry:(NSDictionary *)entry {
    
}

- (void)removeEntry:(NSDictionary *)entry {
    
}

- (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry {
    
    if (!oldEntry || !newEntry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [self.entries mutableCopy];
    
    if ([mutableEntries containsObject:oldEntry]) {
        NSInteger index = [mutableEntries indexOfObject:oldEntry];
        [mutableEntries replaceObjectAtIndex:index withObject:newEntry];
    }
    
    self.entries = mutableEntries;
    [self synchronize];
}

- (void)loadFromDefaults {
    
}

- (void)synchronize {
    [[NSUserDefaults standardUserDefaults] setObject:self.entries forKey:EntryListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
