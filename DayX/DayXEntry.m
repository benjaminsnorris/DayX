//
//  DayXEntry.m
//  DayX
//
//  Created by Ben Norris on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXEntry.h"

#define TitleKey @"title"
#define ContentKey @"content"
#define DateKey @"date"

@interface DayXEntry()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *datestamp;

@end

@implementation DayXEntry

- (NSDictionary *)entryDictionary {
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    if (self.title) [mutableDictionary setValue:self.title forKey:TitleKey];
    if (self.content) [mutableDictionary setValue:self.content forKey:ContentKey];
    if (self.datestamp) [mutableDictionary setValue:self.datestamp forKey:DateKey];
    
    return mutableDictionary;
}

- (id)initWithDictionary: (NSDictionary *)dictionary {
    
    self.title = [dictionary objectForKey:TitleKey];
    self.content = [dictionary objectForKey:ContentKey];
    self.datestamp = [dictionary objectForKey:DateKey];
    
    return self;
}

@end
