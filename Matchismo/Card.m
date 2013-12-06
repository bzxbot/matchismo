//
//  Card.m
//  Matchismo
//
//  Created by Bernardo Botelho on 10/30/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import "Card.h"


// Private attributes and methods.

@interface Card()

@end

@implementation Card

// @property generates the following code:

// @synthesize contents = _contents;

// The above code is saying that the property contents maps
// to the instance variable _contents.

// - (NSString *)contents
// {
//      return _contents;
// }

// - (void) setContents:(NSString *)contents
// {
//      _contents = contents;
// }

- (int)matchSingle:(Card *)card
{
    int score = 0;
    
    // Sending a message to card to get its contents.
    // It returns a string, we then send the message
    // isEqualToString passing the contents from self.
    if([[card contents] isEqualToString:[self contents]]) {
        score = 1;
    }
    
    return score;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if([[card contents] isEqualToString:[self contents]]) {
            score += 1;
        }
    }
    
    return score;
}


@end
