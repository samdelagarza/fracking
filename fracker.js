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
	var n = (number).toString().split(delimiter),
		wholeNumber, remainder, fractional;

		wholeNumber = n[0];
		remainder = n[1];

	return [wholeNumber, remainder];
},
convertToFractional = function(parts, displayType) {
	var digits = parts[1].toString().length,
		decimalPlaces = Math.pow(10, digits),
		factor = decimalPlaces / displayType.primaryDivisor,
		wholeNumber = parts[0] == 0 ? '' : parts[0] + ' ',
		numerator = parts[1] / factor,
		denominator = decimalPlaces / factor;

		// console.log('number: ', parts[0]);
		// console.log('wholeNumber: ', parts[0]);
		// console.log(numerator);
		// console.log(denominator);

	return (isNegative(parts[0]) ? '-':'') + wholeNumber + numerator + '/' + denominator;
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
		var numberParts;

		if(displayType.base === 2){
			if(isFloat(number)){
				numberParts = getParts(number, '.');
				
				return convertToFractional(numberParts, displayType);
			} else {
				return number;
			}
		}
	}
};

exports.fracker = {
	toStringFromFloat: f.toStringFromFloat,
	toFractionalFromFloat: f.toFractionalFromFloat,
};	