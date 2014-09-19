//
//  DayXEntryController.h
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayXEntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (DayXEntryController *)sharedInstance;

- (void)addEntry:(NSDictionary *)entry;
- (void)removeEntry:(NSDictionary *)entry;
- (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry;
- (void)removeAllEntries;

@end
