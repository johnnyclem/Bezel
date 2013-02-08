//
//  UIBezierPath+Shapes.m
//  Bezel
//
//  Created by John Clem on 1/30/12.
//  Copyright (c) 2013 Mind Diaper. All rights reserved.
//

#import "UIBezierPath+Shapes.h"

@implementation UIBezierPath (Shapes)

+ (UIBezierPath *)pathFromString:(NSString *)string forSize:(CGSize)size
{
    CGRect frame = CGRectMake(0, 0, size.width, size.width);
    // Trim out all whitespace
	NSString *str = [[string stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@" " withString:@""];
    // Parse names of bezier path object and frame reference
    NSString *pname = [str substringWithRange:NSMakeRange(1, [str rangeOfString:@"moveToPoint"].location - 1)];
    // Split and filter into command strings
	NSRegularExpression *commandRegEx = [NSRegularExpression regularExpressionWithPattern: @"(?<=\\[).*(?=])" options: NSRegularExpressionCaseInsensitive error: nil];
    NSArray *results = [commandRegEx matchesInString: str options: NSMatchingWithTransparentBounds range: NSMakeRange(0, str.length)];
    NSMutableArray *commands = [NSMutableArray arrayWithCapacity: results.count];
    for (NSTextCheckingResult *res in results) {
        NSString *rawCom = [str substringWithRange: res.range];
        NSString *filCom = [rawCom stringByReplacingOccurrencesOfString: pname
                                                             withString:@""
                                                                options: NSLiteralSearch
                                                                  range: NSMakeRange(0.0, rawCom.length)];
        [commands addObject: filCom];
    }
    NSString *mv = @"moveToPoint:";
    NSString *addLn = @"addLineToPoint:";
    NSString *addCrv = @"addCurveToPoint:";
    NSArray *types = [NSArray arrayWithObjects: mv, addLn, addCrv, nil];
    // Now that we have commands, we can start parsing them in and building usable values.
    NSMutableArray *smplInstrctns = [NSMutableArray arrayWithCapacity: commands.count];
    for (NSString *com in commands) {
        NSString *modCom;
        for (NSString *type in types) {
            if ([com hasPrefix: type]) modCom = [com substringFromIndex:[com rangeOfString: type].length];
            if (modCom) {
                NSMutableDictionary *instruction = [NSMutableDictionary dictionary];
                NSRegularExpression *rawValExpr = [NSRegularExpression regularExpressionWithPattern:@"(?<=CGPointMake\\()(.+?)(?=\\)\\))" options:NSRegularExpressionCaseInsensitive error: nil];
                NSArray *results = [rawValExpr matchesInString:modCom options: NSMatchingWithTransparentBounds range:NSMakeRange(0, modCom.length)];
                NSMutableArray *cmplxPts = [NSMutableArray arrayWithCapacity: results.count];
                for (NSTextCheckingResult *res in results) {
                    [cmplxPts addObject: [modCom substringWithRange: NSMakeRange(res.range.location, res.range.length + 1)]];
                }
                NSMutableArray *snglPts = [NSMutableArray arrayWithCapacity: cmplxPts.count];
                for (NSString *cmplxPt in cmplxPts) {
                    [snglPts addObject: [cmplxPt componentsSeparatedByString:@","]];
                }
                NSString *getMinX = @"CGRectGetMinX(frame)";
                NSString *getMinY = @"CGRectGetMinY(frame)";
                NSMutableArray *smplPts = [NSMutableArray arrayWithCapacity: snglPts.count];
                for (NSArray *snglPt in snglPts) {
                    CGPoint pt;
                    for (NSString *val in snglPt) {
                        NSRegularExpression *innerValExp = [NSRegularExpression regularExpressionWithPattern:@"(?<=\\+)(.+?)(?=\\*)" options:NSRegularExpressionCaseInsensitive error: nil];
                        NSArray *results = [innerValExp matchesInString: val options: NSMatchingWithTransparentBounds range:NSMakeRange(0, val.length)];
                        CGFloat mltplr = [[val substringWithRange:[(NSTextCheckingResult *)[results objectAtIndex:0] range]] floatValue];
                        if ([val hasPrefix: getMinX]) {
                            pt.x = CGRectGetMinX(frame)+mltplr*CGRectGetWidth(frame);
                        } else if ([val hasPrefix: getMinY]) {
                            pt.y = CGRectGetMinX(frame)+mltplr*CGRectGetHeight(frame);
                        }
                    }
                    [smplPts addObject: [NSValue valueWithCGPoint: pt]];
                }
                
                [instruction setObject: smplPts forKey: type];
                [smplInstrctns addObject: instruction];
                break;
            };
        }
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSDictionary *instruction in smplInstrctns) {
        CGPoint pt1 = [[[[instruction allValues] objectAtIndex:0] objectAtIndex:0] CGPointValue];
        if ([instruction objectForKey: mv]) {
            [path moveToPoint: pt1];
        } else if ([instruction objectForKey: addLn]) {
            [path addLineToPoint: pt1];
        } else if ([instruction objectForKey: addCrv]) {
            CGPoint cpt1 = [[[instruction objectForKey: addCrv] objectAtIndex:1] CGPointValue];
            CGPoint cpt2 = [[[instruction objectForKey: addCrv] objectAtIndex:2] CGPointValue];
            [path addCurveToPoint: pt1 controlPoint1: cpt1 controlPoint2: cpt2];
        }
    }
    [path closePath];
    
    return path;
}

@end
