//
//  FlipResult.h
//  Matchismo
//
//  Created by Bernardo Botelho on 11/5/13.
//  Copyright (c) 2013 Bernardo Botelho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

enum Result {
    SimpleFlip,
    Match,
    NoMatch,
};

@interface FlipResult : NSObject

@property (nonatomic) enum Result result;
@property (weak, nonatomic) Card *firstCard;
@property (weak, nonatomic) Card *secondCard;

@end
