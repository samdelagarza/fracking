var 
getRemainder = function(number){
	var n = Math.abs(number).toString();

	if(n.indexOf('.') < 0){
		return 0;
	}
	
	return (number.toString()).split('.')[1];
},
isFloat = function(number){
	var d = getRemainder(number);
	return d !== 0;
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

			if(isFloat(number)){
				val = (fixedLength===0 ? 
								number : 
								(number.toFixed(fixedLength)));
			} else {
				val = number === 0 ? 
								number.toFixed(fixedLength) : 
								number.toFixed(fixedLength);	
			}

			return val.toString();
		} else if(displayType.base === 2){
			return number;
		}
	},
	toFractionalFromFloat: function(number, displayType) {
		if(displayType.base === 2){
			// is a fractional number
			if(number.indexOf(fracToken) > -1){

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