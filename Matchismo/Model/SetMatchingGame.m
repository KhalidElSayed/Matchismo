//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Maria on 20.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "SetMatchingGame.h"

@implementation SetMatchingGame

#define MATCH_BONUS 15
#define MISMATCH_PENALTY 5
#define FLIP_COST 0

-(void)alertOnMatch: (BOOL)match
               card: (Card *)card
          withCards:(NSArray *)faceUpCards
          withScore: (int)score
{
    if (match) {
        self.lastActionDescription = [NSString stringWithFormat:@"Matched %%@ at %d points",
                                      //card.contents, [faceUpCards componentsJoinedByString:@" & "],
                                      score];
    } else {
        self.lastActionDescription = [NSString stringWithFormat:@" %%@ don't match! %d point penalty!", score];
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:faceUpCards];
    [array addObject:card];
    self.lastMatchedCards = array;

}

-(void)alertOnFlip: (bool) up card:(Card *) card
{
    if (up) {
        self.lastActionDescription = @"Flipped up %@ ";
    } else {
        self.lastActionDescription = @"Flipped down %@ ";
    }
    self.lastMatchedCards = @[card];
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    [super flipCardAtIndex:index];
    [self checkCardsForMatch];
}

-(bool)checkCardsForMatch
{
    return NO;
    self.haveMatchCards = NO;
    for (Card *card1 in self.cards)
    {
        if (card1.unplayable) continue;
        for (Card *card2 in self.cards)
        {
            if (card1.unplayable) continue;
            for (Card *card3 in self.cards)
            {
                if (card1.unplayable) continue;
                if (![card1 isEqual:card2] && ![card2 isEqual:card3] && ![card1 isEqual:card3])
                {
                    int matchScore = [card1 match:@[card2, card3]];
                    if (matchScore)
                    {
                        self.haveMatchCards = YES;
                        break;
                    }

                }
            }
            if (self.haveMatchCards) break;
        }
        if (self.haveMatchCards) break;
    }
    return self.haveMatchCards;
}

-(bool)add3moreCardsUsingDeck:(Deck *)deck
{
    int cardsCount = self.cards.count;
    for (int i=0; i<3; i++) {
        Card *card = [deck drawRandomCard];
        if (!card) {
            return false;
        } else {
            self.cards[i+cardsCount] = card;
        }
    }
    return true;
}
@end
