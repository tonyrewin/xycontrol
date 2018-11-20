//
//  XYView.h
//  XY Control


#import "XYView.h"


@interface XYView ()

@property(nonatomic, strong) UIColor *foreColour;
@property(nonatomic, assign) BOOL touchIsDown;

@end


@implementation XYView

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        CGFloat hue, saturation, brightness, alpha;
        [self.backgroundColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        _foreColour = [UIColor greenColor]; //[UIColor colorWithHue:hue saturation:saturation brightness:brightness*0.2 alpha:alpha];
        _xyPosition = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
        
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchIsDown = YES;
    UITouch *touch = [touches anyObject];
   [self updateXY:[touch locationInView:touch.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent*)event;
{
    self.touchIsDown = YES;
    UITouch *touch = [touches anyObject];
    [self updateXY:[touch locationInView:touch.view]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchIsDown = NO;
    //UITouch *touch = [touches anyObject];
    //[self updateXY:[touch locationInView:touch.view]];
}

- (void)updateXY:(CGPoint)point
{
    float x = [self clampToRange:point.x min:0 max:CGRectGetWidth(self.bounds)];
    float y = [self clampToRange:point.y min:0 max:CGRectGetHeight(self.bounds)];
    
    self.xyPosition = CGPointMake(x, y);
    
    [self.delegate controlValueChanged:[self xyNormalised]];
    [self setNeedsDisplay];
}

- (float)clampToRange:(float)x min:(float)min max:(float)max
{
    const float t = x < min ? min : x;
    return t > max ? max : t;
}

- (CGPoint)xyNormalised
{
    return CGPointMake(127*(self.xyPosition.x/CGRectGetWidth(self.bounds)), 127*(self.xyPosition.y/CGRectGetHeight(self.bounds)));
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    [self.foreColour set];
    CGContextSetLineWidth(currentContext, 1);
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, self.xyPosition.x, 0);
    CGContextAddLineToPoint(currentContext, self.xyPosition.x, rect.size.height);
    CGContextMoveToPoint(currentContext, 0, self.xyPosition.y);
    CGContextAddLineToPoint(currentContext, rect.size.width, self.xyPosition.y);
    CGContextStrokePath(currentContext);
    CGRect circleRect = CGRectOffset(CGRectMake(self.xyPosition.x, self.xyPosition.y, 30, 30), -15, -15);
    //CGContextAddEllipseInRect(currentContext, circleRect);
    CGContextFillRect(currentContext, circleRect);
    CGContextStrokePath(currentContext);
    // CGPoint xy = [self xyNormalised];
    CGContextRestoreGState(currentContext);
    [super drawRect:rect];
    
}

@end



