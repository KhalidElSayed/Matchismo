//
//  MatchingGame.m
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "MatchingGame.h"

@interface MatchingGame()

//@property (readwrite, nonatomic) int score;
//@property (readwrite, nonatomic) NSString *lastActionDescription;

@end

@implementation MatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0; i<cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void)alertOnMatch: (BOOL)match
               card: (Card *)card
          withCards:(NSArray *)faceUpCards
          withScore: (int)score
{
    if (match) {
        self.lastActionDescription = [NSString stringWithFormat:@"Matched %@ & %@ at %d points", card.contents, [faceUpCards componentsJoinedByString:@" & "], score];
    } else {
        self.lastActionDescription = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!", card.contents, [faceUpCards componentsJoinedByString:@" & "], score];
    }
    
}

-(void)alertOnFlip: (bool) up card:(Card *) card
{
    if (up) {
        self.lastActionDescription =[NSString stringWithFormat: @"Flipped up %@", card.contents];
    } else {
        self.lastActionDescription = [NSString stringWithFormat: @"Flipped down %@", card.contents];
    }
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (!otherCard.isUnplayable && otherCard.isFaceUp && ![card isEqual:otherCard]) {
                    [faceUpCards addObject:otherCard];
                }
            }
            
            if ([faceUpCards count]+1 == self.gameMode) {
                int matchScore = [card match:faceUpCards];
                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in faceUpCards) {
                        otherCard.unplayable = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    [self alertOnMatch:TRUE card: card withCards:faceUpCards withScore:matchScore*MATCH_BONUS];
                } else {
                    for (Card *otherCard in faceUpCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    [self alertOnMatch:FALSE card: card withCards:faceUpCards withScore:MISMATCH_PENALTY];
                }
            } else {
                [self alertOnFlip:TRUE card:card];
            }
            self.score -= FLIP_COST;
        } else {
            [self alertOnFlip:FALSE card:card];
        }
        card.faceUp = !card.isFaceUp;
    }
}


@end
