//
//  Deck.h
//  Matchismo
//
//  Created by Maria on 31.05.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard: (Card *)card atTop: (BOOL) atTop;

- (Card *) drawRandomCard;

@end
