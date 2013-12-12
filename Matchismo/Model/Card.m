//
//  Card.m
//  Matchismo
//
//  Created by Maria on 31.05.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(NSString *)description
{
    return self.contents;
}

- (int) match:(NSArray *)otherCards
{
    int state = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
            state = 1;
    }
    
    return state;
}

@end
