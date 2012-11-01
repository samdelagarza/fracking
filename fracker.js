var 
getRemainder = function(number){
	var n = Math.abs(number).toString();

	if(n.indexOf('.') < 0){
		return 0;
	}
	
	return (number.toString()).split('.')[1];
},
isFloat = function(number){
	return  (Math.abs(number) % 1) > 0;
},
isNegative = function(number) {
	return number.toString().indexOf('-')>-1;
},
getFixedLength = function(number, displayType) {
	var fixedLength = (displayType.primaryDivisor.toString()).length-1,
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
getMinMove = function(displayType){
	return 1/(displayType.primaryDivisor * displayType.secondaryDivisor);
},
convertToFractional = function(parts, displayType) {
	var digits = parts[1].toString().length,
		decimalPlaces = Math.pow(10, digits),
		factor = decimalPlaces / displayType.primaryDivisor,
		wholeNumber = parts[0] == 0 ? '' : parts[0] + ' ',
		numerator = parts[1] / factor,
		denominator = decimalPlaces / factor,
		isMultiFractional = displayType.secondaryDivisor != 1,
		primaryDivisorDecimal = 1/displayType.primaryDivisor,
		result, decimal, quotient, remainder, wholeQuotient;

	if(parts[0] === 0 && parts[1] === 0){
		return "0'00.0";
	} 

	if(isMultiFractional){
		result = wholeNumber.toString().replace(/\s/g,'');
		result = result.length === 0 ? 0 : result;

		decimal = parseFloat('.'+parts[1]);
		quotient  = decimal/primaryDivisorDecimal;

		if(quotient == 1){
			result = result + "'0"+quotient+".0";
		} else {
			// console.log('decimal: ', decimal);
			// console.log('quotient: ', quotient);
			// console.log('primaryDivisorDecimal: ', primaryDivisorDecimal);
			// console.log('here')
			
			remainder = quotient.toString().split('.')[1] || 0;

			// console.log('remainder: ', remainder);

			wholeQuotient = quotient.toString().split('.')[0];
			// pad number
			if(quotient < 10){
				wholeQuotient = '0' + wholeQuotient;
			}
			// console.log('wholeQuotient: ', wholeQuotient)
			// console.log('quotient: ', quotient)
			// console.log('remainder: ', remainder);

			result = (isNegative(parts[0]) ? '-':'') + result + "'"+wholeQuotient + "." + remainder;
			// console.log(result)
		}

	} else {
		result = (isNegative(parts[0]) ? '-':'') + wholeNumber + 
					numerator + '/' + denominator;
	}

		// console.log('number: ', parts[0]);
		// console.log('wholeNumber: ', parts[0]);
		// console.log(numerator);
		// console.log(denominator);

	return result;
},
convertToFloat = function(numberString, displayType) {
	var spaceToken = ' ', fractionToken = '/', remainder = 0,
	wholeNumber, fractionString, result;

	// if((displayType.primaryDivisor === 2 || 
		// displayType.primaryDivisor === 4) && numberString){
		wholeNumber = parseInt(numberString.split(spaceToken)[0],10);
		fractionString = numberString.split(spaceToken)[1];
		
		if(numberString.indexOf('/') > -1){
			remainder = fractionString.split(fractionToken)[0] / 
						fractionString.split(fractionToken)[1];
		}

		result = wholeNumber + remainder;
	// }		
	
	return roundToNearestMinMove(result, displayType);
},
roundToNearestMinMove = function(number, displayType) {
	var minMove = getMinMove(displayType),
		remainder = number % minMove;

	return number - remainder + ((remainder < (minMove / 2)) ? 0.0 : minMove);
},
f = {
	toStringFromFloat: function(number, displayType) {
		var fixedLength = 0, val, 
			displayType = displayType || {
				base: 10,
				primaryDivisor: 1,
				secondaryDivisor: 1
			};

		if(displayType.base === 10){
			fixedLength = getFixedLength(number, displayType);

			// console.log('number: ', number);
			// console.log(isFloat(number));
			// console.log((number.toFixed(fixedLength)));
			// console.log(fixedLength);

			val = number === 0 ? 
							number.toFixed(fixedLength) : 
							number.toFixed(fixedLength);	
		
			return val.toString();
		} else if(displayType.base === 2){
			return number;
		}
	},
	toFractionalFromFloat: function(number, displayType) {
		var numberParts,
			isMultiFractional = displayType.secondaryDivisor != 1;

		if(displayType.base === 2){
			if(isFloat(number)){
				numberParts = getParts(number, '.');
				
				return convertToFractional(numberParts, displayType);
			} else {
				return isMultiFractional ? number + "'00.0" : number;
			}
		}
	},
	toFloatFromFractional: function(numberString, displayType) {
		return convertToFloat(numberString, displayType);
	}
};

exports.fracker = {
	toStringFromFloat: f.toStringFromFloat,
	toFractionalFromFloat: f.toFractionalFromFloat,
	toFloatFromFractional: f.toFloatFromFractional
};	

























