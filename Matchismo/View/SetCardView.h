//
//  SetCardView.h
//  Matchismo
//
//  Created by Maria on 12.12.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

typedef enum shadingTypes
{
    DIAMOND,
    SQUIGGLE,
    OVAL
} Shading;

@property (strong, nonatomic) UIColor *color;
@property (nonatomic) int shading;
@property (nonatomic) Shading *symbol;
@property (nonatomic) int number;

@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL playable;

@end
