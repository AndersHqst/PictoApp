//
//  View.m
//  Pictowatch
//
//  Created by Anders Høst Kjærgaard on 30/08/12.
//  Copyright (c) 2012 ahkj. All rights reserved.
//

#import "ClockView.h"
#import "UIColor+Additions.h"

@implementation ClockView
@synthesize delegate;

//Max width or heigh for the clock from its center
-(int)dimension{
    return self.frame.size.height < self.frame.size.width ? self.frame.size.height / 2 : self.frame.size.width / 2;
}

//-(CGPoint)center{
//    return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
//}

float offset = 60;

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
 //   NSLog(@"View hours: %d min: %d sec: %d", [self.delegate hour], [self.delegate minute], [self.delegate second]);
 //   NSLog(@"Center %f,%f", [self center].x, [self center].y);
    UIColor* currentColor = [UIColor picto_white];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self.delegate backgroundColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    CGContextSetFillColorWithColor(context, currentColor.CGColor);
    CGContextSetShadowWithColor(context, CGSizeZero, 2, [UIColor grayColor].CGColor);

  
    float hourSpace = 360.0 / 12;
    float minInHourSpace = hourSpace / 60;
    float hourDegree  = 360.0 - ([self.delegate hour] * hourSpace) - (minInHourSpace * [self.delegate minute]);

    float clock_hour_Y = cosf(M_PI * hourDegree / 180);
    float clock_hour_X = -sinf(M_PI * hourDegree / 180);
    float x = [self center].x + (clock_hour_X * ([self dimension] - offset));
    float y = [self center].y - (clock_hour_Y * ([self dimension] - offset));
    CGContextFillEllipseInRect(context, CGRectMake(x, y, 17, 17));
    
    //Center of clock arm
    CGContextSetLineWidth(context, 14);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextMoveToPoint(context, [self center].x, [self center].y);
////    
////    int secs = ([self.delegate second] + ([self.delegate minute] * 60));
    float minDegree  = 360.0 - ((([self.delegate second] + ([self.delegate minute] * 60.f))) / 10.f);
////    NSLog(@"Min degree %f", minDegree);
////    
////    //Get x,y values turned to clock position
    float clock_Y = cosf(M_PI * minDegree / 180);
  //  NSLog(@"clock sin %f", clock_sin);
    // Hej far, dette er en kommentar
   float clock_X = -sinf(M_PI * minDegree / 180);
//NSLog(@"clockcos %f", clock_cos);
//
    CGContextSetShadowWithColor(context, CGSizeZero, 2, [UIColor grayColor].CGColor);
//    //and draw a line to position 100,100 (down and to the right)
    CGContextAddLineToPoint(context, [self center].x + (clock_X * ([self dimension] - offset)), [self center].y - (clock_Y * ([self dimension] - offset)));
    
    //Apply our stroke settings to the line.
    CGContextStrokePath(context);
}
@end
