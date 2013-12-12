//
//  CardGameHistory.m
//  Matchismo
//
//  Created by Maria on 19.11.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "CardGameHistoryViewController.h"

@interface CardGameHistoryViewController()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation CardGameHistoryViewController

-(void)viewDidLoad:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
}

-(void)setHistory:(NSAttributedString *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}

-(void)updateUI
{
    self.textView.attributedText = self.history;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}
@end
