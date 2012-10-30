var 
getRemainder = function(number){
	var n = Math.abs(number).toString();

	if(n.indexOf('.') < 0){
		return 0;
	}
	
	return (number.toString()).split('.')[1];
},
isFloat = function(number){
	return  (number % 1) > 0;
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
getParts = function (number, delimeters) {
	var delimiter = delimeters[0],
		n = (number).toString().split(delimiter),
		wholeNumber, remainder, fractional;

		wholeNumber = n[0];
		remainder = n[1];

	return [wholeNumber, remainder];
},
convertToFractional = function(parts, displayType) {
	var power = Math.log(parts[1]);
	console.log('power: ', power);

	return parts.join(' ');
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
				numberParts = getParts(number, ['.']);
				
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