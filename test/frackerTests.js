/*global describe, it, require */
var assert = require('assert'),
    fracker = require('../fracker').fracker,
    displayTypeLookup = require('../lib/displayTypeLookup').displayTypeLookup;

describe('Get precision', function () {
    it('should calculate the price scale correctly', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 1000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.getPrecision(1.001, displayTypeLookup(4)), 3);
        assert.equal(fracker.getPrecision(1, displayTypeLookup(3)), 2);
    });
});

describe('Get price scale', function () {
    it('should calculate the price scale correctly', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 1000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.getPriceScale(priceConversionObj), 0.001);

        /*'1': 1,
         '2': 0.1,
         '3': 0.01,
         '4': 0.001,
         '5': 0.0001,
         '6': 0.00001,

         '8': 0.5,
         '9': 0.25,
         '10': 0.125,
         '11': 0.0625,
         '12': 0.03125,
         '13': 0.015625,
         '14': 0.0078125,
         '15': 0.003906250,
         '16': 0.025,
         '17': 0.015625,
         '18': 0.0078125,
         '19': 0.00390625,
         '20': 0.003125,
         '21': 0.0078125,
         '22': 0.0015625,
         '23': 0.000001 */
    });
});

describe('Convert to decimal string from string', function () {
    it('0 decimals', function () {
        assert.equal(fracker.toStringFromFloat(0), '0');
        assert.equal(fracker.toStringFromFloat(21.07), '21.07');
        assert.equal(fracker.toStringFromFloat(11.7), '11.7');
        assert.equal(fracker.toStringFromFloat(11.0), '11');
        assert.equal(fracker.toStringFromFloat(11.5), '11.5');
        assert.equal(fracker.toStringFromFloat(-11.5), '-11.5');
        assert.equal(fracker.toStringFromFloat(-11), '-11');
        assert.equal(fracker.toStringFromFloat(-0.5), '-0.5');
    });

    it('1 decimal', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 10,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(21.7, priceConversionObj), '21.7');
        assert.equal(fracker.toStringFromFloat(-21.7, priceConversionObj), '-21.7');
        assert.equal(fracker.toStringFromFloat(21.0, priceConversionObj), '21.0');
        assert.equal(fracker.toStringFromFloat(-21.0, priceConversionObj), '-21.0');
        assert.equal(fracker.toStringFromFloat(21.5, priceConversionObj), '21.5');
        assert.equal(fracker.toStringFromFloat(-21.5, priceConversionObj), '-21.5');
        assert.equal(fracker.toStringFromFloat(21.232, priceConversionObj), '21.232');
        assert.equal(fracker.toStringFromFloat(-21.232, priceConversionObj), '-21.232');
        assert.equal(fracker.toStringFromFloat(21.2333, priceConversionObj), '21.2333');
        assert.equal(fracker.toStringFromFloat(-21.2333, priceConversionObj), '-21.2333');
        assert.equal(fracker.toStringFromFloat(21.12245, priceConversionObj), '21.12245');
        assert.equal(fracker.toStringFromFloat(-21.12245, priceConversionObj), '-21.12245');
        assert.equal(fracker.toStringFromFloat(0.5, priceConversionObj), '0.5');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.5');
    });

    it('2 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 100,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.00');
        assert.equal(fracker.toStringFromFloat(31.07, priceConversionObj), '31.07');
        assert.equal(fracker.toStringFromFloat(31.7, priceConversionObj), '31.70');
        assert.equal(fracker.toStringFromFloat(31.0, priceConversionObj), '31.00');
        assert.equal(fracker.toStringFromFloat(31.5, priceConversionObj), '31.50');
        assert.equal(fracker.toStringFromFloat(31.25, priceConversionObj), '31.25');
        assert.equal(fracker.toStringFromFloat(-31.5, priceConversionObj), '-31.50');
        assert.equal(fracker.toStringFromFloat(-31, priceConversionObj), '-31.00');
        assert.equal(fracker.toStringFromFloat(-31.232, priceConversionObj), '-31.232');
    });

    it('3 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 1000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.000');
        assert.equal(fracker.toStringFromFloat(31.07, priceConversionObj), '31.070');
        assert.equal(fracker.toStringFromFloat(31.7, priceConversionObj), '31.700');
        assert.equal(fracker.toStringFromFloat(31.0, priceConversionObj), '31.000');
        assert.equal(fracker.toStringFromFloat(31.5, priceConversionObj), '31.500');
        assert.equal(fracker.toStringFromFloat(31.25, priceConversionObj), '31.250');
        assert.equal(fracker.toStringFromFloat(-31.500, priceConversionObj), '-31.500');
        assert.equal(fracker.toStringFromFloat(-31, priceConversionObj), '-31.000');
        assert.equal(fracker.toStringFromFloat(-31.232, priceConversionObj), '-31.232');
        assert.equal(fracker.toStringFromFloat(-31.2333, priceConversionObj), '-31.2333');
        assert.equal(fracker.toStringFromFloat(-31.12245, priceConversionObj), '-31.12245');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.500');
    });

    it('4 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 10000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.0000');
        assert.equal(fracker.toStringFromFloat(41.07, priceConversionObj), '41.0700');
        assert.equal(fracker.toStringFromFloat(41.007, priceConversionObj), '41.0070');
        assert.equal(fracker.toStringFromFloat(41.0007, priceConversionObj), '41.0007');
        assert.equal(fracker.toStringFromFloat(41.7, priceConversionObj), '41.7000');
        assert.equal(fracker.toStringFromFloat(41.0, priceConversionObj), '41.0000');
        assert.equal(fracker.toStringFromFloat(41, priceConversionObj), '41.0000');
        assert.equal(fracker.toStringFromFloat(41.5, priceConversionObj), '41.5000');
        assert.equal(fracker.toStringFromFloat(41.25, priceConversionObj), '41.2500');
        assert.equal(fracker.toStringFromFloat(-41.5, priceConversionObj), '-41.5000');
        assert.equal(fracker.toStringFromFloat(-41.123, priceConversionObj), '-41.1230');
        assert.equal(fracker.toStringFromFloat(-41.1234, priceConversionObj), '-41.1234');
        assert.equal(fracker.toStringFromFloat(-41.12345, priceConversionObj), '-41.12345');
        assert.equal(fracker.toStringFromFloat(-41, priceConversionObj), '-41.0000');
        assert.equal(fracker.toStringFromFloat(-41.232, priceConversionObj), '-41.2320');
        assert.equal(fracker.toStringFromFloat(-41.2333, priceConversionObj), '-41.2333');
        assert.equal(fracker.toStringFromFloat(-41.12245, priceConversionObj), '-41.12245');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.5000');

    });

    it('5 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 100000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.00000');
        assert.equal(fracker.toStringFromFloat(51.07, priceConversionObj), '51.07000');
        assert.equal(fracker.toStringFromFloat(51.007, priceConversionObj), '51.00700');
        assert.equal(fracker.toStringFromFloat(51.0007, priceConversionObj), '51.00070');
        assert.equal(fracker.toStringFromFloat(51.00007, priceConversionObj), '51.00007');
        assert.equal(fracker.toStringFromFloat(51.7, priceConversionObj), '51.70000');
        assert.equal(fracker.toStringFromFloat(51.0, priceConversionObj), '51.00000');
        assert.equal(fracker.toStringFromFloat(51.5, priceConversionObj), '51.50000');
        assert.equal(fracker.toStringFromFloat(51.25, priceConversionObj), '51.25000');
        assert.equal(fracker.toStringFromFloat(51.123, priceConversionObj), '51.12300');
        assert.equal(fracker.toStringFromFloat(51.1234, priceConversionObj), '51.12340');
        assert.equal(fracker.toStringFromFloat(51.12345, priceConversionObj), '51.12345');
        assert.equal(fracker.toStringFromFloat(51.123456, priceConversionObj), '51.123456');
        assert.equal(fracker.toStringFromFloat(51.1234567, priceConversionObj), '51.1234567');
        assert.equal(fracker.toStringFromFloat(51.12345678, priceConversionObj), '51.12345678');
        assert.equal(fracker.toStringFromFloat(-51.5, priceConversionObj), '-51.50000');
        assert.equal(fracker.toStringFromFloat(-51, priceConversionObj), '-51.00000');
        assert.equal(fracker.toStringFromFloat(-51.232, priceConversionObj), '-51.23200');
        assert.equal(fracker.toStringFromFloat(-51.2333, priceConversionObj), '-51.23330');
        assert.equal(fracker.toStringFromFloat(-51.12245, priceConversionObj), '-51.12245');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.50000');
    });

    it('6 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 1000000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.000000');
        assert.equal(fracker.toStringFromFloat(61.07, priceConversionObj), '61.070000');
        assert.equal(fracker.toStringFromFloat(61.007, priceConversionObj), '61.007000');
        assert.equal(fracker.toStringFromFloat(61.0007, priceConversionObj), '61.000700');
        assert.equal(fracker.toStringFromFloat(61.00007, priceConversionObj), '61.000070');
        assert.equal(fracker.toStringFromFloat(61.000007, priceConversionObj), '61.000007');
        assert.equal(fracker.toStringFromFloat(61.7, priceConversionObj), '61.700000');
        assert.equal(fracker.toStringFromFloat(61.0, priceConversionObj), '61.000000');
        assert.equal(fracker.toStringFromFloat(61.5, priceConversionObj), '61.500000');
        assert.equal(fracker.toStringFromFloat(61.25, priceConversionObj), '61.250000');
        assert.equal(fracker.toStringFromFloat(61.123, priceConversionObj), '61.123000');
        assert.equal(fracker.toStringFromFloat(61.1234, priceConversionObj), '61.123400');
        assert.equal(fracker.toStringFromFloat(61.12345, priceConversionObj), '61.123450');
        assert.equal(fracker.toStringFromFloat(61.123456, priceConversionObj), '61.123456');
        assert.equal(fracker.toStringFromFloat(61.1234567, priceConversionObj), '61.1234567');
        assert.equal(fracker.toStringFromFloat(61.12345678, priceConversionObj), '61.12345678');
        assert.equal(fracker.toStringFromFloat(-61.5, priceConversionObj), '-61.500000');
        assert.equal(fracker.toStringFromFloat(-61, priceConversionObj), '-61.000000');
        assert.equal(fracker.toStringFromFloat(-61.232, priceConversionObj), '-61.232000');
        assert.equal(fracker.toStringFromFloat(-61.2333, priceConversionObj), '-61.233300');
        assert.equal(fracker.toStringFromFloat(-61.12245, priceConversionObj), '-61.122450');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.500000');
    });
});

describe('Convert to a single-fractional from a number', function () {
    it('halves to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 2,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), '0');
        assert.equal(fracker.toFractionalFromFloat(11.0, priceConversionObj), '11');
        assert.equal(fracker.toFractionalFromFloat(99.5, priceConversionObj), '99 1/2');
        assert.equal(fracker.toFractionalFromFloat(0.5, priceConversionObj), '1/2');
        assert.equal(fracker.toFractionalFromFloat(-0.5, priceConversionObj), '-1/2');

    });

    it('fourths to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), '0');
        assert.equal(fracker.toFractionalFromFloat(74, priceConversionObj), '74');
        assert.equal(fracker.toFractionalFromFloat(33.25, priceConversionObj), '33 1/4');
        assert.equal(fracker.toFractionalFromFloat(43.5, priceConversionObj), '43 2/4');
        assert.equal(fracker.toFractionalFromFloat(193.75, priceConversionObj), '193 3/4');
        assert.equal(fracker.toFractionalFromFloat(0.75, priceConversionObj), '3/4');
        assert.equal(fracker.toFractionalFromFloat(-0.75, priceConversionObj), '-3/4');
    });

    it('eights to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 8,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), '0');
        assert.equal(fracker.toFractionalFromFloat(101.0, priceConversionObj), '101');
        assert.equal(fracker.toFractionalFromFloat(995.125, priceConversionObj), '995 1/8');
        assert.equal(fracker.toFractionalFromFloat(334.25, priceConversionObj), '334 2/8');
        assert.equal(fracker.toFractionalFromFloat(567.375, priceConversionObj), '567 3/8');
        assert.equal(fracker.toFractionalFromFloat(474.5, priceConversionObj), '474 4/8');
        assert.equal(fracker.toFractionalFromFloat(272.625, priceConversionObj), '272 5/8');
        assert.equal(fracker.toFractionalFromFloat(101.75, priceConversionObj), '101 6/8');
        assert.equal(fracker.toFractionalFromFloat(263.875, priceConversionObj), '263 7/8');
        assert.equal(fracker.toFractionalFromFloat(0.875, priceConversionObj), '7/8');
        assert.equal(fracker.toFractionalFromFloat(-0.875, priceConversionObj), '-7/8');
    });

    it('sixteenths to string');
    it('thirty-seconds to string');
    it('sixty-fourths to string');
    it('one-twenty-eighths to string');
    it('two-fifty-sixths to string');
});

describe('Convert a number to a multi-fractional string', function () {
    it('thirty-seconds-halves to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 2
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), "0'00.0");
        assert.equal(fracker.toFractionalFromFloat(101.0, priceConversionObj), "101'00.0");
        assert.equal(fracker.toFractionalFromFloat(995.015625, priceConversionObj), "995'00.5");
        assert.equal(fracker.toFractionalFromFloat(995.03125, priceConversionObj), "995'01.0");
        assert.equal(fracker.toFractionalFromFloat(995.046875, priceConversionObj), "995'01.5");
        assert.equal(fracker.toFractionalFromFloat(995.0625, priceConversionObj), "995'02.0");
        assert.equal(fracker.toFractionalFromFloat(995.078125, priceConversionObj), "995'02.5");
        assert.equal(fracker.toFractionalFromFloat(995.09375, priceConversionObj), "995'03.0");
        // TODO: finish off the tests here.
        assert.equal(fracker.toFractionalFromFloat(0.984375, priceConversionObj), "0'31.5");
        assert.equal(fracker.toFractionalFromFloat(-0.984375, priceConversionObj), "-0'31.5");
    });

    it('thirty-seconds-quarters to string');
});

describe('Convert a decimal to number', function () {
    it('string to a zero digit decimal');
    it('string to a one digit decimal');
    it('string to a six digit decimal');
});

describe('Convert single-fractional string to number', function () {
    it('string to a havles', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 2,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/2", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77 1/4", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77 3/4", priceConversionObj), 78);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);
    });

    it('string to a fourths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/4", priceConversionObj), 77.25);
        assert.equal(fracker.toFloatFromFractional("77 1/16", priceConversionObj), 77);
        assert.equal(fracker.toFloatFromFractional("77 1/8", priceConversionObj), 77.25);
        assert.equal(fracker.toFloatFromFractional("77 3/8", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);
    });

    it('string to a eighths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 8,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/8", priceConversionObj), 77.125);
        assert.equal(fracker.toFloatFromFractional("77 7/8", priceConversionObj), 77.875);
        assert.equal(fracker.toFloatFromFractional("77 1/16", priceConversionObj), 77.125);
        assert.equal(fracker.toFloatFromFractional("77 3/16", priceConversionObj), 77.25);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);
    });

    it('string to a thirty-seconds', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/32", priceConversionObj), 77.03125);
        assert.equal(fracker.toFloatFromFractional("77 1/64", priceConversionObj), 77.03125);
        assert.equal(fracker.toFloatFromFractional("77 31/32", priceConversionObj), 77.96875);
        assert.equal(fracker.toFloatFromFractional("77 3/64", priceConversionObj), 77.0625);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);

    });
});

describe('Convert multi-fractional string to number', function () {
    it('can handle incomplete multi-fractionals');
    it('from thirty-seconds & halves to a float', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 2
        };

        assert.equal(fracker.toFloatFromFractional("77'01.5", priceConversionObj), 77.046875);
        assert.equal(fracker.toFloatFromFractional("77'1.5", priceConversionObj), 77.046875);
        assert.equal(fracker.toFloatFromFractional("77'1.0", priceConversionObj), 77.031250);
    });
    it('string to thirty-seconds-and-quarters', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 4
        };

        assert.equal(fracker.toFloatFromFractional("77'16.2", priceConversionObj), 77.5078125);
        assert.equal(fracker.toFloatFromFractional("77'16.5", priceConversionObj), 77.515625);
        assert.equal(fracker.toFloatFromFractional("77'16.7", priceConversionObj), 77.5234375);
        assert.equal(fracker.toFloatFromFractional("77'16.0", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77'16.8", priceConversionObj), 77.53125);
    });
    it('string to thirty-seconds-and-eighths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 8
        };

        assert.equal(fracker.toFloatFromFractional("77'8.1", priceConversionObj), 77.25390625);
        assert.equal(fracker.toFloatFromFractional("77'8.2", priceConversionObj), 77.2578125);
        assert.equal(fracker.toFloatFromFractional("77'8.3", priceConversionObj), 77.26171875);
        assert.equal(fracker.toFloatFromFractional("77'8.5", priceConversionObj), 77.265625);
        assert.equal(fracker.toFloatFromFractional("77'8.6", priceConversionObj), 77.26953125);
    });
    it('string to thirty-seconds and tenths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 10
        };

        assert.equal(fracker.toFloatFromFractional("77'8.1", priceConversionObj), 77.253125);
        assert.equal(fracker.toFloatFromFractional("77'08.1", priceConversionObj), 77.253125);
        assert.equal(fracker.toFloatFromFractional("77'8.2", priceConversionObj), 77.25625);
        assert.equal(fracker.toFloatFromFractional("77'8.3", priceConversionObj), 77.259375);
        assert.equal(fracker.toFloatFromFractional("77'8.4", priceConversionObj), 77.2625);
        assert.equal(fracker.toFloatFromFractional("77'8.5", priceConversionObj), 77.265625);
        assert.equal(fracker.toFloatFromFractional("77'8.6", priceConversionObj), 77.26875);
        assert.equal(fracker.toFloatFromFractional("77'8.7", priceConversionObj), 77.271875);
        assert.equal(fracker.toFloatFromFractional("77'8.8", priceConversionObj), 77.275);
        assert.equal(fracker.toFloatFromFractional("77'8.9", priceConversionObj), 77.278125);
        assert.equal(fracker.toFloatFromFractional("77'8.0", priceConversionObj), 77.25);
    });

    it('should increment fourths fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };

        assert.equal(fracker.increment("77", priceConversionObj), '77 1/4');
        assert.equal(fracker.increment("77 1/4", priceConversionObj), '77 2/4');
        assert.equal(fracker.increment("77 2/4", priceConversionObj), '77 3/4');
        assert.equal(fracker.increment("77 3/4", priceConversionObj), '78');
        assert.equal(fracker.increment("78", priceConversionObj), '78 1/4');
    });
    it('should decrement a fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };
        assert.equal(fracker.decrement('78', priceConversionObj), '77 3/4');
        assert.equal(fracker.decrement('77 3/4', priceConversionObj), '77 2/4');
        assert.equal(fracker.decrement('77 2/4', priceConversionObj), '77 1/4');
        assert.equal(fracker.decrement('77 1/4', priceConversionObj), '77');
        assert.equal(fracker.decrement('77', priceConversionObj), '76 3/4');
    });
    it('should increment a multi-fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 2
        };
        assert.equal(fracker.increment("77", priceConversionObj), "77'00.5");
        assert.equal(fracker.increment("77'00.5", priceConversionObj), "77'01.0");
        assert.equal(fracker.increment("77'01.0", priceConversionObj), "77'01.5");
        assert.equal(fracker.increment("77'01.5", priceConversionObj), "77'02.0");
        assert.equal(fracker.increment("77'02.0", priceConversionObj), "77'02.5");
    });
    it('should decrement a multi-fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 2
        };
        assert.equal(fracker.decrement("77'1.0", priceConversionObj), "77'00.5");
        assert.equal(fracker.decrement("77'1.1", priceConversionObj), "77'00.5");
        assert.equal(fracker.decrement("77", priceConversionObj), "76'03.5");
    });
});

describe('Convert to decimal string from string', function () {
    it('0 decimals', function () {
        assert.equal(fracker.toStringFromFloat(0), '0');
        assert.equal(fracker.toStringFromFloat(21.07), '21.07');
        assert.equal(fracker.toStringFromFloat(11.7), '11.7');
        assert.equal(fracker.toStringFromFloat(11.0), '11');
        assert.equal(fracker.toStringFromFloat(11.5), '11.5');
        assert.equal(fracker.toStringFromFloat(-11.5), '-11.5');
        assert.equal(fracker.toStringFromFloat(-11), '-11');
        assert.equal(fracker.toStringFromFloat(-0.5), '-0.5');
    });

    it('1 decimal', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 10,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(21.7, priceConversionObj), '21.7');
        assert.equal(fracker.toStringFromFloat(-21.7, priceConversionObj), '-21.7');
        assert.equal(fracker.toStringFromFloat(21.0, priceConversionObj), '21.0');
        assert.equal(fracker.toStringFromFloat(-21.0, priceConversionObj), '-21.0');
        assert.equal(fracker.toStringFromFloat(21.5, priceConversionObj), '21.5');
        assert.equal(fracker.toStringFromFloat(-21.5, priceConversionObj), '-21.5');
        assert.equal(fracker.toStringFromFloat(21.232, priceConversionObj), '21.232');
        assert.equal(fracker.toStringFromFloat(-21.232, priceConversionObj), '-21.232');
        assert.equal(fracker.toStringFromFloat(21.2333, priceConversionObj), '21.2333');
        assert.equal(fracker.toStringFromFloat(-21.2333, priceConversionObj), '-21.2333');
        assert.equal(fracker.toStringFromFloat(21.12245, priceConversionObj), '21.12245');
        assert.equal(fracker.toStringFromFloat(-21.12245, priceConversionObj), '-21.12245');
        assert.equal(fracker.toStringFromFloat(0.5, priceConversionObj), '0.5');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.5');
    });

    it('2 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 100,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.00');
        assert.equal(fracker.toStringFromFloat(31.07, priceConversionObj), '31.07');
        assert.equal(fracker.toStringFromFloat(31.7, priceConversionObj), '31.70');
        assert.equal(fracker.toStringFromFloat(31.0, priceConversionObj), '31.00');
        assert.equal(fracker.toStringFromFloat(31.5, priceConversionObj), '31.50');
        assert.equal(fracker.toStringFromFloat(31.25, priceConversionObj), '31.25');
        assert.equal(fracker.toStringFromFloat(-31.5, priceConversionObj), '-31.50');
        assert.equal(fracker.toStringFromFloat(-31, priceConversionObj), '-31.00');
        assert.equal(fracker.toStringFromFloat(-31.232, priceConversionObj), '-31.232');
    });

    it('3 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 1000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.000');
        assert.equal(fracker.toStringFromFloat(31.07, priceConversionObj), '31.070');
        assert.equal(fracker.toStringFromFloat(31.7, priceConversionObj), '31.700');
        assert.equal(fracker.toStringFromFloat(31.0, priceConversionObj), '31.000');
        assert.equal(fracker.toStringFromFloat(31.5, priceConversionObj), '31.500');
        assert.equal(fracker.toStringFromFloat(31.25, priceConversionObj), '31.250');
        assert.equal(fracker.toStringFromFloat(-31.500, priceConversionObj), '-31.500');
        assert.equal(fracker.toStringFromFloat(-31, priceConversionObj), '-31.000');
        assert.equal(fracker.toStringFromFloat(-31.232, priceConversionObj), '-31.232');
        assert.equal(fracker.toStringFromFloat(-31.2333, priceConversionObj), '-31.2333');
        assert.equal(fracker.toStringFromFloat(-31.12245, priceConversionObj), '-31.12245');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.500');
    });

    it('4 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 10000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.0000');
        assert.equal(fracker.toStringFromFloat(41.07, priceConversionObj), '41.0700');
        assert.equal(fracker.toStringFromFloat(41.007, priceConversionObj), '41.0070');
        assert.equal(fracker.toStringFromFloat(41.0007, priceConversionObj), '41.0007');
        assert.equal(fracker.toStringFromFloat(41.7, priceConversionObj), '41.7000');
        assert.equal(fracker.toStringFromFloat(41.0, priceConversionObj), '41.0000');
        assert.equal(fracker.toStringFromFloat(41, priceConversionObj), '41.0000');
        assert.equal(fracker.toStringFromFloat(41.5, priceConversionObj), '41.5000');
        assert.equal(fracker.toStringFromFloat(41.25, priceConversionObj), '41.2500');
        assert.equal(fracker.toStringFromFloat(-41.5, priceConversionObj), '-41.5000');
        assert.equal(fracker.toStringFromFloat(-41.123, priceConversionObj), '-41.1230');
        assert.equal(fracker.toStringFromFloat(-41.1234, priceConversionObj), '-41.1234');
        assert.equal(fracker.toStringFromFloat(-41.12345, priceConversionObj), '-41.12345');
        assert.equal(fracker.toStringFromFloat(-41, priceConversionObj), '-41.0000');
        assert.equal(fracker.toStringFromFloat(-41.232, priceConversionObj), '-41.2320');
        assert.equal(fracker.toStringFromFloat(-41.2333, priceConversionObj), '-41.2333');
        assert.equal(fracker.toStringFromFloat(-41.12245, priceConversionObj), '-41.12245');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.5000');

    });

    it('5 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 100000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.00000');
        assert.equal(fracker.toStringFromFloat(51.07, priceConversionObj), '51.07000');
        assert.equal(fracker.toStringFromFloat(51.007, priceConversionObj), '51.00700');
        assert.equal(fracker.toStringFromFloat(51.0007, priceConversionObj), '51.00070');
        assert.equal(fracker.toStringFromFloat(51.00007, priceConversionObj), '51.00007');
        assert.equal(fracker.toStringFromFloat(51.7, priceConversionObj), '51.70000');
        assert.equal(fracker.toStringFromFloat(51.0, priceConversionObj), '51.00000');
        assert.equal(fracker.toStringFromFloat(51.5, priceConversionObj), '51.50000');
        assert.equal(fracker.toStringFromFloat(51.25, priceConversionObj), '51.25000');
        assert.equal(fracker.toStringFromFloat(51.123, priceConversionObj), '51.12300');
        assert.equal(fracker.toStringFromFloat(51.1234, priceConversionObj), '51.12340');
        assert.equal(fracker.toStringFromFloat(51.12345, priceConversionObj), '51.12345');
        assert.equal(fracker.toStringFromFloat(51.123456, priceConversionObj), '51.123456');
        assert.equal(fracker.toStringFromFloat(51.1234567, priceConversionObj), '51.1234567');
        assert.equal(fracker.toStringFromFloat(51.12345678, priceConversionObj), '51.12345678');
        assert.equal(fracker.toStringFromFloat(-51.5, priceConversionObj), '-51.50000');
        assert.equal(fracker.toStringFromFloat(-51, priceConversionObj), '-51.00000');
        assert.equal(fracker.toStringFromFloat(-51.232, priceConversionObj), '-51.23200');
        assert.equal(fracker.toStringFromFloat(-51.2333, priceConversionObj), '-51.23330');
        assert.equal(fracker.toStringFromFloat(-51.12245, priceConversionObj), '-51.12245');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.50000');
    });

    it('6 decimals', function () {
        var priceConversionObj = {
            base: 10,
            primaryDivisor: 1000000,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toStringFromFloat(0, priceConversionObj), '0.000000');
        assert.equal(fracker.toStringFromFloat(61.07, priceConversionObj), '61.070000');
        assert.equal(fracker.toStringFromFloat(61.007, priceConversionObj), '61.007000');
        assert.equal(fracker.toStringFromFloat(61.0007, priceConversionObj), '61.000700');
        assert.equal(fracker.toStringFromFloat(61.00007, priceConversionObj), '61.000070');
        assert.equal(fracker.toStringFromFloat(61.000007, priceConversionObj), '61.000007');
        assert.equal(fracker.toStringFromFloat(61.7, priceConversionObj), '61.700000');
        assert.equal(fracker.toStringFromFloat(61.0, priceConversionObj), '61.000000');
        assert.equal(fracker.toStringFromFloat(61.5, priceConversionObj), '61.500000');
        assert.equal(fracker.toStringFromFloat(61.25, priceConversionObj), '61.250000');
        assert.equal(fracker.toStringFromFloat(61.123, priceConversionObj), '61.123000');
        assert.equal(fracker.toStringFromFloat(61.1234, priceConversionObj), '61.123400');
        assert.equal(fracker.toStringFromFloat(61.12345, priceConversionObj), '61.123450');
        assert.equal(fracker.toStringFromFloat(61.123456, priceConversionObj), '61.123456');
        assert.equal(fracker.toStringFromFloat(61.1234567, priceConversionObj), '61.1234567');
        assert.equal(fracker.toStringFromFloat(61.12345678, priceConversionObj), '61.12345678');
        assert.equal(fracker.toStringFromFloat(-61.5, priceConversionObj), '-61.500000');
        assert.equal(fracker.toStringFromFloat(-61, priceConversionObj), '-61.000000');
        assert.equal(fracker.toStringFromFloat(-61.232, priceConversionObj), '-61.232000');
        assert.equal(fracker.toStringFromFloat(-61.2333, priceConversionObj), '-61.233300');
        assert.equal(fracker.toStringFromFloat(-61.12245, priceConversionObj), '-61.122450');
        assert.equal(fracker.toStringFromFloat(-0.5, priceConversionObj), '-0.500000');
    });
});

describe('Convert to a single-fractional from a number', function () {
    it('halves to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 2,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), '0');
        assert.equal(fracker.toFractionalFromFloat(11.0, priceConversionObj), '11');
        assert.equal(fracker.toFractionalFromFloat(99.5, priceConversionObj), '99 1/2');
        assert.equal(fracker.toFractionalFromFloat(0.5, priceConversionObj), '1/2');
        assert.equal(fracker.toFractionalFromFloat(-0.5, priceConversionObj), '-1/2');

    });

    it('fourths to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), '0');
        assert.equal(fracker.toFractionalFromFloat(74, priceConversionObj), '74');
        assert.equal(fracker.toFractionalFromFloat(33.25, priceConversionObj), '33 1/4');
        assert.equal(fracker.toFractionalFromFloat(43.5, priceConversionObj), '43 2/4');
        assert.equal(fracker.toFractionalFromFloat(193.75, priceConversionObj), '193 3/4');
        assert.equal(fracker.toFractionalFromFloat(0.75, priceConversionObj), '3/4');
        assert.equal(fracker.toFractionalFromFloat(-0.75, priceConversionObj), '-3/4');
    });

    it('eights to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 8,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), '0');
        assert.equal(fracker.toFractionalFromFloat(101.0, priceConversionObj), '101');
        assert.equal(fracker.toFractionalFromFloat(995.125, priceConversionObj), '995 1/8');
        assert.equal(fracker.toFractionalFromFloat(334.25, priceConversionObj), '334 2/8');
        assert.equal(fracker.toFractionalFromFloat(567.375, priceConversionObj), '567 3/8');
        assert.equal(fracker.toFractionalFromFloat(474.5, priceConversionObj), '474 4/8');
        assert.equal(fracker.toFractionalFromFloat(272.625, priceConversionObj), '272 5/8');
        assert.equal(fracker.toFractionalFromFloat(101.75, priceConversionObj), '101 6/8');
        assert.equal(fracker.toFractionalFromFloat(263.875, priceConversionObj), '263 7/8');
        assert.equal(fracker.toFractionalFromFloat(0.875, priceConversionObj), '7/8');
        assert.equal(fracker.toFractionalFromFloat(-0.875, priceConversionObj), '-7/8');
    });

    it('sixteenths to string');
    it('thirty-seconds to string');
    it('sixty-fourths to string');
    it('one-twenty-eighths to string');
    it('two-fifty-sixths to string');
});

describe('Convert a number to a multi-fractional string', function () {
    it('thirty-seconds-halves to string', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 2
        };

        assert.equal(fracker.toFractionalFromFloat(0, priceConversionObj), "0'00.0");
        assert.equal(fracker.toFractionalFromFloat(101.0, priceConversionObj), "101'00.0");
        assert.equal(fracker.toFractionalFromFloat(995.015625, priceConversionObj), "995'00.5");
        assert.equal(fracker.toFractionalFromFloat(995.03125, priceConversionObj), "995'01.0");
        assert.equal(fracker.toFractionalFromFloat(995.046875, priceConversionObj), "995'01.5");
        assert.equal(fracker.toFractionalFromFloat(995.0625, priceConversionObj), "995'02.0");
        assert.equal(fracker.toFractionalFromFloat(995.078125, priceConversionObj), "995'02.5");
        assert.equal(fracker.toFractionalFromFloat(995.09375, priceConversionObj), "995'03.0");
        // TODO: finish off the tests here.
        assert.equal(fracker.toFractionalFromFloat(0.984375, priceConversionObj), "0'31.5");
        assert.equal(fracker.toFractionalFromFloat(-0.984375, priceConversionObj), "-0'31.5");
    });

    it('thirty-seconds-quarters to string');
});

describe('Convert a decimal to number', function () {
    it('string to a zero digit decimal');
    it('string to a one digit decimal');
    it('string to a six digit decimal');
});

describe('Convert single-fractional string to number', function () {
    it('string to a havles', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 2,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/2", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77 1/4", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77 3/4", priceConversionObj), 78);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);
    });

    it('string to a fourths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/4", priceConversionObj), 77.25);
        assert.equal(fracker.toFloatFromFractional("77 1/16", priceConversionObj), 77);
        assert.equal(fracker.toFloatFromFractional("77 1/8", priceConversionObj), 77.25);
        assert.equal(fracker.toFloatFromFractional("77 3/8", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);
    });

    it('string to a eighths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 8,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/8", priceConversionObj), 77.125);
        assert.equal(fracker.toFloatFromFractional("77 7/8", priceConversionObj), 77.875);
        assert.equal(fracker.toFloatFromFractional("77 1/16", priceConversionObj), 77.125);
        assert.equal(fracker.toFloatFromFractional("77 3/16", priceConversionObj), 77.25);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);
    });

    it('string to a thirty-seconds', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 1
        };

        assert.equal(fracker.toFloatFromFractional("77 1/32", priceConversionObj), 77.03125);
        assert.equal(fracker.toFloatFromFractional("77 1/64", priceConversionObj), 77.03125);
        assert.equal(fracker.toFloatFromFractional("77 31/32", priceConversionObj), 77.96875);
        assert.equal(fracker.toFloatFromFractional("77 3/64", priceConversionObj), 77.0625);
        assert.equal(fracker.toFloatFromFractional("77", priceConversionObj), 77);

    });
});

describe('Convert multi-fractional string to number', function () {
    it('can handle incomplete multi-fractionals');

    it('from thirty-seconds & halves to a float', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 2
        };
        assert.equal(fracker.toFloatFromFractional("77'01.5", priceConversionObj), 77.046875);
        assert.equal(fracker.toFloatFromFractional("77'1.5", priceConversionObj), 77.046875);
        assert.equal(fracker.toFloatFromFractional("77'1.0", priceConversionObj), 77.031250);
    });
    it('string to thirty-seconds-and-quarters', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 4
        };

        assert.equal(fracker.toFloatFromFractional("77'16.2", priceConversionObj), 77.5078125);
        assert.equal(fracker.toFloatFromFractional("77'16.5", priceConversionObj), 77.515625);
        assert.equal(fracker.toFloatFromFractional("77'16.7", priceConversionObj), 77.5234375);
        assert.equal(fracker.toFloatFromFractional("77'16.0", priceConversionObj), 77.5);
        assert.equal(fracker.toFloatFromFractional("77'16.8", priceConversionObj), 77.53125);
    });
    it('string to thirty-seconds-and-eighths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 8
        };

        assert.equal(fracker.toFloatFromFractional("77'8.1", priceConversionObj), 77.25390625);
        assert.equal(fracker.toFloatFromFractional("77'8.2", priceConversionObj), 77.2578125);
        assert.equal(fracker.toFloatFromFractional("77'8.3", priceConversionObj), 77.26171875);
        assert.equal(fracker.toFloatFromFractional("77'8.5", priceConversionObj), 77.265625);
        assert.equal(fracker.toFloatFromFractional("77'8.6", priceConversionObj), 77.26953125);
    });
    it('string to thirty-seconds and tenths', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 10
        };

        assert.equal(fracker.toFloatFromFractional("77'8.1", priceConversionObj), 77.253125);
        assert.equal(fracker.toFloatFromFractional("77'08.1", priceConversionObj), 77.253125);
        assert.equal(fracker.toFloatFromFractional("77'8.2", priceConversionObj), 77.25625);
        assert.equal(fracker.toFloatFromFractional("77'8.3", priceConversionObj), 77.259375);
        assert.equal(fracker.toFloatFromFractional("77'8.4", priceConversionObj), 77.2625);
        assert.equal(fracker.toFloatFromFractional("77'8.5", priceConversionObj), 77.265625);
        assert.equal(fracker.toFloatFromFractional("77'8.6", priceConversionObj), 77.26875);
        assert.equal(fracker.toFloatFromFractional("77'8.7", priceConversionObj), 77.271875);
        assert.equal(fracker.toFloatFromFractional("77'8.8", priceConversionObj), 77.275);
        assert.equal(fracker.toFloatFromFractional("77'8.9", priceConversionObj), 77.278125);
        assert.equal(fracker.toFloatFromFractional("77'8.0", priceConversionObj), 77.25);
    });

    it('should increment fourths fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };

        assert.equal(fracker.increment("77", priceConversionObj), '77 1/4');
        assert.equal(fracker.increment("77 1/4", priceConversionObj), '77 2/4');
        assert.equal(fracker.increment("77 2/4", priceConversionObj), '77 3/4');
        assert.equal(fracker.increment("77 3/4", priceConversionObj), '78');
        assert.equal(fracker.increment("78", priceConversionObj), '78 1/4');
    });
    it('should decrement a fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 1
        };
        assert.equal(fracker.decrement('78', priceConversionObj), '77 3/4');
        assert.equal(fracker.decrement('77 3/4', priceConversionObj), '77 2/4');
        assert.equal(fracker.decrement('77 2/4', priceConversionObj), '77 1/4');
        assert.equal(fracker.decrement('77 1/4', priceConversionObj), '77');
        assert.equal(fracker.decrement('77', priceConversionObj), '76 3/4');
    });
    it('should increment a multi-fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 2
        };
        assert.equal(fracker.increment("77", priceConversionObj), "77'00.5");
        assert.equal(fracker.increment("77'00.5", priceConversionObj), "77'01.0");
        assert.equal(fracker.increment("77'01.0", priceConversionObj), "77'01.5");
        assert.equal(fracker.increment("77'01.5", priceConversionObj), "77'02.0");
        assert.equal(fracker.increment("77'02.0", priceConversionObj), "77'02.5");
    });
    it('should decrement a multi-fractional correctly', function () {
        var priceConversionObj = {
            base: 2,
            primaryDivisor: 4,
            secondaryDivisor: 2
        };
        assert.equal(fracker.decrement("77'1.0", priceConversionObj), "77'00.5");
        assert.equal(fracker.decrement("77'1.1", priceConversionObj), "77'00.5");
        assert.equal(fracker.decrement("77", priceConversionObj), "76'03.5");
    });
});

describe('nulls should be handled correctly', function () {
    var priceConversionObj = {
            base: 2,
            primaryDivisor: 32,
            secondaryDivisor: 2
        },
        minMove = '-3.0105';

    it('toFloatFromFractional can handle a null value', function () {
        assert.equal(fracker.toFloatFromFractional(null, priceConversionObj), 0);
    });

    it('increment can handle a null value', function () {
        assert.equal(fracker.increment(null, priceConversionObj, minMove), "0'00.5");
    });

    it('decrement can handle a null value', function () {
        assert.equal(fracker.decrement(null, priceConversionObj, minMove), "-0'00.5");
    });
});


describe('Options minMove should extract minMove details contained in the minMove value given from the webapi', function () {
    var priceConversionObj = {
            base: 10,
            primaryDivisor: 100,
            secondaryDivisor: 1
        },
        minMove = '-3.0105';

    /*
     -3.0105

     the negative value dictates the special condition
     price threshold: the integer is the price threshold
     low minMove: the first two digits of the remainder (i.e. 01)
     High minMove: the second two digits of the remainder (i.e. 05)

     */

    it('should increment a price by .01 with a minMove of -3.0105 and a price of 2.00', function () {
        assert.equal(fracker.increment(null, priceConversionObj, minMove), '0.01');
        assert.equal(fracker.increment('2.00', priceConversionObj, minMove), '2.01');
        assert.equal(fracker.increment('2.01', priceConversionObj, minMove), '2.02');
        assert.equal(fracker.increment('2.10', priceConversionObj, minMove), '2.11');
        assert.equal(fracker.increment('2.40', priceConversionObj, minMove), '2.41');
        assert.equal(fracker.increment('2.90', priceConversionObj, minMove), '2.91');
        assert.equal(fracker.increment('2.99', priceConversionObj, minMove), '3.00');
    });

    it('should increment a price by .01 with a minMove of -3.0105 and a price of 3.00', function () {
        assert.equal(fracker.increment('3.00', priceConversionObj, minMove), '3.05');
        assert.equal(fracker.increment('3.05', priceConversionObj, minMove), '3.10');
        assert.equal(fracker.increment('3.70', priceConversionObj, minMove), '3.75');
        assert.equal(fracker.increment('3.90', priceConversionObj, minMove), '3.95');
        assert.equal(fracker.increment('3.95', priceConversionObj, minMove), '4.00');
        assert.equal(fracker.increment('4.00', priceConversionObj, minMove), '4.05');
    });

    it('should increment a price by .05 with a minMove of -3.0105 and a price of 3.00', function () {
        assert.equal(fracker.increment('3.01', priceConversionObj, minMove), '3.06');
        assert.equal(fracker.increment('3.20', priceConversionObj, minMove), '3.25');
        assert.equal(fracker.increment('3.61', priceConversionObj, minMove), '3.66');
        assert.equal(fracker.increment('3.83', priceConversionObj, minMove), '3.88');
        assert.equal(fracker.increment('3.95', priceConversionObj, minMove), '4.00');
        assert.equal(fracker.increment('4.00', priceConversionObj, minMove), '4.05');
    });

    it('should decrement a price by .01 with a minMove of -3.0105 and a price of 2.00', function () {
        assert.equal(fracker.decrement('2.00', priceConversionObj, minMove), '1.99');
        assert.equal(fracker.decrement('1.99', priceConversionObj, minMove), '1.98');
        assert.equal(fracker.decrement('3.00', priceConversionObj, minMove), '2.99');
        assert.equal(fracker.decrement('2.40', priceConversionObj, minMove), '2.39');
        assert.equal(fracker.decrement('2.90', priceConversionObj, minMove), '2.89');
        assert.equal(fracker.decrement('2.99', priceConversionObj, minMove), '2.98');
    });

    it('should decrement a price by .01 with a minMove of -3.0105 and a price of 3.00', function () {
        assert.equal(fracker.decrement('3.01', priceConversionObj, minMove), '2.96');
        assert.equal(fracker.decrement('3.00', priceConversionObj, minMove), '2.99');
        assert.equal(fracker.decrement('2.98', priceConversionObj, minMove), '2.97');
        assert.equal(fracker.decrement('1.00', priceConversionObj, minMove), '0.99');
        assert.equal(fracker.decrement('.01', priceConversionObj, minMove), '0.00');
    });

    it('should decrement a price by .05 with a minMove of -3.0105 and a price of 3.00', function () {
        assert.equal(fracker.decrement('3.01', priceConversionObj, minMove), '2.96');
        assert.equal(fracker.decrement('3.20', priceConversionObj, minMove), '3.15');
        assert.equal(fracker.decrement('3.61', priceConversionObj, minMove), '3.56');
        assert.equal(fracker.decrement('3.83', priceConversionObj, minMove), '3.78');
        assert.equal(fracker.decrement('3.95', priceConversionObj, minMove), '3.90');
        assert.equal(fracker.decrement('4.00', priceConversionObj, minMove), '3.95');
    });

    // User Story #43867 Order Bar - Modify minmove logic for Options to accomodate floating integer issues
    it('should increment & decrement a price by .01 with a minMove of -3.01049985454 and a security price of 2.00', function () {
        assert.equal(fracker.increment('2.00', priceConversionObj, '-3.01049985454'), '2.01');
        assert.equal(fracker.decrement('2.00', priceConversionObj, '-3.01049985454'), '1.99');
    });
    it('should increment & decrement a price by .05 with a minMove of -3.01049985454 and a security price of 3.00', function () {
        assert.equal(fracker.increment('3.10', priceConversionObj, '-3.01049985454'), '3.15');
        assert.equal(fracker.decrement('3.10', priceConversionObj, '-3.01049985454'), '3.05');
    });
    it('should increment & decrement a price by .01 with a minMove of -3.01049985454 and a security price of 2.00', function () {
        assert.equal(fracker.increment('2.00', priceConversionObj, '-3.01049985454'), '2.01');
        assert.equal(fracker.decrement('2.00', priceConversionObj, '-3.01049985454'), '1.99');
    });
    it('should increment & decrement a price by .05 with a minMove of -3.01049985454 and a security price of 4.00', function () {
        assert.equal(fracker.increment('4.00', priceConversionObj, '-3.01049985454'), '4.05');
        assert.equal(fracker.decrement('4.00', priceConversionObj, '-3.01049985454'), '3.95');
    });
    it('should increment & decrement a price by .05 with a minMove of -3.01049985454 and a security price of 4.00', function () {
        assert.equal(fracker.increment('4.00', priceConversionObj, '-3.01049985454'), '4.05');
        assert.equal(fracker.decrement('4.00', priceConversionObj, '-3.01049985454'), '3.95');
    });
    it('should inc/dec by .05 above & at target price and .01 below target price', function () {
        assert.equal(fracker.increment('3.00', priceConversionObj, '-3.01049985454'), '3.05');
        assert.equal(fracker.decrement('3.00', priceConversionObj, '-3.01049985454'), '2.99');

        assert.equal(fracker.increment('2.99', priceConversionObj, '-3.01049985454'), '3.00');
        assert.equal(fracker.decrement('2.95', priceConversionObj, '-3.01049985454'), '2.94');
    });
});