//
//  Card.h
//  Matchismo
//
//  Created by Bernardo Botelho on 10/30/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

// Strong pointers will keep the object in memory
// until someone sets it to nil.

// Weak pointers only stay alive as long as there is
// a strong property pointing to that object.


// Nonatomic means that this is not thread-safe code.

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)matchSingle:(Card *)card;

- (int)match:(NSArray *)otherCards;

@end
