//
//  BaseCardGameViewController.h
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "CardGameHistoryViewController.h"
#import "Grid.h"

@interface BaseCardGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (strong, nonatomic) Grid *grid;

@property (strong, nonatomic) NSMutableArray *cardViews;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) MatchingGame *game;

@property (strong, nonatomic) NSAttributedString *gameHistory;
@property (nonatomic) int cardsCount;

-(void)updateUI;
- (void)updateCards;
-(void)redeal;
-(void)reorderCards:(bool)withDeepAnimation;
-(void)reorderCardsWithAnimation;

-(void)newAction:(NSAttributedString *)action;
- (IBAction)flipCard:(id)sender;

- (void)addNewCardViewToColumn:(int)column ToRow:(int)row ToCards:(NSMutableArray *)cards;
-(void)addNewCardToCards:(NSMutableArray *)cards;
@end
