//
//  PlayingCard.m
//  Matchismo
//
//  Created by Maria on 31.05.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    
    if (otherCards.count == 2) {
        PlayingCard *otherCard = [otherCards lastObject];
        PlayingCard *secondCard = otherCards[0];
        if (otherCard.rank == self.rank || secondCard.rank == self.rank ||
            secondCard.rank == otherCard.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit] || [secondCard.suit isEqualToString:self.suit] || [otherCard.suit isEqualToString:secondCard.suit]) {
            score = 1;
        }
        
        if (otherCard.rank == self.rank && secondCard.rank == self.rank) {
            score = 8;
        } else if ([otherCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit])
            score = 2;
    }
    
    return score;
}

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *) rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings) rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rankStrings;
}

+(NSUInteger) maxRank
{
    return [self rankStrings].count - 1;
}

+(NSArray *) validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♠", @"♣", @"♥", @"♦"];
    return validSuits;
}

-(void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

-(void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}
@end
