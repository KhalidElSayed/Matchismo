//
//  MatchingGame.h
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface MatchingGame : NSObject

@property (strong, nonatomic) NSMutableArray *cards; // of Card

// designated initializer
-(id)initWithCardCount: (NSUInteger)cardCount
            usingDeck : (Deck *)deck;

-(void)flipCardAtIndex: (NSUInteger) index;

-(Card *)cardAtIndex: (NSUInteger) index;

@property (nonatomic) int score;
@property (nonatomic) NSString *lastActionDescription;
//@property (readonly, nonatomic) int score;
//@property (readonly, nonatomic) NSString *lastActionDescription;
@property  (nonatomic) int gameMode;

@end
