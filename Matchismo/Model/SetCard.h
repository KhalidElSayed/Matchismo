//
//  SetCard.h
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) int color;
@property (nonatomic) int shading;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) int number;

+(NSArray *) validSymbols;
+(NSUInteger) maxColor;
+(NSUInteger) maxShading;
+(NSUInteger) maxNumber;

@end
