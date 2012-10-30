var 
priceConversionObj = {
	base: 10,
	primaryDivisor: 1,
	secondaryDivisor: 1
},
getRemainder = function(number){
	var n = Math.abs(number).toString();

	if(n.indexOf('.') < 0){
		return 0;
	}
	
	return (number.toString()).split('.')[1];
},
isDecimal = function(number){
	var d = getRemainder(number);
	return d !== 0;
},
getFixedLength = function(number, displayType) {
	var fixedLength = (displayType.primaryDivisor.toString()).length-1,
	remainderLen = (getRemainder(number).toString()).length;

	fixedLength = remainderLen > fixedLength ? 
	remainderLen : 
	fixedLength;

	return fixedLength;
},
f = {
	decimaltoString: function(number, displayType) {
		var fixedLength = 0, val;

		if(displayType){
			fixedLength = getFixedLength(number, displayType);
		}

		// console.log('number: ', number);
		// console.log(isDecimal(number));
		// console.log((number.toFixed(fixedLength)));
		// console.log(fixedLength);

		if(isDecimal(number)){
			val = (fixedLength===0? number :(number.toFixed(fixedLength)));
		} else {
				// console.log('here: ', number);
				// console.log('here: ', number.toFixed(fixedLength));
			val = number === 0 ? number.toFixed(fixedLength) : number.toFixed(fixedLength);
		}

		// console.log('val: ', val);
		return val.toString();
	}
};

exports.fracker = {
	decimaltoString: f.decimaltoString
};	