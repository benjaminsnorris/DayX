//
//  DayXEntryController.m
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXEntryController.h"

#define EntryListKey @"entries"

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

- (void)addEntry:(DayXEntry *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
    [self synchronize];
}

- (void)removeEntry:(DayXEntry *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    
    if ([mutableEntries containsObject:entry]) {
        [mutableEntries removeObject:entry];
    }
    
    self.entries = mutableEntries;
    [self synchronize];
}

- (void)replaceEntry:(DayXEntry *)oldEntry withEntry:(DayXEntry *)newEntry {
    
    if (!oldEntry || !newEntry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    
    if ([mutableEntries containsObject:oldEntry]) {
        NSInteger index = [mutableEntries indexOfObject:oldEntry];
        [mutableEntries replaceObjectAtIndex:index withObject:newEntry];
    }
    
    self.entries = mutableEntries;
    [self synchronize];
}

- (void)removeAllEntries {
    self.entries = nil;
    [self synchronize];
}

- (void)loadFromDefaults {
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:EntryListKey];
    NSMutableArray *entries = [NSMutableArray new];
    for (NSDictionary *dictionary in entryDictionaries) {
        DayXEntry *entry = [[DayXEntry alloc] initWithDictionary:dictionary];
        [entries addObject:entry];
    }
    self.entries = entries;
}

- (void)synchronize {
    NSMutableArray *entryDictionaries = [NSMutableArray new];
    for (DayXEntry *entry in self.entries) {
        [entryDictionaries addObject:[entry entryDictionary]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:entryDictionaries forKey:EntryListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
