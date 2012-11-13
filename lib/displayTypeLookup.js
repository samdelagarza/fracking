(function (root, undefined) {
    var lib = function (n) {
        var priceConversion;

        switch (n) {
            case 0: // "Automatic" => not used
            case 3: // 2 Decimals => .01
            case 7: // "Simplest fraction" => not currently supported
                priceConversion = {
                    base:10,
                    primaryDivisor:100,
                    secondaryDivisor:1
                };
                break;
            case 1: // 0 decimals => 1
                priceConversion = {
                    base:10,
                    primaryDivisor:1,
                    secondaryDivisor:1
                };
                break;
            case 2: // 1 decimal => .1
                priceConversion = {
                    base:10,
                    primaryDivisor:10,
                    secondaryDivisor:1
                };
                break;
            case 4: // 3 decimals => .001
                priceConversion = {
                    base:10,
                    primaryDivisor:1000,
                    secondaryDivisor:1
                };
                break;
            case 5: // 4 decimals => .0001
                priceConversion = {
                    base:10,
                    primaryDivisor:10000,
                    secondaryDivisor:1
                };
                break;
            case 6: // 5 Decimals => .00001
                priceConversion = {
                    base:10,
                    primaryDivisor:100000,
                    secondaryDivisor:1

                };
                break;
            case 8: // 1/2 (Halves) => .5
                priceConversion = {
                    base:2,
                    primaryDivisor:2,
                    secondaryDivisor:1
                };
                break;
            case 9: // 1/4 (Fourths) => .25
                priceConversion = {
                    base:2,
                    primaryDivisor:4,
                    secondaryDivisor:1
                };
                break;
            case 10: // 1/8 (Eighths) => .125
                priceConversion = {
                    base:2,
                    primaryDivisor:8,
                    secondaryDivisor:1
                };
                break;
            case 11: // 1/16 (Sixteenths) => .0625
                priceConversion = {
                    base:2,
                    primaryDivisor:16,
                    secondaryDivisor:1
                };
                break;
            case 12: // 1/32 (ThirtySeconds) => .03125
                priceConversion = {
                    base:2,
                    primaryDivisor:32,
                    secondaryDivisor:1
                };
                break;
            case 13: // 1/64-SixtyFourths => .015625
                priceConversion = {
                    base:2,
                    primaryDivisor:64,
                    secondaryDivisor:1
                };
                break;
            case 14: // 1/128 (OneTwentyEighths) => .0078125
                priceConversion = {
                    base:2,
                    primaryDivisor:128,
                    secondaryDivisor:1
                };
                break;
            case 15: // 1/256 (TwoFiftySixths) => .00390625
                priceConversion = {
                    base:2,
                    primaryDivisor:256,
                    secondaryDivisor:1
                };
                break;
            case 16: // 10ths and Quarters => .025
                priceConversion = {
                    base:2,
                    primaryDivisor:10,
                    secondaryDivisor:4
                };
                break;
            case 17: // 32nds and Halves => .015625
                priceConversion = {
                    base:2,
                    primaryDivisor:32,
                    secondaryDivisor:2
                };
                break;
            case 18: // 32nds and Quarters => .0078125
                priceConversion = {
                    base:2,
                    primaryDivisor:32,
                    secondaryDivisor:4
                };
                break;
            case 19: // 32nds and Eights => .00390625
                priceConversion = {
                    base:2,
                    primaryDivisor:32,
                    secondaryDivisor:8
                };
                break;
            case 20: // 32nds and Tenths => .003125
                priceConversion = {
                    base:2,
                    primaryDivisor:32,
                    secondaryDivisor:10
                };
                break;
            case 21: // 64ths and Halves => .0078125
                priceConversion = {
                    base:2,
                    primaryDivisor:64,
                    secondaryDivisor:2
                };
                break;
            case 22: // 64ths and Tenths => .0015625
                priceConversion = {
                    base:2,
                    primaryDivisor:64,
                    secondaryDivisor:10
                };
                break;
            case 23: // 6 Decimals => .000001
                priceConversion = {
                    base:10,
                    primaryDivisor:1000000,
                    secondaryDivisor:1
                };
                break;
            default:
                priceConversion = {
                    base:10,
                    primaryDivisor:100,
                    secondaryDivisor:1
                };
                break;
        }

        return priceConversion;
    };

    if (typeof module !== 'undefined' && module.exports) {
        module.exports = lib;
        lib.displayTypeLookup = lib;
    } else if (typeof define === 'function' && define.amd) {
        define([], function () {
            return lib;
        });
    } else {
        root['displayTypeLookup'] = lib;
    }


}(this));