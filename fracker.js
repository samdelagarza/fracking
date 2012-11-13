/*globals module, define */
(function (root, undefined) {
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
            return displayType.secondaryDivisor !== 1 || number.toString().indexOf("'") > -1;
        },
        getFixedLength = function (number, displayType) {
            var fixedLength = (displayType.primaryDivisor.toString()).length - 1,
                remainderLen = getRemainder(number) === 0 ?
                    0 :
                    (getRemainder(number).toString()).length;

            // .05+.01 = 0.060000000000000005 in javascript
            // capture these instances
            if (remainderLen < 12) {
                fixedLength = remainderLen > fixedLength ?
                    remainderLen :
                    fixedLength;
            }

            return fixedLength;
        },
        getParts = function (number, delimiter) {
            var n, wholeNumber, remainder;

            n = (number).toString().split(delimiter);
            wholeNumber = n[0];
            remainder = n[1];

            return [wholeNumber, remainder];
        },
        getMinMove = function (displayType, minMoveFactor) {
            var priceScale = 1 /
                (displayType.primaryDivisor * displayType.secondaryDivisor);
            minMoveFactor = minMoveFactor || 1;

            return priceScale * minMoveFactor;
        },
        convertToFractional = function (parts, displayType) {
            var digits = parts[1].toString().length,
                decimalPlaces = Math.pow(10, digits),
                factor = decimalPlaces / displayType.primaryDivisor,
                wholeNumber = parts[0].replace('-', '') === '0' ? '' : parts[0] + ' ',
                primaryDivisorDecimal = 1 / displayType.primaryDivisor,
                numerator, denominator, result, decimal, quotient,
                remainder, wholeQuotient;

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

                    // for multi-fractionals only, truncate the number to
                    // display only a remainder to the 10s position.
                    remainder = (remainder).toString().substring(0, 1);

                    // pad number
                    if (quotient < 10) {
                        wholeQuotient = '0' + wholeQuotient;
                    }

                    result = (isNegative(parts[0]) ? '-' : '') + result +
                        "'" + wholeQuotient + "." + remainder;
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
            var appendix = '',
                remainderString = remainder.toString();

            if (displayType.secondaryDivisor !== 10) {
                if (remainderString.indexOf('.2') > -1 ||
                    remainderString.indexOf('.7') > -1) {
                    appendix = '5';
                } else if (remainderString.indexOf('.1') > -1 ||
                    remainderString.indexOf('.6') > -1) {
                    appendix = '25';
                } else if (remainderString.indexOf('.3') > -1 ||
                    remainderString.indexOf('.8') > -1) {
                    appendix = '75';
                }

                remainderString += appendix;
                remainder = parseFloat(remainderString);
            }
            return ((remainder / displayType.primaryDivisor).toFixed(9)).replace('0.', '.');
        },
        roundToNearestMinMove = function (number, displayType, minMoveFactor) {
            var minMove = getMinMove(displayType, minMoveFactor),
                remainder = number % minMove;

            return parseFloat((number - remainder +
                ((remainder < (minMove / 2)) ? 0.0 : minMove)).toFixed(9));
        },
        convertToFloat = function (numberString, displayType, minMoveFactor) {
            var spaceToken = ' ', fractionToken = '/', multiFractionalToken = "'",
                remainder = 0, wholeNumber, fractionString, result;

            if (typeof numberString !== 'string') {
                numberString = numberString.toString();
            }

            if (isMultiFractional(numberString, displayType)) {
                wholeNumber = parseInt(numberString.split(multiFractionalToken)[0], 10);
                remainder = parseFloat(numberString.split(multiFractionalToken)[1]);

                result = parseFloat(wholeNumber +
                    convertFractionalRemainderToDecimal(remainder, displayType));
            } else {
                wholeNumber = parseInt(numberString.split(spaceToken)[0], 10);
                fractionString = numberString.split(spaceToken)[1];

                if (numberString.indexOf('/') > -1) {
                    remainder = fractionString.split(fractionToken)[0] /
                        fractionString.split(fractionToken)[1];
                }
                result = parseFloat(wholeNumber + remainder);
            }

            return roundToNearestMinMove(result, displayType, minMoveFactor);
        },
        toStringFromFloat = function (number, displayType) {
            var fixedLength = 0, val;

            displayType = displayType || {
                base:10,
                primaryDivisor:1,
                secondaryDivisor:1
            };

            if (displayType.base === 10) {
                fixedLength = getFixedLength(number, displayType);

                val = number.toFixed(fixedLength);

                return val.toString();
            } else if (displayType.base === 2) {
                return number;
            }
        },
        toFractionalFromFloat = function (number, displayType) {
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
        toFloatFromFractional = function (numberString, displayType, minMoveFactor) {
            if (displayType.base !== 10) {
                return convertToFloat(numberString, displayType, minMoveFactor);
            }

            return numberString;
        },
        incrementFractional = function (numberString, displayType, minMoveFactor) {
            var n = toFloatFromFractional(numberString, displayType, minMoveFactor),
                minMove = getMinMove(displayType, minMoveFactor, minMoveFactor);

            return toFractionalFromFloat(n + minMove, displayType);
        },
        decrementFractional = function (numberString, displayType, minMoveFactor) {
            var n = toFloatFromFractional(numberString, displayType, minMoveFactor),
                minMove = getMinMove(displayType, minMoveFactor, minMoveFactor);

            return toFractionalFromFloat(n - minMove, displayType);
        },
        incrementFloat = function (number, displayType, minMoveFactor) {
            var minMove = getMinMove(displayType, minMoveFactor, minMoveFactor);
            number = number.length === 0 ? 0 : number;
            number = parseFloat(number);
            return toStringFromFloat(number + minMove, displayType);
        },
        decrementFloat = function (number, displayType, minMoveFactor) {
            var minMove = getMinMove(displayType, minMoveFactor, minMoveFactor);
            number = number.length === 0 ? 0 : number;
            number = parseFloat(number);
            return toStringFromFloat(number - minMove, displayType);
        },
        increment = function (number, displayType, minMoveFactor) {
            number = number.length === 0 ? 0 : number;

            return  (displayType.base === 2) ?
                incrementFractional(number, displayType, minMoveFactor) :
                incrementFloat(number, displayType, minMoveFactor);
        },
        decrement = function (number, displayType, minMoveFactor) {
            number = number.length === 0 ? 0 : number;

            return (displayType.base === 2) ?
                decrementFractional(number, displayType, minMoveFactor) :
                decrementFloat(number, displayType, minMoveFactor);
        },

        lib = {
            /**
             * normalize decimals for display, including zero padding
             */
            toStringFromFloat:toStringFromFloat,

            /**
             * convert in order to display or after min-moves
             */
            toFractionalFromFloat:toFractionalFromFloat,

            /**
             * convert in order to send orders
             */
            toFloatFromFractional:toFloatFromFractional,

            /**
             * increment by the security's min-moves
             */
            increment:increment,

            /**
             * decrement by the security's min-moves
             */
            decrement:decrement
        };

    // export for commonjs or as an amd module, otherwise
    // add fracker as a global variable.
    if (typeof module !== 'undefined' && module.exports) {
        module.exports = lib;
        lib.fracker = lib;
    } else if (typeof define === 'function' && define.amd) {
        // return as an amd module
        define([], function () {
            return lib;
        });
    } else {
        root['fracker'] = lib;
    }
}(this));
