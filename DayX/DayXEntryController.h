//
//  DayXEntryController.h
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayXEntry.h"

@interface DayXEntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (DayXEntryController *)sharedInstance;

- (void)addEntry:(DayXEntry *)entry;
- (void)removeEntry:(DayXEntry *)entry;
- (void)replaceEntry:(DayXEntry *)oldEntry withEntry:(DayXEntry *)newEntry;
- (void)removeAllEntries;

@end
