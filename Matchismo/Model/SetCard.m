//
//  SetCard.m
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([self matchSymbol:otherCards] && [self matchNumbers:otherCards] &&
        [self matchColors:otherCards] && [self matchShades:otherCards])
        score = 10;
    
    return score;
}

-(bool) matchShades: (NSArray *)otherCards
{
    bool match = NO;
    
    if (otherCards.count == 2) {
        SetCard *otherCard = [otherCards lastObject];
        SetCard *secondCard = otherCards[0];
        
        if (otherCard.shading == self.shading && secondCard.shading == self.shading)
        {
            match = YES;
        } else if (otherCard.shading != self.shading &&
                   secondCard.shading != self.shading &&
                   secondCard.shading != otherCard.shading) {
            match = YES;
        } else {
            match = NO;
        }
    }
    
    return match;
}

-(bool) matchColors: (NSArray *)otherCards
{
    bool match = NO;
    
    if (otherCards.count == 2) {
        SetCard *otherCard = [otherCards lastObject];
        SetCard *secondCard = otherCards[0];
        
        if (otherCard.color == self.color && secondCard.color == self.color)
        {
            match = YES;
        } else if (otherCard.color != self.color &&
                   secondCard.color != self.color &&
                   secondCard.color != otherCard.color) {
            match = YES;
        } else {
            match = NO;
        }
    }
    
    return match;
}


-(bool) matchNumbers: (NSArray *)otherCards
{
    bool match = NO;
    
    if (otherCards.count == 2) {
        SetCard *otherCard = [otherCards lastObject];
        SetCard *secondCard = otherCards[0];
        
        if (otherCard.number == self.number && secondCard.number == self.number)
        {
            match = YES;
        } else if (otherCard.number != self.number &&
                   secondCard.number != self.number &&
                   secondCard.number != otherCard.number) {
            match = YES;
        } else {
            match = NO;
        }
    }
    
    return match;
}


-(bool) matchSymbol: (NSArray *)otherCards
{
    bool match = NO;
    
    if (otherCards.count == 2) {
        SetCard *otherCard = [otherCards lastObject];
        SetCard *secondCard = otherCards[0];

        if ([otherCard.symbol isEqualToString:self.symbol] && [secondCard.symbol isEqualToString:self.symbol])
        {
            match = YES;
        } else if (![otherCard.symbol isEqualToString:self.symbol] &&
                   ![secondCard.symbol isEqualToString:self.symbol] &&
                   ![secondCard.symbol isEqualToString:otherCard.symbol]) {
            match = YES;
        } else {
            match = NO;
        }
    }
    
    return match;
}

-(NSString *)contents
{
    NSMutableString *content = [[NSMutableString alloc] init];
    for (int i=1; i <= self.number; i++) {
        [content appendString:self.symbol];
    }
    return [content mutableCopy];
}

+(NSArray *) validSymbols
{
    static NSArray *validSymbols = nil;
    if (!validSymbols) validSymbols = @[@"■",@"▲",@"●"];
    return validSymbols;
}

+(NSUInteger) maxShading
{
    return 3;
}

+(NSUInteger) maxColor
{
    return 3;
}

+(NSUInteger) maxNumber
{
    return 3;
}

@end
