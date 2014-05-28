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
        getPrecision = function (number, displayType) {
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
        getPriceScale = function (displayType) {
            return 1 /
                (displayType.primaryDivisor * displayType.secondaryDivisor);
        },
        getMinMove = function (price, displayType, minMoveFactor, direction) {
            var priceScale = getPriceScale(displayType),
                threshold, minMoveStr, lowMove, highMove, increment = 1;
            minMoveFactor = minMoveFactor || 1;


            if (minMoveFactor < 0) {
                threshold = Math.floor(Math.abs(minMoveFactor));
                minMoveStr = minMoveFactor.toString();
                lowMove = Number(minMoveStr.substr(minMoveStr.indexOf('.') + 1, 2));
                // User Story #43867 - round the remainder
                highMove = Math.round(+('.' + minMoveStr.substr(minMoveStr.indexOf('.') + 3)) * 100);

                if ((direction === increment ?
                    price >= threshold :
                    price > threshold)) {
                    minMoveFactor = highMove;
                } else {
                    minMoveFactor = lowMove;
                }
            }

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
        roundToNearestMinMove = function (price, displayType, minMoveFactor) {
            var minMove = getMinMove(price, displayType, minMoveFactor),
                remainder = price % minMove;
            return parseFloat((price - remainder +
                ((remainder < (minMove / 2)) ? 0.0 : minMove)).toFixed(9));
        },
        convertToFloat = function (priceString, displayType, minMoveFactor) {
            var spaceToken = ' ', fractionToken = '/', multiFractionalToken = "'",
                remainder = 0, wholeNumber, fractionString, result;

            if (typeof priceString !== 'string') {
                priceString = priceString.toString();
            }

            if (isMultiFractional(priceString, displayType)) {
                wholeNumber = parseInt(priceString.split(multiFractionalToken)[0], 10);
                remainder = parseFloat(priceString.split(multiFractionalToken)[1]);

                result = parseFloat(wholeNumber +
                    convertFractionalRemainderToDecimal(remainder, displayType));
            } else {
                wholeNumber = parseInt(priceString.split(spaceToken)[0], 10);
                fractionString = priceString.split(spaceToken)[1];

                if (priceString.indexOf('/') > -1) {
                    remainder = fractionString.split(fractionToken)[0] /
                        fractionString.split(fractionToken)[1];
                }
                result = parseFloat(wholeNumber + remainder);
            }

            return roundToNearestMinMove(result, displayType, minMoveFactor);
        },
        toStringFromFloat = function (price, displayType) {
            var fixedLength = 0, val;

            displayType = displayType || {
                base:10,
                primaryDivisor:1,
                secondaryDivisor:1
            };

            if (displayType.base === 10) {
                fixedLength = getPrecision(price, displayType);

                val = price.toFixed(fixedLength);

                return val.toString();
            } else if (displayType.base === 2) {
                return price;
            }
        },
        toFractionalFromFloat = function (price, displayType) {
            var numberParts,
                isMultiFractional = displayType.secondaryDivisor !== 1;

            if (displayType.base === 2) {
                if (isFloat(price)) {
                    numberParts = getParts(price, '.');

                    return convertToFractional(numberParts, displayType);
                } else {
                    return isMultiFractional ? price + "'00.0" : price;
                }
            }
        },
        toFloatFromFractional = function (priceString, displayType, minMoveFactor) {
            priceString = priceString || 0;
            if (displayType.base !== 10) {
                return convertToFloat(priceString, displayType, minMoveFactor);
            }

            return priceString;
        },
        incrementFractional = function (priceString, displayType, minMoveFactor) {
            var n = toFloatFromFractional(priceString, displayType, minMoveFactor),
                minMove = getMinMove(priceString, displayType, minMoveFactor, 1);

            return toFractionalFromFloat(n + minMove, displayType);
        },
        decrementFractional = function (priceString, displayType, minMoveFactor) {
            var n = toFloatFromFractional(priceString, displayType, minMoveFactor),
                minMove = getMinMove(priceString, displayType, minMoveFactor, minMoveFactor, -1);

            return toFractionalFromFloat(n - minMove, displayType);
        },
        incrementFloat = function (price, displayType, minMoveFactor) {
            var minMove = getMinMove(price, displayType, minMoveFactor, 1);
            price = price.length === 0 ? 0 : price;
            price = parseFloat(price);
            return toStringFromFloat(price + minMove, displayType);
        },
        decrementFloat = function (price, displayType, minMoveFactor) {
            var minMove = getMinMove(price, displayType, minMoveFactor, -1);
            price = price.length === 0 ? 0 : price;
            price = parseFloat(price);
            return toStringFromFloat(price - minMove, displayType);
        },
        increment = function (price, displayType, minMoveFactor) {
            price = !price ? 0 : price;

            return  (displayType.base === 2) ?
                incrementFractional(price, displayType, minMoveFactor) :
                incrementFloat(price, displayType, minMoveFactor);
        },
        decrement = function (price, displayType, minMoveFactor) {
            price = !price ? 0 : price;

            return (displayType.base === 2) ?
                decrementFractional(price, displayType, minMoveFactor) :
                decrementFloat(price, displayType, minMoveFactor);
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
            decrement:decrement,

            /**
             * get price scale
             */
            getPriceScale:getPriceScale,

            /**
             * get display precision
             */
            getPrecision:getPrecision
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
