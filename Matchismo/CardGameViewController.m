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
    [UIView transitionWithView:tap.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self flipCard: tap.view];
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
            
            pView.faceUp = pCard.isFaceUp;
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

-(void) setCardViews:(NSArray *)cardButtons
{
    [super setCardViews:cardButtons];

//    UIImage *image = [UIImage imageNamed:@"bober.png"];
//    UIImage *blank = [[UIImage alloc] init];
//    for (UIButton *cardButton in self.cardButtons) {
//        [cardButton setTitle:@"" forState:UIControlStateNormal];
//        [cardButton setImage:image forState:UIControlStateNormal];
//        [cardButton setImage:blank forState: UIControlStateSelected];
//        [cardButton setImage:blank forState: UIControlStateSelected | UIControlStateDisabled];
//        [cardButton setTitleColor:[UIColor blackColor] forState: UIControlStateSelected];
//        [cardButton setTitleColor:[UIColor blackColor]  forState: UIControlStateSelected | UIControlStateDisabled];
//    }
    [super updateUI];
}

@end
