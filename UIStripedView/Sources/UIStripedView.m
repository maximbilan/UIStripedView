//
//  UIStripedView.m
//  UIStripedView
//
//  Created by Maxim on 5/31/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

#import "UIStripedView.h"

void MyDrawColoredPattern (void *info, CGContextRef context)
{
	CGRect r = CGRectMake(0, 0, 5, 5);
	
	CGContextSetLineWidth(context, 3);
	CGContextMoveToPoint(context, r.origin.x, r.origin.y );
	CGContextAddLineToPoint(context, r.origin.x , r.origin.y);
	CGContextAddLineToPoint(context, r.origin.x + (r.size.width ), r.origin.y + (r.size.height));
	CGContextSetRGBFillColor (context, .5, 0, .5, 0.5);
	CGContextStrokePath(context);
}

@implementation UIStripedView

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
 
	UIColor * bgColor = [UIColor colorWithHue:0 saturation:0 brightness:0.15 alpha:1.0];
	CGContextSetFillColorWithColor(context, bgColor.CGColor);
	CGContextFillRect(context, rect);
 
	static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
 
	CGContextSaveGState(context);
	CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
	CGContextSetFillColorSpace(context, patternSpace);
	CGColorSpaceRelease(patternSpace);
 
	CGPatternRef pattern = CGPatternCreate(NULL,
										   rect,
										   CGAffineTransformIdentity,
										   5,
										   5,
										   kCGPatternTilingConstantSpacing,
										   true,
										   &callbacks);
	CGFloat alpha = 1.0;
	CGContextSetFillPattern(context, pattern, &alpha);
	CGPatternRelease(pattern);
	CGContextFillRect(context, self.bounds);
	CGContextRestoreGState(context);
}


@end
