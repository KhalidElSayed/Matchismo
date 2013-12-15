//
//  SetMatchingGame.h
//  Matchismo
//
//  Created by Maria on 20.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "MatchingGame.h"

@interface SetMatchingGame : MatchingGame

@property (nonatomic) bool haveMatchCards;
@property (strong, nonatomic) NSArray *lastMatchedCards; // of Card

-(bool)add3moreCardsUsingDeck:(Deck *)deck;
-(bool)checkCardsForMatch;

@end
