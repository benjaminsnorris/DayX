//
//  DayXEntry.m
//  DayX
//
//  Created by Ben Norris on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DayXEntry.h"

#define titleKey @"title"
#define contentKey @"content"
#define dateKey @"date"

@interface DayXEntry()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *datestamp;

@end

@implementation DayXEntry

- (NSDictionary *)entryDictionary {
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    if (self.title) [mutableDictionary setValue:self.title forKey:titleKey];
    if (self.content) [mutableDictionary setValue:self.content forKey:contentKey];
    if (self.datestamp) [mutableDictionary setValue:self.datestamp forKey:dateKey];
    
    return mutableDictionary;
}

- (id)initWithDictionary: (NSDictionary *)dictionary {
    
    self.title = [dictionary objectForKey:titleKey];
    self.content = [dictionary objectForKey:contentKey];
    self.datestamp = [dictionary objectForKey:dateKey];
    
    return self;
}

@end
