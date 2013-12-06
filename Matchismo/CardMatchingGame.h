//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Bernardo Botelho on 11/5/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "FlipResult.h"

enum GameType {
    TWO_CARD_MATCH,
    THREE_CARD_MATCH
};

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (FlipResult *)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@property (nonatomic) bool gameStarted;

@property (nonatomic) enum GameType gameType;

@end
