//
//  PriceDisplayTypeTests.m
//  TradeStation Mobile
//
//  Created by Kekoa Vincent on 9/6/12.
//  Copyright (c) 2012 Interbank FX, LLC. All rights reserved.
//
 
#import "PriceDisplayTypeTests.h"
#import "PriceDisplayType.h"
 
@implementation PriceDisplayTypeTests
 
#pragma mark - stringFromNumber Test Harness
 
-(void)assertDisplayType:(PriceDisplayType *)displayType decimalString:(NSString *)decimalString formatsTo:(NSString *)expected
{
    [self assertDisplayType:displayType
              decimalString:decimalString
                  formatsTo:expected
                displayOnly:NO];
}
 
-(void)assertDisplayType:(PriceDisplayType *)displayType decimalString:(NSString *)decimalString formatsTo:(NSString *)expected displayOnly:(BOOL)displayOnly
{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:decimalString];
   
    NSString *stringRep = [displayType stringFromNumber:number displayOnly:displayOnly];
   
    TFLog(@"%@ = %@", number, stringRep);
   
    STAssertTrue([stringRep isEqualToString:expected], [NSString stringWithFormat:@"%@ formats to %@, expected:%@", decimalString, stringRep, expected]);
}
 
#pragma mark - Decimal String From Number
 
- (void)test0Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 1;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"21.07" formatsTo:@"21.07"];
    [self assertDisplayType:displayType decimalString:@"11.7" formatsTo:@"11.7"];
    [self assertDisplayType:displayType decimalString:@"11.0" formatsTo:@"11"];
    [self assertDisplayType:displayType decimalString:@"11.5" formatsTo:@"11.5"];
    [self assertDisplayType:displayType decimalString:@"-11.5" formatsTo:@"-11.5"];
    [self assertDisplayType:displayType decimalString:@"-11" formatsTo:@"-11"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.5"];
}
 
- (void)test1Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 10;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0.0"];
    [self assertDisplayType:displayType decimalString:@"21.07" formatsTo:@"21.07"];
    [self assertDisplayType:displayType decimalString:@"21.7" formatsTo:@"21.7"];
    [self assertDisplayType:displayType decimalString:@"21.0" formatsTo:@"21.0"];
    [self assertDisplayType:displayType decimalString:@"21.5" formatsTo:@"21.5"];
    [self assertDisplayType:displayType decimalString:@"-21.5" formatsTo:@"-21.5"];
    [self assertDisplayType:displayType decimalString:@"-21" formatsTo:@"-21.0"];
    [self assertDisplayType:displayType decimalString:@"-21.232" formatsTo:@"-21.232"];
    [self assertDisplayType:displayType decimalString:@"-21.2333" formatsTo:@"-21.2333"];
    [self assertDisplayType:displayType decimalString:@"-21.12245" formatsTo:@"-21.12245"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.5"];
}
 
- (void)test2Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 100;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0.00"];
    [self assertDisplayType:displayType decimalString:@"31.07" formatsTo:@"31.07"];
    [self assertDisplayType:displayType decimalString:@"31.7" formatsTo:@"31.70"];
    [self assertDisplayType:displayType decimalString:@"31.0" formatsTo:@"31.00"];
    [self assertDisplayType:displayType decimalString:@"31.5" formatsTo:@"31.50"];
    [self assertDisplayType:displayType decimalString:@"31.25" formatsTo:@"31.25"];
    [self assertDisplayType:displayType decimalString:@"-31.5" formatsTo:@"-31.50"];
    [self assertDisplayType:displayType decimalString:@"-31" formatsTo:@"-31.00"];
    [self assertDisplayType:displayType decimalString:@"-31.232" formatsTo:@"-31.232"];
    [self assertDisplayType:displayType decimalString:@"-31.2333" formatsTo:@"-31.2333"];
    [self assertDisplayType:displayType decimalString:@"-31.12245" formatsTo:@"-31.12245"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.50"];
}
 
- (void)test3Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 1000;
   displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0.000"];
    [self assertDisplayType:displayType decimalString:@"31.07" formatsTo:@"31.070"];
    [self assertDisplayType:displayType decimalString:@"31.7" formatsTo:@"31.700"];
    [self assertDisplayType:displayType decimalString:@"31.0" formatsTo:@"31.000"];
    [self assertDisplayType:displayType decimalString:@"31.5" formatsTo:@"31.500"];
    [self assertDisplayType:displayType decimalString:@"31.25" formatsTo:@"31.250"];
    [self assertDisplayType:displayType decimalString:@"-31.5" formatsTo:@"-31.500"];
    [self assertDisplayType:displayType decimalString:@"-31" formatsTo:@"-31.000"];
    [self assertDisplayType:displayType decimalString:@"-31.232" formatsTo:@"-31.232"];
    [self assertDisplayType:displayType decimalString:@"-31.2333" formatsTo:@"-31.2333"];
    [self assertDisplayType:displayType decimalString:@"-31.12245" formatsTo:@"-31.12245"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.500"];
}
 
- (void)test4Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 10000;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0.0000"];
    [self assertDisplayType:displayType decimalString:@"41.07" formatsTo:@"41.0700"];
    [self assertDisplayType:displayType decimalString:@"41.007" formatsTo:@"41.0070"];
    [self assertDisplayType:displayType decimalString:@"41.0007" formatsTo:@"41.0007"];
    [self assertDisplayType:displayType decimalString:@"41.7" formatsTo:@"41.7000"];
    [self assertDisplayType:displayType decimalString:@"41.0" formatsTo:@"41.0000"];
    [self assertDisplayType:displayType decimalString:@"41.5" formatsTo:@"41.5000"];
    [self assertDisplayType:displayType decimalString:@"41.25" formatsTo:@"41.2500"];
    [self assertDisplayType:displayType decimalString:@"-41.5" formatsTo:@"-41.5000"];
    [self assertDisplayType:displayType decimalString:@"-41.123" formatsTo:@"-41.1230"];
    [self assertDisplayType:displayType decimalString:@"-41.1234" formatsTo:@"-41.1234"];
    [self assertDisplayType:displayType decimalString:@"-41.12345" formatsTo:@"-41.12345"];
    [self assertDisplayType:displayType decimalString:@"-41" formatsTo:@"-41.0000"];
    [self assertDisplayType:displayType decimalString:@"-41.232" formatsTo:@"-41.2320"];
    [self assertDisplayType:displayType decimalString:@"-41.2333" formatsTo:@"-41.2333"];
    [self assertDisplayType:displayType decimalString:@"-41.12245" formatsTo:@"-41.12245"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.5000"];
}
 
- (void)test5Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 100000;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0.00000"];
    [self assertDisplayType:displayType decimalString:@"51.07" formatsTo:@"51.07000"];
    [self assertDisplayType:displayType decimalString:@"51.007" formatsTo:@"51.00700"];
    [self assertDisplayType:displayType decimalString:@"51.0007" formatsTo:@"51.00070"];
    [self assertDisplayType:displayType decimalString:@"51.00007" formatsTo:@"51.00007"];
    [self assertDisplayType:displayType decimalString:@"51.7" formatsTo:@"51.70000"];
    [self assertDisplayType:displayType decimalString:@"51.0" formatsTo:@"51.00000"];
    [self assertDisplayType:displayType decimalString:@"51.5" formatsTo:@"51.50000"];
    [self assertDisplayType:displayType decimalString:@"51.25" formatsTo:@"51.25000"];
    [self assertDisplayType:displayType decimalString:@"51.123" formatsTo:@"51.12300"];
    [self assertDisplayType:displayType decimalString:@"51.1234" formatsTo:@"51.12340"];
    [self assertDisplayType:displayType decimalString:@"51.12345" formatsTo:@"51.12345"];
    [self assertDisplayType:displayType decimalString:@"51.123456" formatsTo:@"51.123456"];
    [self assertDisplayType:displayType decimalString:@"51.1234567" formatsTo:@"51.1234567"];
    [self assertDisplayType:displayType decimalString:@"51.12345678" formatsTo:@"51.12345678"];
    [self assertDisplayType:displayType decimalString:@"-51.5" formatsTo:@"-51.50000"];
    [self assertDisplayType:displayType decimalString:@"-51" formatsTo:@"-51.00000"];
    [self assertDisplayType:displayType decimalString:@"-51.232" formatsTo:@"-51.23200"];
    [self assertDisplayType:displayType decimalString:@"-51.2333" formatsTo:@"-51.23330"];
    [self assertDisplayType:displayType decimalString:@"-51.12245" formatsTo:@"-51.12245"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.50000"];
}
 
- (void)test6Decimals
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 1000000;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0.000000"];
    [self assertDisplayType:displayType decimalString:@"61.07" formatsTo:@"61.070000"];
    [self assertDisplayType:displayType decimalString:@"61.007" formatsTo:@"61.007000"];
    [self assertDisplayType:displayType decimalString:@"61.0007" formatsTo:@"61.000700"];
    [self assertDisplayType:displayType decimalString:@"61.00007" formatsTo:@"61.000070"];
    [self assertDisplayType:displayType decimalString:@"61.000007" formatsTo:@"61.000007"];
    [self assertDisplayType:displayType decimalString:@"61.7" formatsTo:@"61.700000"];
    [self assertDisplayType:displayType decimalString:@"61.0" formatsTo:@"61.000000"];
    [self assertDisplayType:displayType decimalString:@"61.5" formatsTo:@"61.500000"];
    [self assertDisplayType:displayType decimalString:@"61.25" formatsTo:@"61.250000"];
    [self assertDisplayType:displayType decimalString:@"61.123" formatsTo:@"61.123000"];
    [self assertDisplayType:displayType decimalString:@"61.1234" formatsTo:@"61.123400"];
    [self assertDisplayType:displayType decimalString:@"61.12345" formatsTo:@"61.123450"];
    [self assertDisplayType:displayType decimalString:@"61.123456" formatsTo:@"61.123456"];
    [self assertDisplayType:displayType decimalString:@"61.1234567" formatsTo:@"61.1234567"];
    [self assertDisplayType:displayType decimalString:@"61.12345678" formatsTo:@"61.12345678"];
    [self assertDisplayType:displayType decimalString:@"-61.5" formatsTo:@"-61.500000"];
    [self assertDisplayType:displayType decimalString:@"-61" formatsTo:@"-61.000000"];
    [self assertDisplayType:displayType decimalString:@"-61.232" formatsTo:@"-61.232000"];
    [self assertDisplayType:displayType decimalString:@"-61.2333" formatsTo:@"-61.233300"];
    [self assertDisplayType:displayType decimalString:@"-61.12245" formatsTo:@"-61.122450"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-0.500000"];
}
 
#pragma mark - Single Fractional String From Number
 
- (void)testHalvesToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 2;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"11.0" formatsTo:@"11"];
    [self assertDisplayType:displayType decimalString:@"99.5" formatsTo:@"99 1/2"];
    [self assertDisplayType:displayType decimalString:@"0.5" formatsTo:@"1/2"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-1/2"];
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"11.0" formatsTo:@"11"];
    [self assertDisplayType:displayType decimalString:@"99.5" formatsTo:@"99 1/2"];
    [self assertDisplayType:displayType decimalString:@"0.5" formatsTo:@"1/2"];
    [self assertDisplayType:displayType decimalString:@"-0.5" formatsTo:@"-1/2"];
}
 
- (void)testFourthsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 4;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"74.0" formatsTo:@"74"];
    [self assertDisplayType:displayType decimalString:@"33.25" formatsTo:@"33 1/4"];
    [self assertDisplayType:displayType decimalString:@"43.5" formatsTo:@"43 2/4"];
    [self assertDisplayType:displayType decimalString:@"193.75" formatsTo:@"193 3/4"];
    [self assertDisplayType:displayType decimalString:@"0.75" formatsTo:@"3/4"];
    [self assertDisplayType:displayType decimalString:@"-0.75" formatsTo:@"-3/4"];
}
 
- (void)testEighthsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 8;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995 1/8"];
    [self assertDisplayType:displayType decimalString:@"334.25" formatsTo:@"334 2/8"];
    [self assertDisplayType:displayType decimalString:@"567.375" formatsTo:@"567 3/8"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474 4/8"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272 5/8"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101 6/8"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263 7/8"];
    [self assertDisplayType:displayType decimalString:@"0.875" formatsTo:@"7/8"];
    [self assertDisplayType:displayType decimalString:@"-0.875" formatsTo:@"-7/8"];
}
 
- (void)testSixteenthsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 16;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995 1/16"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995 2/16"];
    [self assertDisplayType:displayType decimalString:@"995.1875" formatsTo:@"995 3/16"];
    [self assertDisplayType:displayType decimalString:@"334.25" formatsTo:@"334 4/16"];
    [self assertDisplayType:displayType decimalString:@"995.3125" formatsTo:@"995 5/16"];
    [self assertDisplayType:displayType decimalString:@"567.375" formatsTo:@"567 6/16"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995 7/16"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474 8/16"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995 9/16"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272 10/16"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995 11/16"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101 12/16"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995 13/16"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263 14/16"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995 15/16"];
    [self assertDisplayType:displayType decimalString:@"0.9375" formatsTo:@"15/16"];
    [self assertDisplayType:displayType decimalString:@"-0.9375" formatsTo:@"-15/16"];
   
}
 
- (void)testThirtySecondsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101"];
    [self assertDisplayType:displayType decimalString:@"995.03125" formatsTo:@"995 1/32"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995 2/32"];
    [self assertDisplayType:displayType decimalString:@"995.09375" formatsTo:@"995 3/32"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995 4/32"];
    [self assertDisplayType:displayType decimalString:@"995.15625" formatsTo:@"995 5/32"];
    [self assertDisplayType:displayType decimalString:@"334.1875" formatsTo:@"334 6/32"];
    [self assertDisplayType:displayType decimalString:@"995.21875" formatsTo:@"995 7/32"];
    [self assertDisplayType:displayType decimalString:@"995.25" formatsTo:@"995 8/32"];
    [self assertDisplayType:displayType decimalString:@"995.28125" formatsTo:@"995 9/32"];
    [self assertDisplayType:displayType decimalString:@"567.3125" formatsTo:@"567 10/32"];
    [self assertDisplayType:displayType decimalString:@"995.34375" formatsTo:@"995 11/32"];
    [self assertDisplayType:displayType decimalString:@"995.375" formatsTo:@"995 12/32"];
    [self assertDisplayType:displayType decimalString:@"995.40625" formatsTo:@"995 13/32"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995 14/32"];
    [self assertDisplayType:displayType decimalString:@"995.46875" formatsTo:@"995 15/32"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474 16/32"];
    [self assertDisplayType:displayType decimalString:@"995.53125" formatsTo:@"995 17/32"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995 18/32"];
    [self assertDisplayType:displayType decimalString:@"995.59375" formatsTo:@"995 19/32"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272 20/32"];
    [self assertDisplayType:displayType decimalString:@"995.65625" formatsTo:@"995 21/32"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995 22/32"];
    [self assertDisplayType:displayType decimalString:@"995.71875" formatsTo:@"995 23/32"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101 24/32"];
    [self assertDisplayType:displayType decimalString:@"995.78125" formatsTo:@"995 25/32"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995 26/32"];
    [self assertDisplayType:displayType decimalString:@"995.84375" formatsTo:@"995 27/32"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263 28/32"];
    [self assertDisplayType:displayType decimalString:@"995.90625" formatsTo:@"995 29/32"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995 30/32"];
    [self assertDisplayType:displayType decimalString:@"995.96875" formatsTo:@"995 31/32"];
    [self assertDisplayType:displayType decimalString:@"0.96875" formatsTo:@"31/32"];
    [self assertDisplayType:displayType decimalString:@"-0.96875" formatsTo:@"-31/32"];
   
}
 
- (void)testSixtyFourthsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 64;
   displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101"];
    [self assertDisplayType:displayType decimalString:@"995.015625" formatsTo:@"995 1/64"];
    [self assertDisplayType:displayType decimalString:@"995.03125" formatsTo:@"995 2/64"];
    [self assertDisplayType:displayType decimalString:@"995.046875" formatsTo:@"995 3/64"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995 4/64"];
    [self assertDisplayType:displayType decimalString:@"995.078125" formatsTo:@"995 5/64"];
    [self assertDisplayType:displayType decimalString:@"995.09375" formatsTo:@"995 6/64"];
    [self assertDisplayType:displayType decimalString:@"995.109375" formatsTo:@"995 7/64"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995 8/64"];
    [self assertDisplayType:displayType decimalString:@"995.140625" formatsTo:@"995 9/64"];
    [self assertDisplayType:displayType decimalString:@"995.15625" formatsTo:@"995 10/64"];
    [self assertDisplayType:displayType decimalString:@"995.171875" formatsTo:@"995 11/64"];
    [self assertDisplayType:displayType decimalString:@"334.1875" formatsTo:@"334 12/64"];
    [self assertDisplayType:displayType decimalString:@"995.203125" formatsTo:@"995 13/64"];
    [self assertDisplayType:displayType decimalString:@"995.21875" formatsTo:@"995 14/64"];
    [self assertDisplayType:displayType decimalString:@"995.234375" formatsTo:@"995 15/64"];
    [self assertDisplayType:displayType decimalString:@"995.25" formatsTo:@"995 16/64"];
    [self assertDisplayType:displayType decimalString:@"995.265625" formatsTo:@"995 17/64"];
    [self assertDisplayType:displayType decimalString:@"995.28125" formatsTo:@"995 18/64"];
    [self assertDisplayType:displayType decimalString:@"995.296875" formatsTo:@"995 19/64"];
    [self assertDisplayType:displayType decimalString:@"567.3125" formatsTo:@"567 20/64"];
    [self assertDisplayType:displayType decimalString:@"995.328125" formatsTo:@"995 21/64"];
    [self assertDisplayType:displayType decimalString:@"995.34375" formatsTo:@"995 22/64"];
    [self assertDisplayType:displayType decimalString:@"995.359375" formatsTo:@"995 23/64"];
    [self assertDisplayType:displayType decimalString:@"995.375" formatsTo:@"995 24/64"];
    [self assertDisplayType:displayType decimalString:@"995.390625" formatsTo:@"995 25/64"];
    [self assertDisplayType:displayType decimalString:@"995.40625" formatsTo:@"995 26/64"];
    [self assertDisplayType:displayType decimalString:@"995.421875" formatsTo:@"995 27/64"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995 28/64"];
    [self assertDisplayType:displayType decimalString:@"995.453125" formatsTo:@"995 29/64"];
    [self assertDisplayType:displayType decimalString:@"995.46875" formatsTo:@"995 30/64"];
    [self assertDisplayType:displayType decimalString:@"995.484375" formatsTo:@"995 31/64"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474 32/64"];
    [self assertDisplayType:displayType decimalString:@"995.515625" formatsTo:@"995 33/64"];
    [self assertDisplayType:displayType decimalString:@"995.53125" formatsTo:@"995 34/64"];
    [self assertDisplayType:displayType decimalString:@"995.546875" formatsTo:@"995 35/64"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995 36/64"];
    [self assertDisplayType:displayType decimalString:@"995.578125" formatsTo:@"995 37/64"];
    [self assertDisplayType:displayType decimalString:@"995.59375" formatsTo:@"995 38/64"];
    [self assertDisplayType:displayType decimalString:@"995.609375" formatsTo:@"995 39/64"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272 40/64"];
    [self assertDisplayType:displayType decimalString:@"995.640625" formatsTo:@"995 41/64"];
    [self assertDisplayType:displayType decimalString:@"995.65625" formatsTo:@"995 42/64"];
    [self assertDisplayType:displayType decimalString:@"995.671875" formatsTo:@"995 43/64"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995 44/64"];
    [self assertDisplayType:displayType decimalString:@"995.703125" formatsTo:@"995 45/64"];
    [self assertDisplayType:displayType decimalString:@"995.71875" formatsTo:@"995 46/64"];
    [self assertDisplayType:displayType decimalString:@"995.734375" formatsTo:@"995 47/64"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101 48/64"];
    [self assertDisplayType:displayType decimalString:@"995.765625" formatsTo:@"995 49/64"];
    [self assertDisplayType:displayType decimalString:@"995.78125" formatsTo:@"995 50/64"];
    [self assertDisplayType:displayType decimalString:@"995.796875" formatsTo:@"995 51/64"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995 52/64"];
    [self assertDisplayType:displayType decimalString:@"995.828125" formatsTo:@"995 53/64"];
    [self assertDisplayType:displayType decimalString:@"995.84375" formatsTo:@"995 54/64"];
    [self assertDisplayType:displayType decimalString:@"995.859375" formatsTo:@"995 55/64"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263 56/64"];
    [self assertDisplayType:displayType decimalString:@"995.890625" formatsTo:@"995 57/64"];
    [self assertDisplayType:displayType decimalString:@"995.90625" formatsTo:@"995 58/64"];
    [self assertDisplayType:displayType decimalString:@"995.921875" formatsTo:@"995 59/64"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995 60/64"];
    [self assertDisplayType:displayType decimalString:@"995.953125" formatsTo:@"995 61/64"];
    [self assertDisplayType:displayType decimalString:@"995.96875" formatsTo:@"995 62/64"];
    [self assertDisplayType:displayType decimalString:@"995.984375" formatsTo:@"995 63/64"];
    [self assertDisplayType:displayType decimalString:@"0.984375" formatsTo:@"63/64"];
    [self assertDisplayType:displayType decimalString:@"-0.984375" formatsTo:@"-63/64"];
   
}
 
-(void)testOneTwentyEighthsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 128;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101"];
    [self assertDisplayType:displayType decimalString:@"995.0078125" formatsTo:@"995 1/128"];
    [self assertDisplayType:displayType decimalString:@"995.015625" formatsTo:@"995 2/128"];
    [self assertDisplayType:displayType decimalString:@"995.0234375" formatsTo:@"995 3/128"];
    [self assertDisplayType:displayType decimalString:@"995.03125" formatsTo:@"995 4/128"];
    [self assertDisplayType:displayType decimalString:@"995.0390625" formatsTo:@"995 5/128"];
    [self assertDisplayType:displayType decimalString:@"995.046875" formatsTo:@"995 6/128"];
    [self assertDisplayType:displayType decimalString:@"995.0546875" formatsTo:@"995 7/128"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995 8/128"];
    [self assertDisplayType:displayType decimalString:@"995.0703125" formatsTo:@"995 9/128"];
    [self assertDisplayType:displayType decimalString:@"995.078125" formatsTo:@"995 10/128"];
    [self assertDisplayType:displayType decimalString:@"995.0859375" formatsTo:@"995 11/128"];
    [self assertDisplayType:displayType decimalString:@"995.09375" formatsTo:@"995 12/128"];
    [self assertDisplayType:displayType decimalString:@"995.1015625" formatsTo:@"995 13/128"];
    [self assertDisplayType:displayType decimalString:@"995.109375" formatsTo:@"995 14/128"];
    [self assertDisplayType:displayType decimalString:@"995.1171875" formatsTo:@"995 15/128"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995 16/128"];
    [self assertDisplayType:displayType decimalString:@"995.1328125" formatsTo:@"995 17/128"];
    [self assertDisplayType:displayType decimalString:@"995.140625" formatsTo:@"995 18/128"];
    [self assertDisplayType:displayType decimalString:@"995.1484375" formatsTo:@"995 19/128"];
    [self assertDisplayType:displayType decimalString:@"995.15625" formatsTo:@"995 20/128"];
    [self assertDisplayType:displayType decimalString:@"995.1640625" formatsTo:@"995 21/128"];
    [self assertDisplayType:displayType decimalString:@"995.171875" formatsTo:@"995 22/128"];
    [self assertDisplayType:displayType decimalString:@"995.1796875" formatsTo:@"995 23/128"];
    [self assertDisplayType:displayType decimalString:@"334.1875" formatsTo:@"334 24/128"];
    [self assertDisplayType:displayType decimalString:@"995.1953125" formatsTo:@"995 25/128"];
    [self assertDisplayType:displayType decimalString:@"995.203125" formatsTo:@"995 26/128"];
    [self assertDisplayType:displayType decimalString:@"995.2109375" formatsTo:@"995 27/128"];
    [self assertDisplayType:displayType decimalString:@"995.21875" formatsTo:@"995 28/128"];
    [self assertDisplayType:displayType decimalString:@"995.2265625" formatsTo:@"995 29/128"];
    [self assertDisplayType:displayType decimalString:@"995.234375" formatsTo:@"995 30/128"];
    [self assertDisplayType:displayType decimalString:@"995.2421875" formatsTo:@"995 31/128"];
    [self assertDisplayType:displayType decimalString:@"995.25" formatsTo:@"995 32/128"];
    [self assertDisplayType:displayType decimalString:@"995.2578125" formatsTo:@"995 33/128"];
    [self assertDisplayType:displayType decimalString:@"995.265625" formatsTo:@"995 34/128"];
    [self assertDisplayType:displayType decimalString:@"995.2734375" formatsTo:@"995 35/128"];
    [self assertDisplayType:displayType decimalString:@"995.28125" formatsTo:@"995 36/128"];
    [self assertDisplayType:displayType decimalString:@"995.2890625" formatsTo:@"995 37/128"];
    [self assertDisplayType:displayType decimalString:@"995.296875" formatsTo:@"995 38/128"];
    [self assertDisplayType:displayType decimalString:@"995.3046875" formatsTo:@"995 39/128"];
    [self assertDisplayType:displayType decimalString:@"567.3125" formatsTo:@"567 40/128"];
    [self assertDisplayType:displayType decimalString:@"995.3203125" formatsTo:@"995 41/128"];
    [self assertDisplayType:displayType decimalString:@"995.328125" formatsTo:@"995 42/128"];
    [self assertDisplayType:displayType decimalString:@"995.3359375" formatsTo:@"995 43/128"];
    [self assertDisplayType:displayType decimalString:@"995.34375" formatsTo:@"995 44/128"];
    [self assertDisplayType:displayType decimalString:@"995.3515625" formatsTo:@"995 45/128"];
    [self assertDisplayType:displayType decimalString:@"995.359375" formatsTo:@"995 46/128"];
    [self assertDisplayType:displayType decimalString:@"995.3671875" formatsTo:@"995 47/128"];
    [self assertDisplayType:displayType decimalString:@"995.375" formatsTo:@"995 48/128"];
    [self assertDisplayType:displayType decimalString:@"995.3828125" formatsTo:@"995 49/128"];
    [self assertDisplayType:displayType decimalString:@"995.390625" formatsTo:@"995 50/128"];
    [self assertDisplayType:displayType decimalString:@"995.3984375" formatsTo:@"995 51/128"];
    [self assertDisplayType:displayType decimalString:@"995.40625" formatsTo:@"995 52/128"];
    [self assertDisplayType:displayType decimalString:@"995.4140625" formatsTo:@"995 53/128"];
    [self assertDisplayType:displayType decimalString:@"995.421875" formatsTo:@"995 54/128"];
    [self assertDisplayType:displayType decimalString:@"995.4296875" formatsTo:@"995 55/128"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995 56/128"];
    [self assertDisplayType:displayType decimalString:@"995.4453125" formatsTo:@"995 57/128"];
    [self assertDisplayType:displayType decimalString:@"995.453125" formatsTo:@"995 58/128"];
    [self assertDisplayType:displayType decimalString:@"995.4609375" formatsTo:@"995 59/128"];
    [self assertDisplayType:displayType decimalString:@"995.46875" formatsTo:@"995 60/128"];
    [self assertDisplayType:displayType decimalString:@"995.4765625" formatsTo:@"995 61/128"];
    [self assertDisplayType:displayType decimalString:@"995.484375" formatsTo:@"995 62/128"];
    [self assertDisplayType:displayType decimalString:@"995.4921875" formatsTo:@"995 63/128"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474 64/128"];
    [self assertDisplayType:displayType decimalString:@"995.5078125" formatsTo:@"995 65/128"];
    [self assertDisplayType:displayType decimalString:@"995.515625" formatsTo:@"995 66/128"];
    [self assertDisplayType:displayType decimalString:@"995.5234375" formatsTo:@"995 67/128"];
    [self assertDisplayType:displayType decimalString:@"995.53125" formatsTo:@"995 68/128"];
    [self assertDisplayType:displayType decimalString:@"995.5390625" formatsTo:@"995 69/128"];
    [self assertDisplayType:displayType decimalString:@"995.546875" formatsTo:@"995 70/128"];
    [self assertDisplayType:displayType decimalString:@"995.5546875" formatsTo:@"995 71/128"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995 72/128"];
    [self assertDisplayType:displayType decimalString:@"995.5703125" formatsTo:@"995 73/128"];
    [self assertDisplayType:displayType decimalString:@"995.578125" formatsTo:@"995 74/128"];
    [self assertDisplayType:displayType decimalString:@"995.5859375" formatsTo:@"995 75/128"];
    [self assertDisplayType:displayType decimalString:@"995.59375" formatsTo:@"995 76/128"];
    [self assertDisplayType:displayType decimalString:@"995.6015625" formatsTo:@"995 77/128"];
    [self assertDisplayType:displayType decimalString:@"995.609375" formatsTo:@"995 78/128"];
    [self assertDisplayType:displayType decimalString:@"995.6171875" formatsTo:@"995 79/128"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272 80/128"];
    [self assertDisplayType:displayType decimalString:@"995.6328125" formatsTo:@"995 81/128"];
    [self assertDisplayType:displayType decimalString:@"995.640625" formatsTo:@"995 82/128"];
    [self assertDisplayType:displayType decimalString:@"995.6484375" formatsTo:@"995 83/128"];
    [self assertDisplayType:displayType decimalString:@"995.65625" formatsTo:@"995 84/128"];
    [self assertDisplayType:displayType decimalString:@"995.6640625" formatsTo:@"995 85/128"];
    [self assertDisplayType:displayType decimalString:@"995.671875" formatsTo:@"995 86/128"];
    [self assertDisplayType:displayType decimalString:@"995.6796875" formatsTo:@"995 87/128"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995 88/128"];
    [self assertDisplayType:displayType decimalString:@"995.6953125" formatsTo:@"995 89/128"];
    [self assertDisplayType:displayType decimalString:@"995.703125" formatsTo:@"995 90/128"];
    [self assertDisplayType:displayType decimalString:@"995.7109375" formatsTo:@"995 91/128"];
    [self assertDisplayType:displayType decimalString:@"995.71875" formatsTo:@"995 92/128"];
    [self assertDisplayType:displayType decimalString:@"995.7265625" formatsTo:@"995 93/128"];
    [self assertDisplayType:displayType decimalString:@"995.734375" formatsTo:@"995 94/128"];
    [self assertDisplayType:displayType decimalString:@"995.7421875" formatsTo:@"995 95/128"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101 96/128"];
    [self assertDisplayType:displayType decimalString:@"995.7578125" formatsTo:@"995 97/128"];
    [self assertDisplayType:displayType decimalString:@"995.765625" formatsTo:@"995 98/128"];
    [self assertDisplayType:displayType decimalString:@"995.7734375" formatsTo:@"995 99/128"];
    [self assertDisplayType:displayType decimalString:@"995.78125" formatsTo:@"995 100/128"];
    [self assertDisplayType:displayType decimalString:@"995.7890625" formatsTo:@"995 101/128"];
    [self assertDisplayType:displayType decimalString:@"995.796875" formatsTo:@"995 102/128"];
    [self assertDisplayType:displayType decimalString:@"995.8046875" formatsTo:@"995 103/128"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995 104/128"];
    [self assertDisplayType:displayType decimalString:@"995.8203125" formatsTo:@"995 105/128"];
    [self assertDisplayType:displayType decimalString:@"995.828125" formatsTo:@"995 106/128"];
    [self assertDisplayType:displayType decimalString:@"995.8359375" formatsTo:@"995 107/128"];
    [self assertDisplayType:displayType decimalString:@"995.84375" formatsTo:@"995 108/128"];
    [self assertDisplayType:displayType decimalString:@"995.8515625" formatsTo:@"995 109/128"];
    [self assertDisplayType:displayType decimalString:@"995.859375" formatsTo:@"995 110/128"];
    [self assertDisplayType:displayType decimalString:@"995.8671875" formatsTo:@"995 111/128"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263 112/128"];
    [self assertDisplayType:displayType decimalString:@"995.8828125" formatsTo:@"995 113/128"];
    [self assertDisplayType:displayType decimalString:@"995.890625" formatsTo:@"995 114/128"];
    [self assertDisplayType:displayType decimalString:@"995.8984375" formatsTo:@"995 115/128"];
    [self assertDisplayType:displayType decimalString:@"995.90625" formatsTo:@"995 116/128"];
    [self assertDisplayType:displayType decimalString:@"995.9140625" formatsTo:@"995 117/128"];
    [self assertDisplayType:displayType decimalString:@"995.921875" formatsTo:@"995 118/128"];
    [self assertDisplayType:displayType decimalString:@"995.9296875" formatsTo:@"995 119/128"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995 120/128"];
    [self assertDisplayType:displayType decimalString:@"995.9453125" formatsTo:@"995 121/128"];
    [self assertDisplayType:displayType decimalString:@"995.953125" formatsTo:@"995 122/128"];
    [self assertDisplayType:displayType decimalString:@"995.9609375" formatsTo:@"995 123/128"];
    [self assertDisplayType:displayType decimalString:@"995.96875" formatsTo:@"995 124/128"];
    [self assertDisplayType:displayType decimalString:@"995.9765625" formatsTo:@"995 125/128"];
    [self assertDisplayType:displayType decimalString:@"995.984375" formatsTo:@"995 126/128"];
    [self assertDisplayType:displayType decimalString:@"995.9921875" formatsTo:@"995 127/128"];
    [self assertDisplayType:displayType decimalString:@"0.9921875" formatsTo:@"127/128"];
    [self assertDisplayType:displayType decimalString:@"-0.9921875" formatsTo:@"-127/128"];
}
 
-(void)testTwoFiftySixthsToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 256;
    displayType.secondaryDivisor = 1;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101"];
    [self assertDisplayType:displayType decimalString:@"995.00390625" formatsTo:@"995 1/256"];
    [self assertDisplayType:displayType decimalString:@"995.0078125" formatsTo:@"995 2/256"];
    [self assertDisplayType:displayType decimalString:@"995.01171875" formatsTo:@"995 3/256"];
    [self assertDisplayType:displayType decimalString:@"995.015625" formatsTo:@"995 4/256"];
    [self assertDisplayType:displayType decimalString:@"995.01953125" formatsTo:@"995 5/256"];
    [self assertDisplayType:displayType decimalString:@"995.0234375" formatsTo:@"995 6/256"];
    [self assertDisplayType:displayType decimalString:@"995.02734375" formatsTo:@"995 7/256"];
    [self assertDisplayType:displayType decimalString:@"995.03125" formatsTo:@"995 8/256"];
    [self assertDisplayType:displayType decimalString:@"995.03515625" formatsTo:@"995 9/256"];
    [self assertDisplayType:displayType decimalString:@"995.0390625" formatsTo:@"995 10/256"];
    [self assertDisplayType:displayType decimalString:@"995.04296875" formatsTo:@"995 11/256"];
    [self assertDisplayType:displayType decimalString:@"995.046875" formatsTo:@"995 12/256"];
    [self assertDisplayType:displayType decimalString:@"995.05078125" formatsTo:@"995 13/256"];
    [self assertDisplayType:displayType decimalString:@"995.0546875" formatsTo:@"995 14/256"];
    [self assertDisplayType:displayType decimalString:@"995.05859375" formatsTo:@"995 15/256"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995 16/256"];
    [self assertDisplayType:displayType decimalString:@"995.06640625" formatsTo:@"995 17/256"];
    [self assertDisplayType:displayType decimalString:@"995.0703125" formatsTo:@"995 18/256"];
    [self assertDisplayType:displayType decimalString:@"995.07421875" formatsTo:@"995 19/256"];
    [self assertDisplayType:displayType decimalString:@"995.078125" formatsTo:@"995 20/256"];
    [self assertDisplayType:displayType decimalString:@"995.08203125" formatsTo:@"995 21/256"];
    [self assertDisplayType:displayType decimalString:@"995.0859375" formatsTo:@"995 22/256"];
    [self assertDisplayType:displayType decimalString:@"995.08984375" formatsTo:@"995 23/256"];
    [self assertDisplayType:displayType decimalString:@"995.09375" formatsTo:@"995 24/256"];
    [self assertDisplayType:displayType decimalString:@"995.09765625" formatsTo:@"995 25/256"];
    [self assertDisplayType:displayType decimalString:@"995.1015625" formatsTo:@"995 26/256"];
    [self assertDisplayType:displayType decimalString:@"995.10546875" formatsTo:@"995 27/256"];
    [self assertDisplayType:displayType decimalString:@"995.109375" formatsTo:@"995 28/256"];
    [self assertDisplayType:displayType decimalString:@"995.11328125" formatsTo:@"995 29/256"];
    [self assertDisplayType:displayType decimalString:@"995.1171875" formatsTo:@"995 30/256"];
    [self assertDisplayType:displayType decimalString:@"995.12109375" formatsTo:@"995 31/256"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995 32/256"];
    [self assertDisplayType:displayType decimalString:@"995.12890625" formatsTo:@"995 33/256"];
    [self assertDisplayType:displayType decimalString:@"995.1328125" formatsTo:@"995 34/256"];
    [self assertDisplayType:displayType decimalString:@"995.13671875" formatsTo:@"995 35/256"];
    [self assertDisplayType:displayType decimalString:@"995.140625" formatsTo:@"995 36/256"];
    [self assertDisplayType:displayType decimalString:@"995.14453125" formatsTo:@"995 37/256"];
    [self assertDisplayType:displayType decimalString:@"995.1484375" formatsTo:@"995 38/256"];
    [self assertDisplayType:displayType decimalString:@"995.15234375" formatsTo:@"995 39/256"];
    [self assertDisplayType:displayType decimalString:@"995.15625" formatsTo:@"995 40/256"];
    [self assertDisplayType:displayType decimalString:@"995.16015625" formatsTo:@"995 41/256"];
    [self assertDisplayType:displayType decimalString:@"995.1640625" formatsTo:@"995 42/256"];
    [self assertDisplayType:displayType decimalString:@"995.16796875" formatsTo:@"995 43/256"];
    [self assertDisplayType:displayType decimalString:@"995.171875" formatsTo:@"995 44/256"];
    [self assertDisplayType:displayType decimalString:@"995.17578125" formatsTo:@"995 45/256"];
    [self assertDisplayType:displayType decimalString:@"995.1796875" formatsTo:@"995 46/256"];
    [self assertDisplayType:displayType decimalString:@"334.18359375" formatsTo:@"334 47/256"];
    [self assertDisplayType:displayType decimalString:@"334.1875" formatsTo:@"334 48/256"];
    [self assertDisplayType:displayType decimalString:@"995.19140625" formatsTo:@"995 49/256"];
    [self assertDisplayType:displayType decimalString:@"995.1953125" formatsTo:@"995 50/256"];
    [self assertDisplayType:displayType decimalString:@"995.19921875" formatsTo:@"995 51/256"];
    [self assertDisplayType:displayType decimalString:@"995.203125" formatsTo:@"995 52/256"];
    [self assertDisplayType:displayType decimalString:@"995.20703125" formatsTo:@"995 53/256"];
    [self assertDisplayType:displayType decimalString:@"995.2109375" formatsTo:@"995 54/256"];
    [self assertDisplayType:displayType decimalString:@"995.21484375" formatsTo:@"995 55/256"];
    [self assertDisplayType:displayType decimalString:@"995.21875" formatsTo:@"995 56/256"];
    [self assertDisplayType:displayType decimalString:@"995.22265625" formatsTo:@"995 57/256"];
    [self assertDisplayType:displayType decimalString:@"995.2265625" formatsTo:@"995 58/256"];
    [self assertDisplayType:displayType decimalString:@"995.23046875" formatsTo:@"995 59/256"];
    [self assertDisplayType:displayType decimalString:@"995.234375" formatsTo:@"995 60/256"];
    [self assertDisplayType:displayType decimalString:@"995.23828125" formatsTo:@"995 61/256"];
    [self assertDisplayType:displayType decimalString:@"995.2421875" formatsTo:@"995 62/256"];
    [self assertDisplayType:displayType decimalString:@"995.24609375" formatsTo:@"995 63/256"];
    [self assertDisplayType:displayType decimalString:@"995.25" formatsTo:@"995 64/256"];
    [self assertDisplayType:displayType decimalString:@"995.25390625" formatsTo:@"995 65/256"];
    [self assertDisplayType:displayType decimalString:@"995.2578125" formatsTo:@"995 66/256"];
    [self assertDisplayType:displayType decimalString:@"995.26171875" formatsTo:@"995 67/256"];
    [self assertDisplayType:displayType decimalString:@"995.265625" formatsTo:@"995 68/256"];
    [self assertDisplayType:displayType decimalString:@"995.26953125" formatsTo:@"995 69/256"];
    [self assertDisplayType:displayType decimalString:@"995.2734375" formatsTo:@"995 70/256"];
    [self assertDisplayType:displayType decimalString:@"995.27734375" formatsTo:@"995 71/256"];
    [self assertDisplayType:displayType decimalString:@"995.28125" formatsTo:@"995 72/256"];
    [self assertDisplayType:displayType decimalString:@"995.28515625" formatsTo:@"995 73/256"];
    [self assertDisplayType:displayType decimalString:@"995.2890625" formatsTo:@"995 74/256"];
    [self assertDisplayType:displayType decimalString:@"995.29296875" formatsTo:@"995 75/256"];
    [self assertDisplayType:displayType decimalString:@"995.296875" formatsTo:@"995 76/256"];
    [self assertDisplayType:displayType decimalString:@"995.30078125" formatsTo:@"995 77/256"];
    [self assertDisplayType:displayType decimalString:@"995.3046875" formatsTo:@"995 78/256"];
    [self assertDisplayType:displayType decimalString:@"567.30859375" formatsTo:@"567 79/256"];
    [self assertDisplayType:displayType decimalString:@"567.3125" formatsTo:@"567 80/256"];
    [self assertDisplayType:displayType decimalString:@"995.31640625" formatsTo:@"995 81/256"];
    [self assertDisplayType:displayType decimalString:@"995.3203125" formatsTo:@"995 82/256"];
    [self assertDisplayType:displayType decimalString:@"995.32421875" formatsTo:@"995 83/256"];
    [self assertDisplayType:displayType decimalString:@"995.328125" formatsTo:@"995 84/256"];
    [self assertDisplayType:displayType decimalString:@"995.33203125" formatsTo:@"995 85/256"];
    [self assertDisplayType:displayType decimalString:@"995.3359375" formatsTo:@"995 86/256"];
    [self assertDisplayType:displayType decimalString:@"995.33984375" formatsTo:@"995 87/256"];
    [self assertDisplayType:displayType decimalString:@"995.34375" formatsTo:@"995 88/256"];
    [self assertDisplayType:displayType decimalString:@"995.34765625" formatsTo:@"995 89/256"];
    [self assertDisplayType:displayType decimalString:@"995.3515625" formatsTo:@"995 90/256"];
    [self assertDisplayType:displayType decimalString:@"995.35546875" formatsTo:@"995 91/256"];
    [self assertDisplayType:displayType decimalString:@"995.359375" formatsTo:@"995 92/256"];
    [self assertDisplayType:displayType decimalString:@"995.36328125" formatsTo:@"995 93/256"];
    [self assertDisplayType:displayType decimalString:@"995.3671875" formatsTo:@"995 94/256"];
    [self assertDisplayType:displayType decimalString:@"995.37109375" formatsTo:@"995 95/256"];
    [self assertDisplayType:displayType decimalString:@"995.375" formatsTo:@"995 96/256"];
    [self assertDisplayType:displayType decimalString:@"995.37890625" formatsTo:@"995 97/256"];
    [self assertDisplayType:displayType decimalString:@"995.3828125" formatsTo:@"995 98/256"];
    [self assertDisplayType:displayType decimalString:@"995.38671875" formatsTo:@"995 99/256"];
    [self assertDisplayType:displayType decimalString:@"995.390625" formatsTo:@"995 100/256"];
    [self assertDisplayType:displayType decimalString:@"995.39453125" formatsTo:@"995 101/256"];
    [self assertDisplayType:displayType decimalString:@"995.3984375" formatsTo:@"995 102/256"];
    [self assertDisplayType:displayType decimalString:@"995.40234375" formatsTo:@"995 103/256"];
    [self assertDisplayType:displayType decimalString:@"995.40625" formatsTo:@"995 104/256"];
    [self assertDisplayType:displayType decimalString:@"995.41015625" formatsTo:@"995 105/256"];
    [self assertDisplayType:displayType decimalString:@"995.4140625" formatsTo:@"995 106/256"];
    [self assertDisplayType:displayType decimalString:@"995.41796875" formatsTo:@"995 107/256"];
    [self assertDisplayType:displayType decimalString:@"995.421875" formatsTo:@"995 108/256"];
    [self assertDisplayType:displayType decimalString:@"995.42578125" formatsTo:@"995 109/256"];
    [self assertDisplayType:displayType decimalString:@"995.4296875" formatsTo:@"995 110/256"];
    [self assertDisplayType:displayType decimalString:@"995.43359375" formatsTo:@"995 111/256"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995 112/256"];
    [self assertDisplayType:displayType decimalString:@"995.44140625" formatsTo:@"995 113/256"];
    [self assertDisplayType:displayType decimalString:@"995.4453125" formatsTo:@"995 114/256"];
    [self assertDisplayType:displayType decimalString:@"995.44921875" formatsTo:@"995 115/256"];
    [self assertDisplayType:displayType decimalString:@"995.453125" formatsTo:@"995 116/256"];
    [self assertDisplayType:displayType decimalString:@"995.45703125" formatsTo:@"995 117/256"];
    [self assertDisplayType:displayType decimalString:@"995.4609375" formatsTo:@"995 118/256"];
    [self assertDisplayType:displayType decimalString:@"995.46484375" formatsTo:@"995 119/256"];
    [self assertDisplayType:displayType decimalString:@"995.46875" formatsTo:@"995 120/256"];
    [self assertDisplayType:displayType decimalString:@"995.47265625" formatsTo:@"995 121/256"];
    [self assertDisplayType:displayType decimalString:@"995.4765625" formatsTo:@"995 122/256"];
    [self assertDisplayType:displayType decimalString:@"995.48046875" formatsTo:@"995 123/256"];
    [self assertDisplayType:displayType decimalString:@"995.484375" formatsTo:@"995 124/256"];
    [self assertDisplayType:displayType decimalString:@"995.48828125" formatsTo:@"995 125/256"];
    [self assertDisplayType:displayType decimalString:@"995.4921875" formatsTo:@"995 126/256"];
    [self assertDisplayType:displayType decimalString:@"474.49609375" formatsTo:@"474 127/256"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474 128/256"];
    [self assertDisplayType:displayType decimalString:@"995.50390625" formatsTo:@"995 129/256"];
    [self assertDisplayType:displayType decimalString:@"995.5078125" formatsTo:@"995 130/256"];
    [self assertDisplayType:displayType decimalString:@"995.51171875" formatsTo:@"995 131/256"];
    [self assertDisplayType:displayType decimalString:@"995.515625" formatsTo:@"995 132/256"];
    [self assertDisplayType:displayType decimalString:@"995.51953125" formatsTo:@"995 133/256"];
    [self assertDisplayType:displayType decimalString:@"995.5234375" formatsTo:@"995 134/256"];
    [self assertDisplayType:displayType decimalString:@"995.52734375" formatsTo:@"995 135/256"];
    [self assertDisplayType:displayType decimalString:@"995.53125" formatsTo:@"995 136/256"];
    [self assertDisplayType:displayType decimalString:@"995.53515625" formatsTo:@"995 137/256"];
    [self assertDisplayType:displayType decimalString:@"995.5390625" formatsTo:@"995 138/256"];
    [self assertDisplayType:displayType decimalString:@"995.54296875" formatsTo:@"995 139/256"];
    [self assertDisplayType:displayType decimalString:@"995.546875" formatsTo:@"995 140/256"];
    [self assertDisplayType:displayType decimalString:@"995.55078125" formatsTo:@"995 141/256"];
    [self assertDisplayType:displayType decimalString:@"995.5546875" formatsTo:@"995 142/256"];
    [self assertDisplayType:displayType decimalString:@"995.55859375" formatsTo:@"995 143/256"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995 144/256"];
    [self assertDisplayType:displayType decimalString:@"995.56640625" formatsTo:@"995 145/256"];
    [self assertDisplayType:displayType decimalString:@"995.5703125" formatsTo:@"995 146/256"];
    [self assertDisplayType:displayType decimalString:@"995.57421875" formatsTo:@"995 147/256"];
    [self assertDisplayType:displayType decimalString:@"995.578125" formatsTo:@"995 148/256"];
    [self assertDisplayType:displayType decimalString:@"995.58203125" formatsTo:@"995 149/256"];
    [self assertDisplayType:displayType decimalString:@"995.5859375" formatsTo:@"995 150/256"];
    [self assertDisplayType:displayType decimalString:@"995.58984375" formatsTo:@"995 151/256"];
    [self assertDisplayType:displayType decimalString:@"995.59375" formatsTo:@"995 152/256"];
    [self assertDisplayType:displayType decimalString:@"995.59765625" formatsTo:@"995 153/256"];
    [self assertDisplayType:displayType decimalString:@"995.6015625" formatsTo:@"995 154/256"];
    [self assertDisplayType:displayType decimalString:@"995.60546875" formatsTo:@"995 155/256"];
    [self assertDisplayType:displayType decimalString:@"995.609375" formatsTo:@"995 156/256"];
    [self assertDisplayType:displayType decimalString:@"995.61328125" formatsTo:@"995 157/256"];
    [self assertDisplayType:displayType decimalString:@"995.6171875" formatsTo:@"995 158/256"];
    [self assertDisplayType:displayType decimalString:@"272.62109375" formatsTo:@"272 159/256"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272 160/256"];
    [self assertDisplayType:displayType decimalString:@"995.62890625" formatsTo:@"995 161/256"];
    [self assertDisplayType:displayType decimalString:@"995.6328125" formatsTo:@"995 162/256"];
    [self assertDisplayType:displayType decimalString:@"995.63671875" formatsTo:@"995 163/256"];
    [self assertDisplayType:displayType decimalString:@"995.640625" formatsTo:@"995 164/256"];
    [self assertDisplayType:displayType decimalString:@"995.64453125" formatsTo:@"995 165/256"];
    [self assertDisplayType:displayType decimalString:@"995.6484375" formatsTo:@"995 166/256"];
    [self assertDisplayType:displayType decimalString:@"995.65234375" formatsTo:@"995 167/256"];
    [self assertDisplayType:displayType decimalString:@"995.65625" formatsTo:@"995 168/256"];
    [self assertDisplayType:displayType decimalString:@"995.66015625" formatsTo:@"995 169/256"];
    [self assertDisplayType:displayType decimalString:@"995.6640625" formatsTo:@"995 170/256"];
    [self assertDisplayType:displayType decimalString:@"995.66796875" formatsTo:@"995 171/256"];
    [self assertDisplayType:displayType decimalString:@"995.671875" formatsTo:@"995 172/256"];
    [self assertDisplayType:displayType decimalString:@"995.67578125" formatsTo:@"995 173/256"];
    [self assertDisplayType:displayType decimalString:@"995.6796875" formatsTo:@"995 174/256"];
    [self assertDisplayType:displayType decimalString:@"995.68359375" formatsTo:@"995 175/256"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995 176/256"];
    [self assertDisplayType:displayType decimalString:@"995.69140625" formatsTo:@"995 177/256"];
    [self assertDisplayType:displayType decimalString:@"995.6953125" formatsTo:@"995 178/256"];
    [self assertDisplayType:displayType decimalString:@"995.69921875" formatsTo:@"995 179/256"];
    [self assertDisplayType:displayType decimalString:@"995.703125" formatsTo:@"995 180/256"];
    [self assertDisplayType:displayType decimalString:@"995.70703125" formatsTo:@"995 181/256"];
    [self assertDisplayType:displayType decimalString:@"995.7109375" formatsTo:@"995 182/256"];
    [self assertDisplayType:displayType decimalString:@"995.71484375" formatsTo:@"995 183/256"];
    [self assertDisplayType:displayType decimalString:@"995.71875" formatsTo:@"995 184/256"];
    [self assertDisplayType:displayType decimalString:@"995.72265625" formatsTo:@"995 185/256"];
    [self assertDisplayType:displayType decimalString:@"995.7265625" formatsTo:@"995 186/256"];
    [self assertDisplayType:displayType decimalString:@"995.73046875" formatsTo:@"995 187/256"];
    [self assertDisplayType:displayType decimalString:@"995.734375" formatsTo:@"995 188/256"];
    [self assertDisplayType:displayType decimalString:@"995.73828125" formatsTo:@"995 189/256"];
    [self assertDisplayType:displayType decimalString:@"995.7421875" formatsTo:@"995 190/256"];
    [self assertDisplayType:displayType decimalString:@"101.74609375" formatsTo:@"101 191/256"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101 192/256"];
    [self assertDisplayType:displayType decimalString:@"995.75390625" formatsTo:@"995 193/256"];
    [self assertDisplayType:displayType decimalString:@"995.7578125" formatsTo:@"995 194/256"];
    [self assertDisplayType:displayType decimalString:@"995.76171875" formatsTo:@"995 195/256"];
    [self assertDisplayType:displayType decimalString:@"995.765625" formatsTo:@"995 196/256"];
    [self assertDisplayType:displayType decimalString:@"995.76953125" formatsTo:@"995 197/256"];
    [self assertDisplayType:displayType decimalString:@"995.7734375" formatsTo:@"995 198/256"];
    [self assertDisplayType:displayType decimalString:@"995.77734375" formatsTo:@"995 199/256"];
    [self assertDisplayType:displayType decimalString:@"995.78125" formatsTo:@"995 200/256"];
    [self assertDisplayType:displayType decimalString:@"995.78515625" formatsTo:@"995 201/256"];
    [self assertDisplayType:displayType decimalString:@"995.7890625" formatsTo:@"995 202/256"];
    [self assertDisplayType:displayType decimalString:@"995.79296875" formatsTo:@"995 203/256"];
    [self assertDisplayType:displayType decimalString:@"995.796875" formatsTo:@"995 204/256"];
    [self assertDisplayType:displayType decimalString:@"995.80078125" formatsTo:@"995 205/256"];
    [self assertDisplayType:displayType decimalString:@"995.8046875" formatsTo:@"995 206/256"];
    [self assertDisplayType:displayType decimalString:@"995.80859375" formatsTo:@"995 207/256"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995 208/256"];
    [self assertDisplayType:displayType decimalString:@"995.81640625" formatsTo:@"995 209/256"];
    [self assertDisplayType:displayType decimalString:@"995.8203125" formatsTo:@"995 210/256"];
    [self assertDisplayType:displayType decimalString:@"995.82421875" formatsTo:@"995 211/256"];
    [self assertDisplayType:displayType decimalString:@"995.828125" formatsTo:@"995 212/256"];
    [self assertDisplayType:displayType decimalString:@"995.83203125" formatsTo:@"995 213/256"];
    [self assertDisplayType:displayType decimalString:@"995.8359375" formatsTo:@"995 214/256"];
    [self assertDisplayType:displayType decimalString:@"995.83984375" formatsTo:@"995 215/256"];
    [self assertDisplayType:displayType decimalString:@"995.84375" formatsTo:@"995 216/256"];
    [self assertDisplayType:displayType decimalString:@"995.84765625" formatsTo:@"995 217/256"];
    [self assertDisplayType:displayType decimalString:@"995.8515625" formatsTo:@"995 218/256"];
    [self assertDisplayType:displayType decimalString:@"995.85546875" formatsTo:@"995 219/256"];
    [self assertDisplayType:displayType decimalString:@"995.859375" formatsTo:@"995 220/256"];
    [self assertDisplayType:displayType decimalString:@"995.86328125" formatsTo:@"995 221/256"];
    [self assertDisplayType:displayType decimalString:@"995.8671875" formatsTo:@"995 222/256"];
    [self assertDisplayType:displayType decimalString:@"263.87109375" formatsTo:@"263 223/256"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263 224/256"];
    [self assertDisplayType:displayType decimalString:@"995.87890625" formatsTo:@"995 225/256"];
    [self assertDisplayType:displayType decimalString:@"995.8828125" formatsTo:@"995 226/256"];
    [self assertDisplayType:displayType decimalString:@"995.88671875" formatsTo:@"995 227/256"];
    [self assertDisplayType:displayType decimalString:@"995.890625" formatsTo:@"995 228/256"];
    [self assertDisplayType:displayType decimalString:@"995.89453125" formatsTo:@"995 229/256"];
    [self assertDisplayType:displayType decimalString:@"995.8984375" formatsTo:@"995 230/256"];
   [self assertDisplayType:displayType decimalString:@"995.90234375" formatsTo:@"995 231/256"];
    [self assertDisplayType:displayType decimalString:@"995.90625" formatsTo:@"995 232/256"];
    [self assertDisplayType:displayType decimalString:@"995.91015625" formatsTo:@"995 233/256"];
    [self assertDisplayType:displayType decimalString:@"995.9140625" formatsTo:@"995 234/256"];
    [self assertDisplayType:displayType decimalString:@"995.91796875" formatsTo:@"995 235/256"];
    [self assertDisplayType:displayType decimalString:@"995.921875" formatsTo:@"995 236/256"];
    [self assertDisplayType:displayType decimalString:@"995.92578125" formatsTo:@"995 237/256"];
    [self assertDisplayType:displayType decimalString:@"995.9296875" formatsTo:@"995 238/256"];
    [self assertDisplayType:displayType decimalString:@"995.93359375" formatsTo:@"995 239/256"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995 240/256"];
    [self assertDisplayType:displayType decimalString:@"995.94140625" formatsTo:@"995 241/256"];
    [self assertDisplayType:displayType decimalString:@"995.9453125" formatsTo:@"995 242/256"];
    [self assertDisplayType:displayType decimalString:@"995.94921875" formatsTo:@"995 243/256"];
    [self assertDisplayType:displayType decimalString:@"995.953125" formatsTo:@"995 244/256"];
    [self assertDisplayType:displayType decimalString:@"995.95703125" formatsTo:@"995 245/256"];
    [self assertDisplayType:displayType decimalString:@"995.9609375" formatsTo:@"995 246/256"];
    [self assertDisplayType:displayType decimalString:@"995.96484375" formatsTo:@"995 247/256"];
    [self assertDisplayType:displayType decimalString:@"995.96875" formatsTo:@"995 248/256"];
    [self assertDisplayType:displayType decimalString:@"995.97265625" formatsTo:@"995 249/256"];
    [self assertDisplayType:displayType decimalString:@"995.9765625" formatsTo:@"995 250/256"];
    [self assertDisplayType:displayType decimalString:@"995.98046875" formatsTo:@"995 251/256"];
    [self assertDisplayType:displayType decimalString:@"995.984375" formatsTo:@"995 252/256"];
    [self assertDisplayType:displayType decimalString:@"995.98828125" formatsTo:@"995 253/256"];
    [self assertDisplayType:displayType decimalString:@"995.9921875" formatsTo:@"995 254/256"];
    [self assertDisplayType:displayType decimalString:@"995.99609375" formatsTo:@"995 255/256"];
    [self assertDisplayType:displayType decimalString:@"0.99609375" formatsTo:@"255/256"];
    [self assertDisplayType:displayType decimalString:@"-0.99609375" formatsTo:@"-255/256"];
}
 
#pragma mark - Multi Fractional String From Number
 
 
- (void)testThirtySecondsHalvesToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 2;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0'00.0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101'00.0"];
    [self assertDisplayType:displayType decimalString:@"995.015625" formatsTo:@"995'00.5"];
    [self assertDisplayType:displayType decimalString:@"995.03125" formatsTo:@"995'01.0"];
    [self assertDisplayType:displayType decimalString:@"995.046875" formatsTo:@"995'01.5"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995'02.0"];
    [self assertDisplayType:displayType decimalString:@"995.078125" formatsTo:@"995'02.5"];
    [self assertDisplayType:displayType decimalString:@"995.09375" formatsTo:@"995'03.0"];
    [self assertDisplayType:displayType decimalString:@"995.109375" formatsTo:@"995'03.5"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995'04.0"];
    [self assertDisplayType:displayType decimalString:@"995.140625" formatsTo:@"995'04.5"];
    [self assertDisplayType:displayType decimalString:@"995.15625" formatsTo:@"995'05.0"];
    [self assertDisplayType:displayType decimalString:@"995.171875" formatsTo:@"995'05.5"];
    [self assertDisplayType:displayType decimalString:@"334.1875" formatsTo:@"334'06.0"];
    [self assertDisplayType:displayType decimalString:@"995.203125" formatsTo:@"995'06.5"];
    [self assertDisplayType:displayType decimalString:@"995.21875" formatsTo:@"995'07.0"];
    [self assertDisplayType:displayType decimalString:@"995.234375" formatsTo:@"995'07.5"];
    [self assertDisplayType:displayType decimalString:@"995.25" formatsTo:@"995'08.0"];
    [self assertDisplayType:displayType decimalString:@"995.265625" formatsTo:@"995'08.5"];
    [self assertDisplayType:displayType decimalString:@"995.28125" formatsTo:@"995'09.0"];
    [self assertDisplayType:displayType decimalString:@"995.296875" formatsTo:@"995'09.5"];
    [self assertDisplayType:displayType decimalString:@"567.3125" formatsTo:@"567'10.0"];
    [self assertDisplayType:displayType decimalString:@"995.328125" formatsTo:@"995'10.5"];
    [self assertDisplayType:displayType decimalString:@"995.34375" formatsTo:@"995'11.0"];
    [self assertDisplayType:displayType decimalString:@"995.359375" formatsTo:@"995'11.5"];
    [self assertDisplayType:displayType decimalString:@"995.375" formatsTo:@"995'12.0"];
    [self assertDisplayType:displayType decimalString:@"995.390625" formatsTo:@"995'12.5"];
    [self assertDisplayType:displayType decimalString:@"995.40625" formatsTo:@"995'13.0"];
    [self assertDisplayType:displayType decimalString:@"995.421875" formatsTo:@"995'13.5"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995'14.0"];
    [self assertDisplayType:displayType decimalString:@"995.453125" formatsTo:@"995'14.5"];
    [self assertDisplayType:displayType decimalString:@"995.46875" formatsTo:@"995'15.0"];
    [self assertDisplayType:displayType decimalString:@"995.484375" formatsTo:@"995'15.5"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474'16.0"];
    [self assertDisplayType:displayType decimalString:@"995.515625" formatsTo:@"995'16.5"];
    [self assertDisplayType:displayType decimalString:@"995.53125" formatsTo:@"995'17.0"];
    [self assertDisplayType:displayType decimalString:@"995.546875" formatsTo:@"995'17.5"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995'18.0"];
    [self assertDisplayType:displayType decimalString:@"995.578125" formatsTo:@"995'18.5"];
    [self assertDisplayType:displayType decimalString:@"995.59375" formatsTo:@"995'19.0"];
    [self assertDisplayType:displayType decimalString:@"995.609375" formatsTo:@"995'19.5"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272'20.0"];
    [self assertDisplayType:displayType decimalString:@"995.640625" formatsTo:@"995'20.5"];
    [self assertDisplayType:displayType decimalString:@"995.65625" formatsTo:@"995'21.0"];
    [self assertDisplayType:displayType decimalString:@"995.671875" formatsTo:@"995'21.5"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995'22.0"];
    [self assertDisplayType:displayType decimalString:@"995.703125" formatsTo:@"995'22.5"];
    [self assertDisplayType:displayType decimalString:@"995.71875" formatsTo:@"995'23.0"];
    [self assertDisplayType:displayType decimalString:@"995.734375" formatsTo:@"995'23.5"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101'24.0"];
    [self assertDisplayType:displayType decimalString:@"995.765625" formatsTo:@"995'24.5"];
    [self assertDisplayType:displayType decimalString:@"995.78125" formatsTo:@"995'25.0"];
    [self assertDisplayType:displayType decimalString:@"995.796875" formatsTo:@"995'25.5"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995'26.0"];
    [self assertDisplayType:displayType decimalString:@"995.828125" formatsTo:@"995'26.5"];
    [self assertDisplayType:displayType decimalString:@"995.84375" formatsTo:@"995'27.0"];
    [self assertDisplayType:displayType decimalString:@"995.859375" formatsTo:@"995'27.5"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263'28.0"];
    [self assertDisplayType:displayType decimalString:@"995.890625" formatsTo:@"995'28.5"];
    [self assertDisplayType:displayType decimalString:@"995.90625" formatsTo:@"995'29.0"];
    [self assertDisplayType:displayType decimalString:@"995.921875" formatsTo:@"995'29.5"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995'30.0"];
    [self assertDisplayType:displayType decimalString:@"995.953125" formatsTo:@"995'30.5"];
    [self assertDisplayType:displayType decimalString:@"995.96875" formatsTo:@"995'31.0"];
    [self assertDisplayType:displayType decimalString:@"995.984375" formatsTo:@"995'31.5"];
    [self assertDisplayType:displayType decimalString:@"0.984375" formatsTo:@"0'31.5"];
    [self assertDisplayType:displayType decimalString:@"-0.984375" formatsTo:@"-0'31.5"];
   
}
 
-(void)test32ndQuartersToString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 4;
   
    [self assertDisplayType:displayType decimalString:@"0" formatsTo:@"0'00.0"];
    [self assertDisplayType:displayType decimalString:@"101.0" formatsTo:@"101'00.0"];
    [self assertDisplayType:displayType decimalString:@"995.0078125" formatsTo:@"995'00.2"];
    [self assertDisplayType:displayType decimalString:@"995.015625" formatsTo:@"995'00.5"];
    [self assertDisplayType:displayType decimalString:@"995.0234375" formatsTo:@"995'00.7"];
    [self assertDisplayType:displayType decimalString:@"995.03125" formatsTo:@"995'01.0"];
    [self assertDisplayType:displayType decimalString:@"995.0390625" formatsTo:@"995'01.2"];
    [self assertDisplayType:displayType decimalString:@"995.046875" formatsTo:@"995'01.5"];
    [self assertDisplayType:displayType decimalString:@"995.0546875" formatsTo:@"995'01.7"];
    [self assertDisplayType:displayType decimalString:@"995.0625" formatsTo:@"995'02.0"];
    [self assertDisplayType:displayType decimalString:@"995.0703125" formatsTo:@"995'02.2"];
    [self assertDisplayType:displayType decimalString:@"995.078125" formatsTo:@"995'02.5"];
    [self assertDisplayType:displayType decimalString:@"995.0859375" formatsTo:@"995'02.7"];
    [self assertDisplayType:displayType decimalString:@"995.09375" formatsTo:@"995'03.0"];
    [self assertDisplayType:displayType decimalString:@"995.1015625" formatsTo:@"995'03.2"];
    [self assertDisplayType:displayType decimalString:@"995.109375" formatsTo:@"995'03.5"];
    [self assertDisplayType:displayType decimalString:@"995.1171875" formatsTo:@"995'03.7"];
    [self assertDisplayType:displayType decimalString:@"995.125" formatsTo:@"995'04.0"];
    [self assertDisplayType:displayType decimalString:@"995.1328125" formatsTo:@"995'04.2"];
    [self assertDisplayType:displayType decimalString:@"995.140625" formatsTo:@"995'04.5"];
    [self assertDisplayType:displayType decimalString:@"995.1484375" formatsTo:@"995'04.7"];
    [self assertDisplayType:displayType decimalString:@"995.15625" formatsTo:@"995'05.0"];
    [self assertDisplayType:displayType decimalString:@"995.1640625" formatsTo:@"995'05.2"];
    [self assertDisplayType:displayType decimalString:@"995.171875" formatsTo:@"995'05.5"];
    [self assertDisplayType:displayType decimalString:@"995.1796875" formatsTo:@"995'05.7"];
    [self assertDisplayType:displayType decimalString:@"334.1875" formatsTo:@"334'06.0"];
    [self assertDisplayType:displayType decimalString:@"995.1953125" formatsTo:@"995'06.2"];
    [self assertDisplayType:displayType decimalString:@"995.203125" formatsTo:@"995'06.5"];
    [self assertDisplayType:displayType decimalString:@"995.2109375" formatsTo:@"995'06.7"];
    [self assertDisplayType:displayType decimalString:@"995.21875" formatsTo:@"995'07.0"];
    [self assertDisplayType:displayType decimalString:@"995.2265625" formatsTo:@"995'07.2"];
    [self assertDisplayType:displayType decimalString:@"995.234375" formatsTo:@"995'07.5"];
    [self assertDisplayType:displayType decimalString:@"995.2421875" formatsTo:@"995'07.7"];
    [self assertDisplayType:displayType decimalString:@"995.25" formatsTo:@"995'08.0"];
    [self assertDisplayType:displayType decimalString:@"995.2578125" formatsTo:@"995'08.2"];
    [self assertDisplayType:displayType decimalString:@"995.265625" formatsTo:@"995'08.5"];
    [self assertDisplayType:displayType decimalString:@"995.2734375" formatsTo:@"995'08.7"];
    [self assertDisplayType:displayType decimalString:@"995.28125" formatsTo:@"995'09.0"];
    [self assertDisplayType:displayType decimalString:@"995.2890625" formatsTo:@"995'09.2"];
    [self assertDisplayType:displayType decimalString:@"995.296875" formatsTo:@"995'09.5"];
    [self assertDisplayType:displayType decimalString:@"995.3046875" formatsTo:@"995'09.7"];
    [self assertDisplayType:displayType decimalString:@"567.3125" formatsTo:@"567'10.0"];
    [self assertDisplayType:displayType decimalString:@"995.3203125" formatsTo:@"995'10.2"];
    [self assertDisplayType:displayType decimalString:@"995.328125" formatsTo:@"995'10.5"];
    [self assertDisplayType:displayType decimalString:@"995.3359375" formatsTo:@"995'10.7"];
    [self assertDisplayType:displayType decimalString:@"995.34375" formatsTo:@"995'11.0"];
    [self assertDisplayType:displayType decimalString:@"995.3515625" formatsTo:@"995'11.2"];
    [self assertDisplayType:displayType decimalString:@"995.359375" formatsTo:@"995'11.5"];
    [self assertDisplayType:displayType decimalString:@"995.3671875" formatsTo:@"995'11.7"];
    [self assertDisplayType:displayType decimalString:@"995.375" formatsTo:@"995'12.0"];
    [self assertDisplayType:displayType decimalString:@"995.3828125" formatsTo:@"995'12.2"];
    [self assertDisplayType:displayType decimalString:@"995.390625" formatsTo:@"995'12.5"];
    [self assertDisplayType:displayType decimalString:@"995.3984375" formatsTo:@"995'12.7"];
    [self assertDisplayType:displayType decimalString:@"995.40625" formatsTo:@"995'13.0"];
    [self assertDisplayType:displayType decimalString:@"995.4140625" formatsTo:@"995'13.2"];
    [self assertDisplayType:displayType decimalString:@"995.421875" formatsTo:@"995'13.5"];
    [self assertDisplayType:displayType decimalString:@"995.4296875" formatsTo:@"995'13.7"];
    [self assertDisplayType:displayType decimalString:@"995.4375" formatsTo:@"995'14.0"];
    [self assertDisplayType:displayType decimalString:@"995.4453125" formatsTo:@"995'14.2"];
    [self assertDisplayType:displayType decimalString:@"995.453125" formatsTo:@"995'14.5"];
    [self assertDisplayType:displayType decimalString:@"995.4609375" formatsTo:@"995'14.7"];
    [self assertDisplayType:displayType decimalString:@"995.46875" formatsTo:@"995'15.0"];
    [self assertDisplayType:displayType decimalString:@"995.4765625" formatsTo:@"995'15.2"];
    [self assertDisplayType:displayType decimalString:@"995.484375" formatsTo:@"995'15.5"];
    [self assertDisplayType:displayType decimalString:@"995.4921875" formatsTo:@"995'15.7"];
    [self assertDisplayType:displayType decimalString:@"474.5" formatsTo:@"474'16.0"];
    [self assertDisplayType:displayType decimalString:@"995.5078125" formatsTo:@"995'16.2"];
    [self assertDisplayType:displayType decimalString:@"995.515625" formatsTo:@"995'16.5"];
    [self assertDisplayType:displayType decimalString:@"995.5234375" formatsTo:@"995'16.7"];
    [self assertDisplayType:displayType decimalString:@"995.53125" formatsTo:@"995'17.0"];
    [self assertDisplayType:displayType decimalString:@"995.5390625" formatsTo:@"995'17.2"];
    [self assertDisplayType:displayType decimalString:@"995.546875" formatsTo:@"995'17.5"];
    [self assertDisplayType:displayType decimalString:@"995.5546875" formatsTo:@"995'17.7"];
    [self assertDisplayType:displayType decimalString:@"995.5625" formatsTo:@"995'18.0"];
    [self assertDisplayType:displayType decimalString:@"995.5703125" formatsTo:@"995'18.2"];
    [self assertDisplayType:displayType decimalString:@"995.578125" formatsTo:@"995'18.5"];
    [self assertDisplayType:displayType decimalString:@"995.5859375" formatsTo:@"995'18.7"];
    [self assertDisplayType:displayType decimalString:@"995.59375" formatsTo:@"995'19.0"];
    [self assertDisplayType:displayType decimalString:@"995.6015625" formatsTo:@"995'19.2"];
    [self assertDisplayType:displayType decimalString:@"995.609375" formatsTo:@"995'19.5"];
    [self assertDisplayType:displayType decimalString:@"995.6171875" formatsTo:@"995'19.7"];
    [self assertDisplayType:displayType decimalString:@"272.625" formatsTo:@"272'20.0"];
    [self assertDisplayType:displayType decimalString:@"995.6328125" formatsTo:@"995'20.2"];
    [self assertDisplayType:displayType decimalString:@"995.640625" formatsTo:@"995'20.5"];
    [self assertDisplayType:displayType decimalString:@"995.6484375" formatsTo:@"995'20.7"];
    [self assertDisplayType:displayType decimalString:@"995.65625" formatsTo:@"995'21.0"];
    [self assertDisplayType:displayType decimalString:@"995.6640625" formatsTo:@"995'21.2"];
    [self assertDisplayType:displayType decimalString:@"995.671875" formatsTo:@"995'21.5"];
    [self assertDisplayType:displayType decimalString:@"995.6796875" formatsTo:@"995'21.7"];
    [self assertDisplayType:displayType decimalString:@"995.6875" formatsTo:@"995'22.0"];
    [self assertDisplayType:displayType decimalString:@"995.6953125" formatsTo:@"995'22.2"];
    [self assertDisplayType:displayType decimalString:@"995.703125" formatsTo:@"995'22.5"];
    [self assertDisplayType:displayType decimalString:@"995.7109375" formatsTo:@"995'22.7"];
    [self assertDisplayType:displayType decimalString:@"995.71875" formatsTo:@"995'23.0"];
    [self assertDisplayType:displayType decimalString:@"995.7265625" formatsTo:@"995'23.2"];
    [self assertDisplayType:displayType decimalString:@"995.734375" formatsTo:@"995'23.5"];
    [self assertDisplayType:displayType decimalString:@"995.7421875" formatsTo:@"995'23.7"];
    [self assertDisplayType:displayType decimalString:@"101.75" formatsTo:@"101'24.0"];
    [self assertDisplayType:displayType decimalString:@"995.7578125" formatsTo:@"995'24.2"];
    [self assertDisplayType:displayType decimalString:@"995.765625" formatsTo:@"995'24.5"];
    [self assertDisplayType:displayType decimalString:@"995.7734375" formatsTo:@"995'24.7"];
    [self assertDisplayType:displayType decimalString:@"995.78125" formatsTo:@"995'25.0"];
    [self assertDisplayType:displayType decimalString:@"995.7890625" formatsTo:@"995'25.2"];
    [self assertDisplayType:displayType decimalString:@"995.796875" formatsTo:@"995'25.5"];
    [self assertDisplayType:displayType decimalString:@"995.8046875" formatsTo:@"995'25.7"];
    [self assertDisplayType:displayType decimalString:@"995.8125" formatsTo:@"995'26.0"];
    [self assertDisplayType:displayType decimalString:@"995.8203125" formatsTo:@"995'26.2"];
    [self assertDisplayType:displayType decimalString:@"995.828125" formatsTo:@"995'26.5"];
    [self assertDisplayType:displayType decimalString:@"995.8359375" formatsTo:@"995'26.7"];
    [self assertDisplayType:displayType decimalString:@"995.84375" formatsTo:@"995'27.0"];
    [self assertDisplayType:displayType decimalString:@"995.8515625" formatsTo:@"995'27.2"];
    [self assertDisplayType:displayType decimalString:@"995.859375" formatsTo:@"995'27.5"];
    [self assertDisplayType:displayType decimalString:@"995.8671875" formatsTo:@"995'27.7"];
    [self assertDisplayType:displayType decimalString:@"263.875" formatsTo:@"263'28.0"];
    [self assertDisplayType:displayType decimalString:@"995.8828125" formatsTo:@"995'28.2"];
    [self assertDisplayType:displayType decimalString:@"995.890625" formatsTo:@"995'28.5"];
    [self assertDisplayType:displayType decimalString:@"995.8984375" formatsTo:@"995'28.7"];
    [self assertDisplayType:displayType decimalString:@"995.90625" formatsTo:@"995'29.0"];
    [self assertDisplayType:displayType decimalString:@"995.9140625" formatsTo:@"995'29.2"];
    [self assertDisplayType:displayType decimalString:@"995.921875" formatsTo:@"995'29.5"];
    [self assertDisplayType:displayType decimalString:@"995.9296875" formatsTo:@"995'29.7"];
    [self assertDisplayType:displayType decimalString:@"995.9375" formatsTo:@"995'30.0"];
    [self assertDisplayType:displayType decimalString:@"995.9453125" formatsTo:@"995'30.2"];
    [self assertDisplayType:displayType decimalString:@"995.953125" formatsTo:@"995'30.5"];
    [self assertDisplayType:displayType decimalString:@"995.9609375" formatsTo:@"995'30.7"];
    [self assertDisplayType:displayType decimalString:@"995.96875" formatsTo:@"995'31.0"];
    [self assertDisplayType:displayType decimalString:@"995.9765625" formatsTo:@"995'31.2"];
    [self assertDisplayType:displayType decimalString:@"995.984375" formatsTo:@"995'31.5"];
    [self assertDisplayType:displayType decimalString:@"995.9921875" formatsTo:@"995'31.7"];
    [self assertDisplayType:displayType decimalString:@"0.9921875" formatsTo:@"0'31.7"];
    [self assertDisplayType:displayType decimalString:@"-0.9921875" formatsTo:@"-0'31.7"];
}
 
#pragma mark - Decimal String To Number
 
- (void)testStringToZeroDigitDecimal
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 1;
 
    NSString *errorStr = @"Mismatch with zero digit decimal number conversion.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
 
    number = [displayType numberFromString:@"77.1"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
}
 
- (void)testStringToOneDigitDecimal
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 10;
 
    NSString *errorStr = @"Mismatch with one digit decimal number conversion.";
 
    NSDecimalNumber *number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
 
    number = [displayType numberFromString:@"77.1"];
    STAssertEqualObjects(number.stringValue, @"77.1", errorStr);
   
    number = [displayType numberFromString:@"77.111"];
    STAssertEqualObjects(number.stringValue, @"77.1", errorStr);
   
    number = [displayType numberFromString:@"77.17"];
    STAssertEqualObjects(number.stringValue, @"77.2", errorStr);
}
 
- (void)testStringToSixDigitDecimal
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 10;
    displayType.primaryDivisor = 1000000;
 
    NSString *errorStr = @"Mismatch with six digit decimal number conversion.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
   
    number = [displayType numberFromString:@"77.1"];
    STAssertEqualObjects(number.stringValue, @"77.1", errorStr);
   
    number = [displayType numberFromString:@"77.3333334"];
    STAssertEqualObjects(number.stringValue, @"77.333333", errorStr);
   
    number = [displayType numberFromString:@"77.3333338"];
    STAssertEqualObjects(number.stringValue, @"77.333334", errorStr);
}
 
#pragma mark - Single Fractional String To Number
 
- (void)testStringToHalves
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 2;
   
    NSString *errorStr = @"Mismatch converting to fractional halves.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77 1/2"];
    STAssertEqualObjects(number.stringValue, @"77.5", errorStr);
   
    number = [displayType numberFromString:@"77 1/4"];
    STAssertEqualObjects(number.stringValue, @"77.5", errorStr);
   
    number = [displayType numberFromString:@"77 3/4"];
    STAssertEqualObjects(number.stringValue, @"78", errorStr);
   
    number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
}
 
- (void)testStringToFourths
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 4;
   
    NSString *errorStr = @"Mismatch converting to fractional fourths.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77 1/4"];
    STAssertEqualObjects(number.stringValue, @"77.25", errorStr);
   
    number = [displayType numberFromString:@"77 1/16"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
   
    number = [displayType numberFromString:@"77 1/8"];
    STAssertEqualObjects(number.stringValue, @"77.25", errorStr);
   
    number = [displayType numberFromString:@"77 3/8"];
    STAssertEqualObjects(number.stringValue, @"77.5", errorStr);
   
    number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
}
 
- (void)testStringToEighths
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 8;
   
    NSString *errorStr = @"Mismatch converting to fractional eighths.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77 1/8"];
    STAssertEqualObjects(number.stringValue, @"77.125", errorStr);
   
    number = [displayType numberFromString:@"77 7/8"];
    STAssertEqualObjects(number.stringValue, @"77.875", errorStr);
   
    number = [displayType numberFromString:@"77 1/16"];
    STAssertEqualObjects(number.stringValue, @"77.125", errorStr);
   
    number = [displayType numberFromString:@"77 3/16"];
    STAssertEqualObjects(number.stringValue, @"77.25", errorStr);
   
    number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
}
 
- (void)testStringToThirtySeconds
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
   
    NSString *errorStr = @"Mismatch converting to fractional thirty-seconds.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77 1/32"];
    STAssertEqualObjects(number.stringValue, @"77.03125", errorStr);
   
    number = [displayType numberFromString:@"77 1/64"];
    STAssertEqualObjects(number.stringValue, @"77.03125", errorStr);
   
    number = [displayType numberFromString:@"77 31/32"];
    STAssertEqualObjects(number.stringValue, @"77.96875", errorStr);
   
    number = [displayType numberFromString:@"77 3/64"];
    STAssertEqualObjects(number.stringValue, @"77.0625", errorStr);
   
    number = [displayType numberFromString:@"77"];
    STAssertEqualObjects(number.stringValue, @"77", errorStr);
}
 
#pragma mark - Multi-fractional String To Number
 
- (void)testIncompleteMultiFractionString
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 4;
 
    NSString *errorStr = @"Mismatch converting to multi-fractional number from incomplete string.";
 
    NSDecimalNumber *number = [displayType numberFromString:@"77'4"];
    STAssertEqualObjects(number.stringValue, @"77.125", errorStr);
}
 
- (void)testStringToThirtySecondsAndHalves
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 2;
   
    NSString *errorStr = @"Mismatch converting to fractional thirty-seconds & halves.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77'01.5"];
    STAssertEqualObjects(number.stringValue, @"77.046875", errorStr);
   
    number = [displayType numberFromString:@"77'1.5"];
    STAssertEqualObjects(number.stringValue, @"77.046875", errorStr);
   
    number = [displayType numberFromString:@"77'1.0"];
    STAssertEqualObjects(number.stringValue, @"77.03125", errorStr);
}
 
- (void)testStringToThirtySecondsAndQuarters
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
   displayType.secondaryDivisor = 4;
   
    NSString *errorStr = @"Mismatch converting to fractional thirty-seconds & quarters.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77'16.2"];
    STAssertEqualObjects(number.stringValue, @"77.5078125", errorStr);
   
    number = [displayType numberFromString:@"77'16.5"];
    STAssertEqualObjects(number.stringValue, @"77.515625", errorStr);
   
    number = [displayType numberFromString:@"77'16.7"];
    STAssertEqualObjects(number.stringValue, @"77.5234375", errorStr);
   
    number = [displayType numberFromString:@"77'16.0"];
    STAssertEqualObjects(number.stringValue, @"77.5", errorStr);
   
    // round to nearest quarter
    number = [displayType numberFromString:@"77'16.8"];
    STAssertEqualObjects(number.stringValue, @"77.53125", errorStr);
}
 
- (void)testStringToThirtySecondsAndEighths
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 8;
   
    NSString *errorStr = @"Mismatch converting to fractional thirty-seconds & eighths.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77'8.1"];
    STAssertEqualObjects(number.stringValue, @"77.25390625", errorStr);
   
    number = [displayType numberFromString:@"77'08.1"];
    STAssertEqualObjects(number.stringValue, @"77.25390625", errorStr);
   
    number = [displayType numberFromString:@"77'8.2"];
    STAssertEqualObjects(number.stringValue, @"77.2578125", errorStr);
   
    number = [displayType numberFromString:@"77'8.3"];
    STAssertEqualObjects(number.stringValue, @"77.26171875", errorStr);
   
    number = [displayType numberFromString:@"77'8.5"];
    STAssertEqualObjects(number.stringValue, @"77.265625", errorStr);
   
    number = [displayType numberFromString:@"77'8.6"];
    STAssertEqualObjects(number.stringValue, @"77.26953125", errorStr);
   
    number = [displayType numberFromString:@"77'8.7"];
    STAssertEqualObjects(number.stringValue, @"77.2734375", errorStr);
   
    number = [displayType numberFromString:@"77'8.8"];
    STAssertEqualObjects(number.stringValue, @"77.27734375", errorStr);
   
    // round to nearest eighth
    number = [displayType numberFromString:@"77'8.9"];
    STAssertEqualObjects(number.stringValue, @"77.27734375", errorStr);
   
    number = [displayType numberFromString:@"77'8.0"];
    STAssertEqualObjects(number.stringValue, @"77.25", errorStr);
}
 
- (void)testStringToThirtySecondsAndTenths
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 32;
    displayType.secondaryDivisor = 10;
   
    NSString *errorStr = @"Mismatch converting to fractional thirty-seconds & tenths.";
   
    NSDecimalNumber *number = [displayType numberFromString:@"77'8.1"];
    STAssertEqualObjects(number.stringValue, @"77.253125", errorStr);
   
    number = [displayType numberFromString:@"77'08.1"];
    STAssertEqualObjects(number.stringValue, @"77.253125", errorStr);
   
    number = [displayType numberFromString:@"77'8.2"];
    STAssertEqualObjects(number.stringValue, @"77.25625", errorStr);
   
    number = [displayType numberFromString:@"77'8.3"];
    STAssertEqualObjects(number.stringValue, @"77.259375", errorStr);
   
    number = [displayType numberFromString:@"77'8.4"];
    STAssertEqualObjects(number.stringValue, @"77.2625", errorStr);
   
    number = [displayType numberFromString:@"77'8.5"];
    STAssertEqualObjects(number.stringValue, @"77.265625", errorStr);
   
    number = [displayType numberFromString:@"77'8.6"];
    STAssertEqualObjects(number.stringValue, @"77.26875", errorStr);
   
    number = [displayType numberFromString:@"77'8.7"];
    STAssertEqualObjects(number.stringValue, @"77.271875", errorStr);
   
    number = [displayType numberFromString:@"77'8.8"];
    STAssertEqualObjects(number.stringValue, @"77.275", errorStr);
   
    number = [displayType numberFromString:@"77'8.9"];
    STAssertEqualObjects(number.stringValue, @"77.278125", errorStr);
   
    number = [displayType numberFromString:@"77'8.0"];
    STAssertEqualObjects(number.stringValue, @"77.25", errorStr);
}
 
- (void)testMinMove
{
    PriceDisplayType *displayType = [[PriceDisplayType alloc] init];
    displayType.base = 2;
    displayType.primaryDivisor = 8;
    displayType.minMove = [NSDecimalNumber decimalNumberWithString:@"2"];
   
    // increment
    NSString *errorStr = @"Incorrect min move value.";
    NSDecimalNumber *number = [displayType numberFromString:@"77 2/8"];
    NSDecimal value = [displayType incrementValue:[number decimalValue]];
    NSString *strValue = [displayType stringFromNumber:[NSDecimalNumber decimalNumberWithDecimal:value] displayOnly:NO];
    STAssertEqualObjects(strValue, @"77 4/8", errorStr);
 
    // decrement
    value = [displayType decrementValue:[number decimalValue]];
    strValue = [displayType stringFromNumber:[NSDecimalNumber decimalNumberWithDecimal:value]];
    STAssertEqualObjects(strValue, @"77", errorStr);
}
 
@end

TradeStation Group, Inc. is the parent company of four operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), IBFX, Inc. (Member NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and delete the material from any computer. Forex products and services are offered by TradeStation Forex, a division of IBFX, Inc.