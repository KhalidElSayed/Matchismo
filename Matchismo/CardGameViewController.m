//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Maria on 31.05.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "MatchingGame.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

-(UIView *)newCardView
{
    return [[PlayingCardView alloc] init];
}

-(void)flip:(UITapGestureRecognizer *)tap
{
    [self flipAnimateBlock:^(){[self flipCard: tap.view];}
                   ForView:tap.view];    
}

-(void)flipAnimateBlock:(void (^)())block ForView:(UIView *)tView
{
    [UIView transitionWithView:tView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        block();
                    }
                    completion:nil];
}


-(void)updateCardView:(UIView *)cardView forCard:(Card *)card
{
    if ([cardView isKindOfClass:[PlayingCardView class]])
    {
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCardView *pView = (PlayingCardView *)cardView;
            PlayingCard *pCard = (PlayingCard *)card;
            
            if (pView.faceUp!=pCard.faceUp)
            {
                [self flipAnimateBlock:^(){pView.faceUp = pCard.isFaceUp;}
                               ForView:cardView];
                
            }
            
            pView.playable = !pCard.isUnplayable;
            
            pView.alpha = pCard.isUnplayable ? 0.3 : 1.0;
            
            pView.suit = pCard.suit;
            pView.rank = pCard.rank;
        }
    }
    
}

-(MatchingGame *)game
{
    if (!super.game) {
        super.game = [[CardMatchingGame alloc] initWithCardCount:self.cardViews.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        super.game.gameMode = 2;
    }
    return super.game;
}


@end
