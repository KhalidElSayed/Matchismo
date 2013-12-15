//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dealMoreButton;
@property (strong, nonatomic) SetCardDeck *deck;
@end

@implementation SetGameViewController


-(MatchingGame *)game
{
    if (!super.game) {
        self.deck = [[SetCardDeck alloc] init];
        super.game = [[SetMatchingGame alloc] initWithCardCount:self.cardViews.count
                                                       usingDeck:self.deck];
        super.game.gameMode = 3;
        self.dealMoreButton.enabled = ![(SetMatchingGame *)self.game checkCardsForMatch];
    }
    return super.game;
}

- (void)add3CardToView {
    self.grid.minimumNumberOfCells +=3;
    
    NSMutableArray *views = [[NSMutableArray alloc] initWithArray:self.cardViews];
    
    for (int i=0; i<3; i++)
    {
        [self addNewCardToCards:views];
    }
    self.cardViews = views;
    [self updateUI];
    [super reorderCardsWithAnimation];
}

- (IBAction)deal3MoreCard {
    
    bool success = [(SetMatchingGame *)self.game add3moreCardsUsingDeck:self.deck];
    
    if (!success)
    {
        NSLog(@"No more cards");
        self.dealMoreButton.enabled = false;
        return;
    }
    
    [self add3CardToView];
    
     self.dealMoreButton.enabled = ![(SetMatchingGame *)self.game checkCardsForMatch];
}

-(UIView *)newCardView
{
    return [[SetCardView alloc] init];
}

- (void)updateCards
{
    [super updateCards];
    
    NSMutableArray *viewsToDelete = [NSMutableArray array];
    NSMutableArray *cardsToDelete = [NSMutableArray array];
    for (SetCardView *cardView in self.cardViews) {
        if (!cardView.playable)
        {
            [viewsToDelete addObject:cardView];
            [cardsToDelete addObject:[self.game cardAtIndex:[self.cardViews indexOfObject:cardView]]];
        }
    }
    
    [self.cardViews removeObjectsInArray:viewsToDelete];
    [self.game.cards removeObjectsInArray:cardsToDelete];
    
    if ([viewsToDelete count])
    {
        [self reorderCards];
    }
}

-(void)redeal
{
    if (self.cardViews.count < [self cardsCount])
    {
        int cardsToAdd =[self cardsCount]-self.cardViews.count;
        for (int i=0; i<cardsToAdd; i++)
        {
            [super addNewCardToCards:self.cardViews];
        }
        [super reorderCards];
    }
}

-(void)updateCardView:(UIView *)cardView forCard:(Card *)card
{
    if ([cardView isKindOfClass:[SetCardView class]])
    {
        if ([card isKindOfClass:[SetCard class]])
        {
            SetCardView *sView = (SetCardView *)cardView;
            SetCard *sCard = (SetCard *)card;
            
            sView.faceUp = sCard.isFaceUp;
            
            sView.playable = !sCard.isUnplayable;
            //sView.alpha = sCard.isUnplayable ? 0.0 : 1.0;
            
            sView.color = [self cardColor:sCard];
            sView.number = sCard.number;
            sView.shading = sCard.shading;
            sView.symbol = [self cardSymbol:sCard];
            
            if (!sView.playable)
            {
                [sView removeFromSuperview];
            }
        }
    }

}

-(Symbols)cardSymbol:(SetCard*)sCard
{
    Symbols symbol;
    if ([sCard.symbol isEqualToString:@"▲"]) {
        symbol = DIAMOND;
    } else if ([sCard.symbol isEqualToString:@"●"]) {
        symbol = OVAL;
    } else {
        symbol = SQUIGGLE;
    }
    return symbol;
}

-(UIColor *)cardColor:(SetCard*)setCard
{
    UIColor *cardColor;
    if (setCard.color == 1) {
        cardColor = [UIColor redColor];
    } else if (setCard.color == 2) {
        cardColor = [UIColor blueColor];
    } else {
        cardColor = [UIColor greenColor];
    }
    return cardColor;
}

- (void)addAttributeForCard:(Card *)card range:(NSRange)range content:(NSMutableAttributedString *)content
{
    if (![card isKindOfClass:[SetCard class]]) return;
    
    SetCard *setCard = (SetCard *)card;
    
    UIColor *cardColor;
    if (setCard.color == 1) {
        cardColor = [UIColor redColor];
    } else if (setCard.color == 2) {
        cardColor = [UIColor blueColor];
    } else {
        cardColor = [UIColor greenColor];
    }
    
    if (setCard.color == 1) {
        cardColor = [UIColor redColor];
    } else if (setCard.color == 2) {
        cardColor = [UIColor blueColor];
    } else {
        cardColor = [UIColor greenColor];
    }
    
    CGFloat shadeAlpha = 0.5*(setCard.shading-1);
    if (setCard.shading == 2) {
        shadeAlpha = 0.3;
    }
    
    UIColor *shadingColor = [cardColor colorWithAlphaComponent:shadeAlpha];
    
    [content addAttributes:@{NSForegroundColorAttributeName: shadingColor} range: range];
    [content addAttributes:@{NSStrokeColorAttributeName: cardColor} range: range];
    [content addAttributes:@{NSStrokeWidthAttributeName: @-5} range: range];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateAlert
{
    if (!self.game) return;
    if (!self.game.lastActionDescription) return;
    
    if ([self.game isKindOfClass:[SetMatchingGame class]])
    {
        SetMatchingGame *game = (SetMatchingGame *)self.game;
        NSString *description = [NSString stringWithFormat:self.game.lastActionDescription, [game.lastMatchedCards componentsJoinedByString:@" & "]];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString: description];
        for (Card *card in game.lastMatchedCards)
        {
            NSString *searchString = [NSString stringWithFormat:@" %@ ", card.contents];
            NSRange range = [[content string] rangeOfString:searchString];
            
            NSString *newSearchingString = [content string];
            while (true)
            {
                NSAttributedString *atr = [content attributedSubstringFromRange:range];
                NSDictionary *d = [atr attributesAtIndex:0 effectiveRange:0];
            
                if (d.count > 0)
                {
                    NSMutableString *replacingString = [[NSMutableString alloc] init];
                    for (int i=0; i<range.length; i++)
                    {
                        [replacingString appendString:@" "];
                    }
                    
                    newSearchingString = [newSearchingString stringByReplacingCharactersInRange:range withString:replacingString];
                    range = [newSearchingString rangeOfString:searchString];
                } else break;
            
            }
            
            [self addAttributeForCard:card range:range content:content];
        }
        [self newAction:content];
    }
}

-(void)flip:(UITapGestureRecognizer *)tap
{
    [UIView transitionWithView:self.view
                      duration:1.0
                       options:UIViewAnimationOptionBeginFromCurrentState
                    animations:^{
                        [self flipCard: tap.view];
                        if ([self.game isKindOfClass:[SetMatchingGame class]])
                        {
                            self.dealMoreButton.enabled = ![(SetMatchingGame *)self.game checkCardsForMatch] && !self.deck.noMoreCards;
                        }
                       
                    }
                    completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
