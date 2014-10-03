//
//  DayXEntryController.h
//  DayX
//
//  Created by Ben Norris on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface DayXEntryController : NSObject

+ (DayXEntryController *)sharedInstance;

- (Entry *)addEntryWithTitle:(NSString *)title content:(NSString *)content dateStamp:(NSDate *)dateStamp;
- (void)removeEntry:(Entry *)entry;
- (void)removeAllEntries;
- (NSArray *)entries;
- (void)synchronize;

@end
