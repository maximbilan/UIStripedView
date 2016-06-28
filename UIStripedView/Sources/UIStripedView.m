//
//  UIStripedView.m
//  UIStripedView
//
//  Created by Maxim on 5/31/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

#import "UIStripedView.h"

UIColor *UIStripedViewLineColor;
UIColor *UIStripedViewBgColor;

void drawColoredPattern(void *info, CGContextRef context)
{
	UIColor *color = UIStripedViewLineColor ? UIStripedViewLineColor : [UIColor colorWithRed:0.138 green:0.139 blue:0.132 alpha:1.000];
	CGRect r = CGRectMake(0, 0, 6, 6);
	CGContextSetLineWidth(context, 2);
	CGContextSetStrokeColorWithColor(context, color.CGColor);
	CGContextMoveToPoint(context, r.origin.x, r.origin.y);
	CGContextAddLineToPoint(context, r.origin.x , r.origin.y);
	CGContextAddLineToPoint(context, r.origin.x + r.size.width, r.origin.y + r.size.height);
	CGContextStrokePath(context);
}

@implementation UIStripedView

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	UIColor *color = UIStripedViewBgColor ? UIStripedViewBgColor : [UIColor colorWithRed:0.042 green:0.042 blue:0.045 alpha:1.000];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, rect);
 
	static const CGPatternCallbacks callbacks = {0, &drawColoredPattern, NULL};
 
	CGContextSaveGState(context);
	CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
	CGContextSetFillColorSpace(context, patternSpace);
	CGColorSpaceRelease(patternSpace);
 
	CGPatternRef pattern = CGPatternCreate(NULL, rect, CGAffineTransformIdentity, 6, 6, kCGPatternTilingConstantSpacing, YES, &callbacks);
	CGFloat alpha = 1.0;
	CGContextSetFillPattern(context, pattern, &alpha);
	CGPatternRelease(pattern);
	CGContextFillRect(context, self.bounds);
	CGContextRestoreGState(context);
}

@end
