//
//  BaseCardGameViewController.m
//  Matchismo
//
//  Created by Maria on 16.06.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "BaseCardGameViewController.h"

@interface BaseCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@end

@implementation BaseCardGameViewController

-(int)cardsCount
{
    return 12;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addCardsToView:self.gridView];
}

-(NSAttributedString *)gameHistory
{
    if (!_gameHistory)
    {
        _gameHistory = [[NSAttributedString alloc] init];
    }
    return _gameHistory;
}

-(Grid *)grid
{
    if (!_grid)
    {
        _grid = [[Grid alloc] init];
        _grid.margin = 2;
    }
    return _grid;
}

-(UIView *)newCardView
{
    return nil;
}

-(void)addCardsToView:(UIView *)gridView
{
    self.grid.size = self.gridView.frame.size;
    self.grid.minimumNumberOfCells = self.cardsCount;
    self.grid.minCellHeight = 56;
    self.grid.minCellWidth = 44;
    self.grid.cellAspectRatio = self.grid.minCellWidth/self.grid.minCellHeight;
    NSLog(@"grid set cool - %hhd", self.grid.inputsAreValid);
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    for (int i=0; i<self.grid.minimumNumberOfCells; i++)
    {
        int row = i / self.grid.columnCount;
        int column = i % self.grid.columnCount;
        [self addNewCardViewToColumn:column ToRow:row ToCards:views];
    }
    self.cardViews = views;
    [self updateUI];
}

- (void)addNewCardViewToColumn:(int)column ToRow:(int)row ToCards:(NSMutableArray *)cards
{
    UIView *card = [self newCardView];
    
    card.center = [self.grid centerOfCellAtRow:row inColumn:column];
    card.frame = [self.grid frameOfCellAtRow:row inColumn:column];
    [self.gridView addSubview:card];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip:)];
    [card addGestureRecognizer:tap];
    
    [cards addObject:card];
}

-(void)flip:(UITapGestureRecognizer *)tap
{
    [self flipCard: tap.view];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

-(void)updateAlert
{
    if(self.game.lastActionDescription)
    {
        [self newAction:[[NSAttributedString alloc] initWithString:self.game.lastActionDescription]];
    }
}

-(void)newAction:(NSAttributedString *)action
{
    NSMutableAttributedString *mutableHistory = [[NSMutableAttributedString alloc] initWithAttributedString:self.gameHistory];
    [mutableHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    [mutableHistory appendAttributedString:action];
    self.gameHistory = mutableHistory;
}

- (void)updateCards
{
    for (UIView *cardView in self.cardViews) {
        Card *card = [self.game cardAtIndex:[self.cardViews indexOfObject:cardView]];
        
        [self updateCardView:cardView forCard:card];
        
    }
}

-(void)redeal {}

-(void)updateCardView:(UIView *)cardView forCard:(Card *)card {}

-(void)updateUI
{
    [self updateCards];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self updateAlert];
}

- (IBAction)deal {
    self.game = nil;
    self.flipCount = 0;
    [self redeal];
    [self updateUI];
}

- (IBAction)flipCard:(id)sender
{
    [self.game flipCardAtIndex:[self.cardViews indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"])
    {
        if ([segue.destinationViewController isKindOfClass:[CardGameHistoryViewController class]])
        {
            CardGameHistoryViewController *cageVC = (CardGameHistoryViewController *)segue.destinationViewController;
            cageVC.history = self.gameHistory;
        }
    }
}
@end
