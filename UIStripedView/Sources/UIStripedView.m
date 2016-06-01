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
	CGRect r = CGRectMake(0, 0, 10, 10);
	CGContextSetLineWidth(context, 3);
	
	
	
	UIColor *uiColor = [UIColor yellowColor];
	CGColorRef color = [uiColor CGColor];
	
	NSInteger numComponents = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);
	CGFloat red = components[0];
	CGFloat green = components[1];
	CGFloat blue = components[2];
	CGFloat alpha = components[3];
	
	
	CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
	
	CGContextMoveToPoint(context, r.origin.x, r.origin.y);
	CGContextAddLineToPoint(context, r.origin.x , r.origin.y);
	CGContextAddLineToPoint(context, r.origin.x + r.size.width, r.origin.y + r.size.height);
	CGContextSetRGBFillColor(context, red, green, blue, alpha);
	CGContextStrokePath(context);
}

@implementation UIStripedView

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
 
	UIColor *bgColor = self.backgroundColor;
	CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
	CGContextFillRect(context, rect);
 
	static const CGPatternCallbacks callbacks = {0, &MyDrawColoredPattern, NULL};
 
	CGContextSaveGState(context);
	CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
	CGContextSetFillColorSpace(context, patternSpace);
	CGColorSpaceRelease(patternSpace);
 
	CGPatternRef pattern = CGPatternCreate(NULL, rect, CGAffineTransformIdentity, 10, 10, kCGPatternTilingConstantSpacing, YES, &callbacks);
	CGFloat alpha = 1.0;
	CGContextSetFillPattern(context, pattern, &alpha);
	CGPatternRelease(pattern);
	CGContextFillRect(context, self.bounds);
	CGContextRestoreGState(context);
}


@end
