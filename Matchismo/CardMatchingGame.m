//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Bernardo Botelho on 11/5/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        
        self.gameStarted = NO;
        self.gameType = TWO_CARD_MATCH;
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (FlipResult *)flipCardAtIndex:(NSUInteger)index
{
    _gameStarted = YES;
    FlipResult *flipResult = [[FlipResult alloc] init];
    Card *card = [self cardAtIndex:index];
    flipResult.firstCard = card;
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.faceUp) {
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    [otherCards addObject:otherCard];
                }
            }
            int matchScore = 0;
            
            if ([self gameType] == TWO_CARD_MATCH && [otherCards count] == 1) {
                matchScore = [card match:otherCards];
            } else if ([self gameType] == THREE_CARD_MATCH && [otherCards count] == 2) {
                matchScore = [card match:otherCards];
            }
            
            if (matchScore) {
                for (Card *otherCard in otherCards) {
                    otherCard.unplayable = YES;
                }
                card.unplayable = YES;
                self.score += matchScore * MATCH_BONUS;
                flipResult.result = Match;
            } else if (([self gameType] == TWO_CARD_MATCH && [otherCards count] == 1) ||
                       ([self gameType] == THREE_CARD_MATCH && [otherCards count] == 2)) {
                for (Card *otherCard in otherCards) {
                    otherCard.faceUp = NO;
                }
                if ([otherCards count] == 1) {
                    flipResult.result = NoMatch;
                    flipResult.secondCard = [otherCards objectAtIndex:0];
                }
                if ([otherCards count] == 2) {
                    //flipResult.secondCard = [otherCards objectAtIndex:0];
                }
                self.score -= MISMATCH_PENALTY;
            }
            
            if (!flipResult.result)
                flipResult.result = SimpleFlip;
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.faceUp;
    }
    
    return flipResult;
}

@end
