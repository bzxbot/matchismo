//
//  Deck.m
//  Matchismo
//
//  Created by Bernardo Botelho on 10/30/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
{
    if (atTop) {
        [[self cards] insertObject:card atIndex:0];
    } else {
        [[self cards] addObject:card];
    }
}

- (Card *)drawRandomCard;
{
    Card *randomCard = nil;
    
    int cardCount = [[self cards] count];
    
    if (cardCount) {
        unsigned index = arc4random() % cardCount;
        randomCard = [[self cards] objectAtIndex:index];
        [[self cards] removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
