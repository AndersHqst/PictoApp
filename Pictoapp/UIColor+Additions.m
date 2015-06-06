//
//  UIColor+Additions.m
//  Pictowatch
//
//  Created by Anders Høst Kjærgaard on 06/06/15.
//
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(UIColor *)picto_black {
    static UIColor *black = nil;
    if(!black){
        black = [UIColor colorFromHexString:@"#131313"];
    }
    return black;
}

+(UIColor *)picto_white {
    static UIColor *white = nil;
    if(!white){
        white = [UIColor colorFromHexString:@"#E6E6E6"];
//        white = [UIColor blueColor];
    }
    return white;
}

@end
