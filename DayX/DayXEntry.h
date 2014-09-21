//
//  DayXEntry.h
//  DayX
//
//  Created by Ben Norris on 9/20/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayXEntry : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *datestamp;

- (NSDictionary *)entryDictionary;
- (id)initWithDictionary: (NSDictionary *)dictionary;

@end
