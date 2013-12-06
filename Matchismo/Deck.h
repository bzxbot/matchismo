//
//  Deck.h
//  Matchismo
//
//  Created by Bernardo Botelho on 10/30/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject

// Method called add card, takes a parameter of type Card
// named card and another paramater called atTop of type
// BOOL.
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
