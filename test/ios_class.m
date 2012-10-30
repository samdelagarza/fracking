//
//  PriceDisplayType.m
//  TradeStation Mobile
//
//  Created by Kekoa Vincent on 9/5/12.
//  Copyright (c) 2012 Interbank FX, LLC. All rights reserved.
//
 
#import "PriceDisplayType.h"
 
@interface PriceDisplayType()
 
- (NSDecimalNumber *)numberFromDecimalString:(NSString*)str;
- (NSDecimalNumber *)numberFromFractionalString:(NSString*)str;
- (NSDecimalNumber *)roundToNearestMinMove:(NSDecimal)value;
- (NSDecimalNumber *)formatFractionalString:(NSString *)str;
- (NSDecimalNumber *)formatMultifractionalString:(NSString *)str;
 
@end
 
@implementation PriceDisplayType
 
@synthesize base, primaryDivisor, secondaryDivisor;
 
- (id)init
{
    if (self = [super init]) {
        self.base = 10;
        self.primaryDivisor = 100;
        self.secondaryDivisor = 1;
        self.minMove = [NSDecimalNumber one];
    }
   
    return self;
}
 
+ (PriceDisplayType *)priceDisplayTypeFromString:(NSString *)str
{
    PriceDisplayType *priceDisplay = [[PriceDisplayType alloc] init];
   
    NSInteger displayType = [str integerValue];
    switch (displayType)
    {
        default:
        case 0: // "Automatic" => not used
        case 3: // 2 Decimals => .01
        case 7: // "Simplest Fraction"--not currently supported.
        {
            // set to decimal with 2 digits of precision by default
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 100;
            break;
        }
        case 1: // 0 Decimals => 1
        {
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 1;
            break;
        }
        case 2: // 1 Decimal => .1
        {
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 10;
            break;
        }
        case 4: // 3 Decimals => .001
        {
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 1000;
            break;
        }
        case 5: // 4 Decimals => .0001
        {
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 10000;
            break;
        }
        case 6: // 5 Decimals => .00001
        {
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 100000;
            break;
        }
        case 8: // 1/2 (Halves) => .5
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 2;
            break;
        }
        case 9: // 1/4 (Fourths) => .25
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 4;
            break;
        }
        case 10: // 1/8 (Eighths) => .125
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 8;
            break;
        }
        case 11: // 1/16 (Sixteenths) => .0625
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 16;
            break;
        }
        case 12: // 1/32 (ThirtySeconds) => .03125
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 32;
            break;
        }
        case 13: // 1/64-SixtyFourths => .015625
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 64;
            break;
        }
        case 14: // 1/128 (OneTwentyEighths) => .0078125
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 128;
            break;
        }
        case 15: // 1/256 (TwoFiftySixths) => .00390625
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 256;
            break;
        }
        case 16: // 10ths and Quarters => .025
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 10;
            priceDisplay.secondaryDivisor = 4;
            break;
        }
        case 17: // 32nds and Halves => .015625
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 32;
            priceDisplay.secondaryDivisor = 2;
            break;
        }
        case 18: // 32nds and Quarters => .0078125
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 32;
            priceDisplay.secondaryDivisor = 4;
            break;
        }
        case 19: // 32nds and Eights => .00390625
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 32;
            priceDisplay.secondaryDivisor = 8;
            break;
        }
        case 20: // 32nds and Tenths => .003125
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 32;
            priceDisplay.secondaryDivisor = 10;
            break;
        }
        case 21: // 64ths and Halves => .0078125
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 64;
            priceDisplay.secondaryDivisor = 2;
            break;
        }
        case 22: // 64ths and Tenths => .0015625
        {
            priceDisplay.base = 2;
            priceDisplay.primaryDivisor = 64;
            priceDisplay.secondaryDivisor = 10;
            break;
        }
        case 23: // 6 Decimals => .000001
        {
            priceDisplay.base = 10;
            priceDisplay.primaryDivisor = 1000000;
            break;
        }
    }
   
    return priceDisplay;
}
 
- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[PriceDisplayType class]]) {
        PriceDisplayType *other = (PriceDisplayType *)object;
       
        return other.base == self.base && other.primaryDivisor == self.primaryDivisor && other.secondaryDivisor == self.secondaryDivisor;
    }
   
    return NO;
}
 
- (NSDecimalNumber *)numberFromString:(NSString *)str
{
    if (self.isDecimal) {
        return [self numberFromDecimalString:str];
    }
    else if (self.isFractional) {
        return [self numberFromFractionalString:str];
    }
    else {
        return nil;
    }
}
 
- (BOOL)isDecimal
{
    return self.base == 10;
}
 
- (BOOL)isFractional
{
    return self.base == 2;
}
 
- (NSDecimalNumber*)numberFromDecimalString:(NSString*)str
{
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:str];
    if (num == [NSDecimalNumber notANumber])
    {
        // invalid number string
        return 0;
    }
   
    // limit the number to the right number of digits of precision
    int numDigits = 0;
    int divisor = self.primaryDivisor;
    while (divisor > 1)
    {
        numDigits++;
        divisor /= 10;
    }
   
    NSDecimalNumberHandler *numHandler =
    [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:numDigits
                                                raiseOnExactness:YES raiseOnOverflow:YES
                                                raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    num = [num decimalNumberByAdding:[NSDecimalNumber zero] withBehavior:numHandler];
   
    return num;
}
 
- (NSString *)formatNumerator:(NSInteger)num
{
    NSString *str = [NSString stringWithFormat:@"%d", num];
    unichar characters[str.length];
   
    for (NSInteger i=0; i < str.length; i++){
        unichar currentChar = [str characterAtIndex:i];
        switch (currentChar) {
            case '1':
                characters[i] = 0x00b9;
                break;
            case '2':
                characters[i] = 0x00b2;
                break;
            case '3':
                characters[i] = 0x00b3;
                break;
            case '4':
                characters[i] = 0x2074;
                break;
            case '5':
                characters[i] = 0x2075;
                break;
            case '6':
                characters[i] = 0x2076;
                break;
            case '7':
               characters[i] = 0x2077;
                break;
            case '8':
                characters[i] = 0x2078;
                break;
            case '9':
                characters[i] = 0x2079;
                break;
            case '0':
                characters[i] = 0x2070;
                break;
               
            default:
                characters[i] = currentChar;
                break;
        }
    }
   
    return [NSString stringWithCharacters:characters length:str.length];
}
 
- (NSString *)formatDenominator:(NSInteger)num
{
    NSString *str = [NSString stringWithFormat:@"%d", num];
    unichar characters[str.length];
   
    for (NSInteger i=0; i < str.length; i++){
        unichar currentChar = [str characterAtIndex:i];
        switch (currentChar) {
            case '1':
                characters[i] = 0x2081;
                break;
            case '2':
                characters[i] = 0x2082;
                break;
            case '3':
                characters[i] = 0x2083;
                break;
            case '4':
                characters[i] = 0x2084;
                break;
            case '5':
                characters[i] = 0x2085;
                break;
            case '6':
                characters[i] = 0x2086;
                break;
            case '7':
                characters[i] = 0x2087;
                break;
            case '8':
                characters[i] = 0x2088;
               break;
            case '9':
                characters[i] = 0x2089;
                break;
            case '0':
                characters[i] = 0x2080;
                break;
               
            default:
                characters[i] = currentChar;
                break;
        }
    }
   
    return [NSString stringWithCharacters:characters length:str.length];
}
 
- (NSDecimalNumber*)numberFromFractionalString:(NSString*)str
{
    BOOL isValidPriceFormat = NO;
    NSDecimalNumber *wholePart, *decimalPart;
    NSArray *tokens = [str componentsSeparatedByString:@" "];
    if (tokens.count == 1)
    {
        tokens = [str componentsSeparatedByString:@"'"];
        if (tokens.count == 1)
        {
            // interpret as a whole number
            isValidPriceFormat = YES;
            wholePart = [NSDecimalNumber decimalNumberWithString:str];
            decimalPart = [NSDecimalNumber zero];
        }
        else if (tokens.count == 2)
        {
            // Multi-fractional price: "99'3.5"
            isValidPriceFormat = YES;
            wholePart = [NSDecimalNumber decimalNumberWithString:[tokens objectAtIndex:0]];
            decimalPart = [self formatMultifractionalString:[tokens objectAtIndex:1]];
        }
    }
    else if (tokens.count == 2)
    {
        // Single fractional price: "99 3/8"
        isValidPriceFormat = YES;
        wholePart = [NSDecimalNumber decimalNumberWithString:[tokens objectAtIndex:0]];
        decimalPart = [self formatFractionalString:[tokens objectAtIndex:1]];
    }
 
    NSDecimalNumber *result = [NSDecimalNumber zero];
    if (isValidPriceFormat)
    {
        // make sure the numbers are valid
        if (wholePart == [NSDecimalNumber notANumber])
        {
            wholePart = [NSDecimalNumber zero];
        }
        if (decimalPart == [NSDecimalNumber notANumber])
        {
            decimalPart = [NSDecimalNumber zero];
        }
       
        // round it to the nearest fraction
        NSDecimal unroundedResult, num1, num2;
        num1 = [wholePart decimalValue];
        num2 = [decimalPart decimalValue];
        NSDecimalAdd(&unroundedResult, &num1, &num2, NSRoundPlain);
        result = [self roundToNearestMinMove:unroundedResult];
    }
   
    return result;
}
 
- (NSDecimalNumber *)formatFractionalString:(NSString *)str
{
    NSDecimal result;
    NSArray *tokens = [str componentsSeparatedByString:@"/"];
    if (tokens.count == 2)
    {
        // We have a numerator and denominator: "3/8"
        NSDecimal numerator = [[NSDecimalNumber decimalNumberWithString:[tokens objectAtIndex:0]] decimalValue];
        NSDecimal denominator = [[NSDecimalNumber decimalNumberWithString:[tokens objectAtIndex:1]] decimalValue];
        NSDecimalDivide(&result, &numerator, &denominator, NSRoundPlain);
    }
    else
    {
        // invalid format for a fractional number
        result = [[NSDecimalNumber zero] decimalValue];
    }
   
    return [NSDecimalNumber decimalNumberWithDecimal:result];
}
 
- (NSDecimalNumber *)formatMultifractionalString:(NSString *)str
{
    if (self.secondaryDivisor != 10)
    {
        // If we're not working in base 10 (this is base 2, 4, 8, etc.), convert the secondary
        // fractional representation into its numeric value: .2 => .25, .3 => .375, etc.
        NSString *appendix = @"";
        if ([str hasSuffix:@".2"] || [str hasSuffix:@".7"])
        {
            // concatenate a "5" to the string
            appendix = @"5";
        }
        else if ([str hasSuffix:@".1"] || [str hasSuffix:@".6"])
        {
            // concatenate a "25" to the string
            appendix = @"25";
        }
        else if ([str hasSuffix:@".3"] || [str hasSuffix:@".8"])
        {
            // concatenate a "75" to the string
            appendix = @"75";
        }
        str = [str stringByAppendingString:appendix];
    }
   
    // Now we can turn the string into its decimal represenation and multiply by the primary divisor and we're done.
    NSDecimal result;
    NSDecimal value = [[NSDecimalNumber decimalNumberWithString:str] decimalValue];
    NSDecimal divisor = [[NSDecimalNumber numberWithInt:self.primaryDivisor] decimalValue];
    NSDecimalDivide(&result, &value, &divisor, NSRoundPlain);
   
    return [NSDecimalNumber decimalNumberWithDecimal:result];
}
 
- (NSString *)formatDecimalNumber:(NSDecimalNumber *)number
{
    return [number description];
}
 
- (NSString *)stringFromNumber:(NSDecimalNumber *)number
{
    return [self stringFromNumber:number displayOnly:YES];
}
 
- (NSString *)stringFromNumber:(NSDecimalNumber *)number displayOnly:(BOOL)displayOnly
{
    BOOL isMultiFractional = self.secondaryDivisor != 1;
   
    NSDecimal decNumber = [number decimalValue];
//    EFLog(@"Decimal Number: %@", [NSDecimalNumber decimalNumberWithDecimal:decNumber]);
   
    /// Round to the smallest increment if we are display only
    if(displayOnly) {
        NSDecimal smallestIncrement = [[NSDecimalNumber decimalNumberWithMantissa:(self.secondaryDivisor * self.primaryDivisor)
                                          exponent:0 isNegative:NO] decimalValue];
       
        NSDecimalMultiply(&decNumber, &decNumber, &smallestIncrement, NSRoundPlain);
        NSDecimalRound(&decNumber, &decNumber, 0, NSRoundPlain);
        NSDecimalDivide(&decNumber, &decNumber, &smallestIncrement, NSRoundPlain);
       
    }
   
    BOOL isNegative = decNumber._isNegative;
   
    NSDecimal wholePart;
    NSDecimalRound(&wholePart, &decNumber, 0, (decNumber._isNegative) ? NSRoundUp : NSRoundDown);
   
    NSInteger wholePartInt = [[NSDecimalNumber decimalNumberWithDecimal:wholePart] integerValue];
   
    NSDecimalSubtract(&decNumber, &decNumber, &wholePart, NSRoundDown);
//    DFLog(@"Decimal Number: %@", [NSDecimalNumber decimalNumberWithDecimal:decNumber]);
 
    // The rest of the number should only be positive, the sign is already preserved in the whole part(except when whole part is zero)
    if (decNumber._isNegative) {
        decNumber._isNegative = NO;
    }
   
    NSDecimal primaryDivisorDec = [[NSDecimalNumber decimalNumberWithMantissa:self.primaryDivisor exponent:0 isNegative:NO] decimalValue];
//    DFLog(@"Primary Divisor: %@", [NSDecimalNumber decimalNumberWithDecimal:primaryDivisorDec]);
       
    NSDecimal primaryFraction;
    NSDecimalMultiply(&primaryFraction, &decNumber, &primaryDivisorDec, NSRoundDown);
//    DFLog(@"Primary Fraction: %@", [NSDecimalNumber decimalNumberWithDecimal:primaryFraction]);
    // At this point, the primary fraction might not be a whole number... multifractional will do further work
   
    NSString *stringValue = nil;
   
    if (isMultiFractional) {
        NSDecimal primaryStepSubtractor;
       
        NSDecimalRound(&primaryFraction, &primaryFraction, 0, NSRoundDown);
        //    DFLog(@"Primary fraction: %@", [NSDecimalNumber decimalNumberWithDecimal:primaryFraction]);
        NSInteger primaryPart = [[NSDecimalNumber decimalNumberWithDecimal:primaryFraction ] integerValue];
       
        NSDecimalDivide(&primaryStepSubtractor, &primaryFraction, &primaryDivisorDec, NSRoundDown);
       
//    DFLog(@"Primary Step subtractor: %@", [NSDecimalNumber decimalNumberWithDecimal:primaryStepSubtractor]);
       
        NSDecimalSubtract(&decNumber, &decNumber, &primaryStepSubtractor, NSRoundDown);
       
        //    DFLog(@"Decimal Number: %@", [NSDecimalNumber decimalNumberWithDecimal:decNumber]);
 
       
        NSDecimal secondaryStepSizeDenom = [[NSDecimalNumber decimalNumberWithMantissa:(self.secondaryDivisor * self.primaryDivisor) exponent:0 isNegative:NO] decimalValue];
//        DFLog(@"Secondary step size: %@", [NSDecimalNumber decimalNumberWithDecimal:secondaryStepSize]);
       
        NSDecimal secondaryFraction;
        NSDecimalMultiply(&secondaryFraction, &decNumber, &secondaryStepSizeDenom, NSRoundDown);
//        DFLog(@"Secondary Fraction: %@", [NSDecimalNumber decimalNumberWithDecimal:secondaryFraction]);
       
        NSDecimalNumber *secondaryCountNumber = [NSDecimalNumber decimalNumberWithDecimal:secondaryFraction];
        NSInteger secondaryInt = [secondaryCountNumber integerValue];
        double secondaryFloat = [secondaryCountNumber doubleValue];
       
        if(secondaryFloat - secondaryInt != 0) {
            // If this number is not a whole number, then the number is not on fractional boundaries for this type.. return the long decimal as a fallback
            return [number description];
        }
       
        // Only need the first digit of the result
        NSDecimal divisorDec = [[NSDecimalNumber decimalNumberWithMantissa:self.secondaryDivisor exponent:-1 isNegative:NO] decimalValue];
       
        NSDecimalDivide(&secondaryFraction, &secondaryFraction, &divisorDec, NSRoundDown);
//        DFLog(@"Secondary Fraction: %@", [NSDecimalNumber decimalNumberWithDecimal:secondaryFraction]);
        NSDecimalRound(&secondaryFraction, &secondaryFraction, 1, NSRoundDown);
//        DFLog(@"Secondary Fraction: %@", [NSDecimalNumber decimalNumberWithDecimal:secondaryFraction]);
       
        NSInteger secondaryPart = [[NSDecimalNumber decimalNumberWithDecimal:secondaryFraction] integerValue];
       
        if(wholePartInt == 0 && isNegative) {
            stringValue = [NSString stringWithFormat:@"-%d'%02d.%d", wholePartInt, primaryPart, secondaryPart];
        } else {
            stringValue = [NSString stringWithFormat:@"%d'%02d.%d", wholePartInt, primaryPart, secondaryPart];
        }
    } else {
        // Single-fractional, only display the fractional part if it is non-zero
       
        NSDecimalNumber *primaryNumber = [NSDecimalNumber decimalNumberWithDecimal:primaryFraction ];
        double primaryWithFraction = [primaryNumber doubleValue];
        NSInteger primaryPart = [primaryNumber integerValue];
       
        if (primaryWithFraction - (double)primaryPart != 0) {
            // There are left over digits, so we cannot properly format the fraction
            return [number description];
        }
       
        if(primaryPart > 0) {
            if(self.isDecimal) {
                int power = (int)log10(self.primaryDivisor);
                NSString *formatString;
                if(wholePartInt == 0 && isNegative) {
                    formatString = [NSString stringWithFormat:@"-%%d.%%0%dd", power];
                } else {
                    formatString = [NSString stringWithFormat:@"%%d.%%0%dd", power];
                }
                stringValue = [NSString stringWithFormat:formatString, wholePartInt, primaryPart];
            } else {
                if(displayOnly) {
                    // Format fractionals using unicode super and subscripts
                    if(wholePartInt != 0) {
                        stringValue = [NSString stringWithFormat:@"%d%@\u2044%@", wholePartInt, [self formatNumerator:primaryPart], [self formatDenominator:self.primaryDivisor]];
                    } else if(isNegative) {
                        stringValue = [NSString stringWithFormat:@"-%@\u2044%@", [self formatNumerator:primaryPart], [self formatDenominator:self.primaryDivisor]];
                    } else {
                        stringValue = [NSString stringWithFormat:@"%@\u2044%@", [self formatNumerator:primaryPart], [self formatDenominator:self.primaryDivisor]];
                    }
                }
                else {
                    // Standard output that can be parsed and edited by user
                    if(wholePartInt != 0) {
                        stringValue = [NSString stringWithFormat:@"%d %d/%d", wholePartInt, primaryPart, self.primaryDivisor];
                    } else if(isNegative) {
                        stringValue = [NSString stringWithFormat:@"-%d/%d", primaryPart, self.primaryDivisor];
                    } else {
                        stringValue = [NSString stringWithFormat:@"%d/%d", primaryPart, self.primaryDivisor];
                    }
                }
            }
        } else {
            if(self.isDecimal && self.primaryDivisor > 1) {
                int power = (int)log10(self.primaryDivisor);
                NSString *zeroes = [@"" stringByPaddingToLength:power withString:@"0" startingAtIndex:0];
                stringValue = [NSString stringWithFormat:@"%d.%@", wholePartInt, zeroes];
            } else {
                stringValue = [NSString stringWithFormat:@"%d", wholePartInt];
            }
        }
    }
   
//    DFLog(@"%@ = %@", number, stringValue);
   
    return stringValue;
}
 
- (NSDecimalNumber *)roundToNearestMinMove:(NSDecimal)value
{
    // get the min move
    NSDecimal one = [[NSDecimalNumber one] decimalValue];
    NSDecimal increment = [self smallestIncrement];
    NSDecimalDivide(&increment, &one, &increment, NSRoundPlain);
   
    // and round to it
    NSDecimal result;
    NSDecimalMultiply(&result, &value, &increment, NSRoundPlain);
    NSDecimalRound(&result, &result, 0, NSRoundPlain);
    NSDecimalDivide(&result, &result, &increment, NSRoundPlain);
 
    return [NSDecimalNumber decimalNumberWithDecimal:result];
}
 
- (NSDecimal)incrementValue:(NSDecimal)value
{
    NSDecimal result;
    NSDecimal increment = [self smallestIncrement];
    NSDecimalAdd(&result, &value, &increment, NSRoundPlain);
   
    return result;
}
 
- (NSDecimal)decrementValue:(NSDecimal)value
{
    NSDecimal result;
    NSDecimal increment = [self smallestIncrement];
    NSDecimalSubtract(&result, &value, &increment, NSRoundPlain);
   
    // if result is negative, set back to zero
    NSDecimal zero = [[NSDecimalNumber zero] decimalValue];
    if (NSDecimalCompare(&result, &zero) < 0)
    {
        result = zero;
    }
 
    return result;
}
 
- (NSDecimal)smallestIncrement
{
    NSDecimal smallestIncrement = [[self.minMove decimalNumberByDividingBy:
                                    [NSDecimalNumber decimalNumberWithMantissa:(self.secondaryDivisor * self.primaryDivisor)
                                                                      exponent:0 isNegative:NO]] decimalValue];
    
    return smallestIncrement;
}
 
@end

TradeStation Group, Inc. is the parent company of four operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), IBFX, Inc. (Member NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and delete the material from any computer. Forex products and services are offered by TradeStation Forex, a division of IBFX, Inc.