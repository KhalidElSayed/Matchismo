//
//  SetCardView.m
//  Matchismo
//
//  Created by Maria on 12.12.13.
//  Copyright (c) 2013 Maria Naschanskaya. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

#pragma mark - Properties

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setPlayable:(BOOL)playable
{
    _playable = playable;
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (UIBezierPath *)diamondCenterPath
{
    UIBezierPath *bp = [[UIBezierPath alloc] init];
    
    [bp moveToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/4, self.bounds.origin.y+self.bounds.size.height/2)];
    [bp addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.origin.y+4*self.bounds.size.height/10)];
    [bp addLineToPoint:CGPointMake(self.bounds.origin.x+3*self.bounds.size.width/4, self.bounds.origin.y+self.bounds.size.height/2)];
    [bp addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.origin.y+6*self.bounds.size.height/10)];
    [bp closePath];
    return bp;
}

- (UIBezierPath *)ovalCenterPath
{
    CGRect rect = CGRectMake(self.bounds.origin.x+self.bounds.size.width/4, self.bounds.origin.y+4*self.bounds.size.height/10, self.bounds.size.width/2, self.bounds.size.height/5);
    
    UIBezierPath *bp = [UIBezierPath bezierPathWithOvalInRect:rect];

    return bp;
}

- (UIBezierPath *)squiggleCenterPath
{
    CGFloat ratio = self.bounds.size.width / 500.0;//The ratio variable is used to convert from the size of the rectangle used in Bezier explorer to the bounds of the view.
    UIBezierPath *thePath = [[UIBezierPath alloc] init];
    [thePath moveToPoint:CGPointMake(ratio*72.0,ratio*216.0)];
    [thePath addCurveToPoint:CGPointMake(ratio*372.0,ratio*120.0) controlPoint1:CGPointMake(ratio*24.0,ratio*24.0) controlPoint2:CGPointMake(ratio*300.0,ratio*228.0)];
    //That's one side of the shape. Now let's do the other side, which uses the same endpoints
    //but uses control points rotated 180 degrees about the center between the endpoints.
    //No moveToPoint needed, because we're already there.
    [thePath addCurveToPoint:CGPointMake(ratio*72.0,ratio*216.0) controlPoint1:CGPointMake(ratio*420.0,ratio*312.0) controlPoint2:CGPointMake(ratio*144.0,ratio*108.0)];
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), self.bounds.size.width/20, self.bounds.size.height/4);
    return thePath;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];

    if (self.faceUp)
    {
        [[UIColor yellowColor] setFill];
    } else {
        [[UIColor whiteColor] setFill];
    }
    [roundedRect fill];
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self.color setStroke];
    [self.color setFill];
    
    UIBezierPath *symbolPath = nil;
    if (self.symbol == DIAMOND )
    {
        symbolPath = [self diamondCenterPath];
    } else if (self.symbol == OVAL)
    {
        symbolPath = [self ovalCenterPath];
    } else
    {
        symbolPath = [self squiggleCenterPath];
    }
    
    if (self.number == 1)
    {
        [self drawSymbol:symbolPath];
    } else if (self.number == 3)
    {
        [self drawSymbol:symbolPath];
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, self.bounds.size.height/4);
        [self drawSymbol:symbolPath];
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, -self.bounds.size.height/2);
        [self drawSymbol:symbolPath];
    } else
    {
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, self.bounds.size.height/8);
        [self drawSymbol:symbolPath];
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, -self.bounds.size.height/4);
        [self drawSymbol:symbolPath];
    }
        
}

-(void)drawSymbol:(UIBezierPath *)symbol
{
    [symbol stroke];
    if (self.shading == 2)
    {
        [symbol fill];
    } else if (self.shading == 3)
    {
         CGContextSaveGState(UIGraphicsGetCurrentContext());
        [symbol addClip];
        CGRect bounds = symbol.bounds;
        
        UIBezierPath *bp = [[UIBezierPath alloc] init];
        [bp moveToPoint:CGPointMake(bounds.origin.x, bounds.origin.y)];
        [bp addLineToPoint:CGPointMake(bounds.origin.x+bounds.size.width,bounds.origin.y + bounds.size.height)];
        [bp closePath];

        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -bounds.size.width/2, 0);
        for (int i=0; i<6; i++) {
            [bp fill];
            [bp stroke];
            CGContextTranslateCTM(UIGraphicsGetCurrentContext(), bounds.size.width/4, 0);
        }
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    }
    
}

-(NSString *)description
{
    return [NSString stringWithFormat: @"Playeble %hhd", self.playable];
}
@end
