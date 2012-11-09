/*! fracking - v0.1.0 - 2012-11-08
* https://github.com/samdelagarza/fracking
* Copyright (c) 2012 TradeStation Technologies, Inc. All rights reserved; Licensed MIT */

var getRemainder = function (number) {
        var n = Math.abs(number).toString();

        if (n.indexOf('.') < 0) {
            return 0;
        }

        return (number.toString()).split('.')[1];
    },
    isFloat = function (number) {
        return  (Math.abs(number) % 1) > 0;
    },
    isNegative = function (number) {
        return number.toString().indexOf('-') > -1;
    },
    isMultiFractional = function (number, displayType) {
        return displayType.secondaryDivisor !== 1 || number.indexOf("'") > -1;
    },
    getFixedLength = function (number, displayType) {
        var fixedLength = (displayType.primaryDivisor.toString()).length - 1,
            remainderLen = getRemainder(number) === 0 ?
                0 :
                (getRemainder(number).toString()).length;

        fixedLength = remainderLen > fixedLength ?
            remainderLen :
            fixedLength;

        return fixedLength;
    },
    getParts = function (number, delimiter) {
        var n, wholeNumber, remainder, fractional;

        n = (number).toString().split(delimiter);
        wholeNumber = n[0];
        remainder = n[1];

        return [wholeNumber, remainder];
    },
    getMinMove = function (displayType) {
        return 1 / (displayType.primaryDivisor * displayType.secondaryDivisor);
    },
    convertToFractional = function (parts, displayType) {
        var digits = parts[1].toString().length,
            decimalPlaces = Math.pow(10, digits),
            factor = decimalPlaces / displayType.primaryDivisor,
            wholeNumber = parts[0].replace('-', '') === '0' ? '' : parts[0] + ' ',
            primaryDivisorDecimal = 1 / displayType.primaryDivisor,
            numerator, denominator, result, decimal, quotient, remainder, wholeQuotient;

        if (parts[0] === 0 && parts[1] === 0) {
            return "0'00.0";
        }

        if (isMultiFractional(parts.join('.'), displayType)) {
            result = wholeNumber.toString().replace(/\s/g, '');
            result = result.length === 0 ? 0 : result;

            decimal = parseFloat('.' + parts[1]);
            quotient = decimal / primaryDivisorDecimal;

            if (quotient === 1) {
                result = result + "'0" + quotient + ".0";
            } else {
                wholeQuotient = quotient.toString().split('.')[0];
                remainder = quotient.toString().split('.')[1] || 0;

                // pad number
                if (quotient < 10) {
                    wholeQuotient = '0' + wholeQuotient;
                }

                result = (isNegative(parts[0]) ? '-' : '') + result + "'" + wholeQuotient + "." + remainder;
            }

        } else {
            numerator = parts[1] / factor;
            denominator = decimalPlaces / factor;

            result = (isNegative(parts[0]) ? '-' : '') + wholeNumber +
                numerator + '/' + denominator;
        }

        return result;
    },
    convertFractionalRemainderToDecimal = function (remainder, displayType) {
        var appendix = '', remainderString = remainder + '';

        if (displayType.secondaryDivisor !== 10) {
            if (remainderString.indexOf('.2') > -1 || remainderString.indexOf('.7') > -1) {
                appendix = '5';
            } else if (remainderString.indexOf('.1') > -1 || remainderString.indexOf('.6') > -1) {
                appendix = '25';
            } else if (remainderString.indexOf('.3') > -1 || remainderString.indexOf('.8') > -1) {
                appendix = '75';
            }

            remainderString += appendix;
            remainder = parseFloat(remainderString);
        }
        return ((remainder / displayType.primaryDivisor).toFixed(9)).replace('0.', '.');
    },
    roundToNearestMinMove = function (number, displayType) {
        var minMove = getMinMove(displayType),
            remainder = number % minMove;

        return parseFloat((number - remainder + ((remainder < (minMove / 2)) ? 0.0 : minMove)).toFixed(9));
    },
    convertToFloat = function (numberString, displayType) {
        var spaceToken = ' ', fractionToken = '/', multiFractionalToken = "'",
            remainder = 0, wholeNumber, fractionString, result;

        if (isMultiFractional(numberString, displayType)) {
            wholeNumber = parseInt(numberString.split(multiFractionalToken)[0], 10);
            remainder = parseFloat(numberString.split(multiFractionalToken)[1]);

            result = parseFloat(wholeNumber + convertFractionalRemainderToDecimal(remainder, displayType));
        } else {
            wholeNumber = parseInt(numberString.split(spaceToken)[0], 10);
            fractionString = numberString.split(spaceToken)[1];

            if (numberString.indexOf('/') > -1) {
                remainder = fractionString.split(fractionToken)[0] /
                    fractionString.split(fractionToken)[1];
            }
            result = parseFloat(wholeNumber + remainder);
        }

        return roundToNearestMinMove(result, displayType);
    },
    f = {
        toStringFromFloat:function (number, displayType) {
            var fixedLength = 0, val;

            displayType = displayType || {
                base:10,
                primaryDivisor:1,
                secondaryDivisor:1
            };

            if (displayType.base === 10) {
                fixedLength = getFixedLength(number, displayType);

                val = number === 0 ?
                    number.toFixed(fixedLength) :
                    number.toFixed(fixedLength);

                return val.toString();
            } else if (displayType.base === 2) {
                return number;
            }
        },
        toFractionalFromFloat:function (number, displayType) {
            var numberParts,
                isMultiFractional = displayType.secondaryDivisor !== 1;

            if (displayType.base === 2) {
                if (isFloat(number)) {
                    numberParts = getParts(number, '.');

                    return convertToFractional(numberParts, displayType);
                } else {
                    return isMultiFractional ? number + "'00.0" : number;
                }
            }
        },
        toFloatFromFractional:function (numberString, displayType) {
            return convertToFloat(numberString, displayType);
        },
        incrementFractional:function (numberString, displayType) {
            var n = this.toFloatFromFractional(numberString, displayType),
                minMove = getMinMove(displayType);

            return this.toFractionalFromFloat(n + minMove, displayType);
        },
        decrementFractional:function (numberString, displayType) {
            var n = this.toFloatFromFractional(numberString, displayType),
                minMove = getMinMove(displayType);

            return this.toFractionalFromFloat(n - minMove, displayType);
        }
    };

exports.fracker = {
    // TODO: is this one really needed?
    toStringFromFloat:f.toStringFromFloat,
    toFractionalFromFloat:f.toFractionalFromFloat,
    toFloatFromFractional:f.toFloatFromFractional,
    incrementFractional:f.incrementFractional,
    decrementFractional:f.decrementFractional,
    incrementFloat:f.incrementFloat,
    decrementFloat:f.decrementFloat
};	

























