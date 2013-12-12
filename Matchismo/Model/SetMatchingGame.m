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

@end
