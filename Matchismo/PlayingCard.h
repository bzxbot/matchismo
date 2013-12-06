//
//  PlayingCard.h
//  Matchismo
//
//  Created by Bernardo Botelho on 10/30/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
