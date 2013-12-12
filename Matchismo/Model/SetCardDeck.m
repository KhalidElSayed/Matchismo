//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Maria on 20.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id) init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols ]) {
            for (int color = 1; color <= [SetCard maxColor]; color++) {
                for (int shade = 1; shade <= [SetCard maxShading]; shade++) {
                    for (int number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shade;
                        card.number = number;
                        [self addCard:card atTop: YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
