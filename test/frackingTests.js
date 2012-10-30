var assert = require('assert'),
	fracker = require('../fracker').fracker;

describe('Convert to decimal string from string', function(){
	it('0 decimals', function(){
		var priceConversionObj = {
			base: 10,
			primaryDivisor: 1,
			secondaryDivisor: 1
		};

		assert.equal(fracker.decimaltoString(0),'0');
		assert.equal(fracker.decimaltoString(21.07),'21.07');
		assert.equal(fracker.decimaltoString(11.7),'11.7');
		assert.equal(fracker.decimaltoString(11.0),'11');
		assert.equal(fracker.decimaltoString(11.5),'11.5');
		assert.equal(fracker.decimaltoString(-11.5),'-11.5');
		assert.equal(fracker.decimaltoString(-11),'-11');
		assert.equal(fracker.decimaltoString(-0.5),'-0.5');
	});
	
	it('1 decimal',function() {
		var priceConversionObj = {
			base: 10,
			primaryDivisor: 10,
			secondaryDivisor: 1
		};

		assert.equal(fracker.decimaltoString(21.7, priceConversionObj),'21.7');
		assert.equal(fracker.decimaltoString(-21.7, priceConversionObj),'-21.7');
		assert.equal(fracker.decimaltoString(21.0, priceConversionObj),'21.0');
		assert.equal(fracker.decimaltoString(-21.0, priceConversionObj),'-21.0');
		assert.equal(fracker.decimaltoString(21.5, priceConversionObj),'21.5');
		assert.equal(fracker.decimaltoString(-21.5, priceConversionObj),'-21.5');
		assert.equal(fracker.decimaltoString(21.232, priceConversionObj),'21.232');
		assert.equal(fracker.decimaltoString(-21.232, priceConversionObj),'-21.232');
		assert.equal(fracker.decimaltoString(21.2333, priceConversionObj),'21.2333');
		assert.equal(fracker.decimaltoString(-21.2333, priceConversionObj),'-21.2333');
		assert.equal(fracker.decimaltoString(21.12245, priceConversionObj),'21.12245');
		assert.equal(fracker.decimaltoString(-21.12245, priceConversionObj),'-21.12245');
		assert.equal(fracker.decimaltoString(0.5, priceConversionObj),'0.5');
		assert.equal(fracker.decimaltoString(-0.5, priceConversionObj),'-0.5');
	});

	it('2 decimals', function() {
		var priceConversionObj = {
			base: 10,
			primaryDivisor: 100,
			secondaryDivisor: 1
		};

		assert.equal(fracker.decimaltoString(0, priceConversionObj), '0.00');
		assert.equal(fracker.decimaltoString(31.07, priceConversionObj), '31.07');
		assert.equal(fracker.decimaltoString(31.7, priceConversionObj), '31.70');
		assert.equal(fracker.decimaltoString(31.0, priceConversionObj), '31.00');
		assert.equal(fracker.decimaltoString(31.5, priceConversionObj), '31.50');
		assert.equal(fracker.decimaltoString(31.25, priceConversionObj), '31.25');
		assert.equal(fracker.decimaltoString(-31.5, priceConversionObj), '-31.50');
		assert.equal(fracker.decimaltoString(-31, priceConversionObj), '-31.00');
		assert.equal(fracker.decimaltoString(-31.232, priceConversionObj), '-31.232');
	});

	it('3 decimals', function() {
		var priceConversionObj = {
			base: 10,
			primaryDivisor: 1000,
			secondaryDivisor: 1
		};

		assert.equal(fracker.decimaltoString(0, priceConversionObj), '0.000');
		assert.equal(fracker.decimaltoString(31.07, priceConversionObj), '31.070');
		assert.equal(fracker.decimaltoString(31.7, priceConversionObj), '31.700');
		assert.equal(fracker.decimaltoString(31.0, priceConversionObj), '31.000');
		assert.equal(fracker.decimaltoString(31.5, priceConversionObj), '31.500');
		assert.equal(fracker.decimaltoString(31.25, priceConversionObj), '31.250');
		assert.equal(fracker.decimaltoString(-31.500, priceConversionObj), '-31.500');
		assert.equal(fracker.decimaltoString(-31, priceConversionObj), '-31.000');
		assert.equal(fracker.decimaltoString(-31.232, priceConversionObj), '-31.232');
		assert.equal(fracker.decimaltoString(-31.2333, priceConversionObj), '-31.2333');
		assert.equal(fracker.decimaltoString(-31.12245, priceConversionObj), '-31.12245');
		assert.equal(fracker.decimaltoString(-0.5, priceConversionObj), '-0.500');
	});

	it('4 decimals', function() {
		var priceConversionObj = {
			base: 10,
			primaryDivisor: 10000,
			secondaryDivisor: 1
		};

		assert.equal(fracker.decimaltoString(0, priceConversionObj), '0.0000');
		assert.equal(fracker.decimaltoString(41.07, priceConversionObj), '41.0700');
		assert.equal(fracker.decimaltoString(41.007, priceConversionObj), '41.0070');
		assert.equal(fracker.decimaltoString(41.0007, priceConversionObj), '41.0007');
		assert.equal(fracker.decimaltoString(41.7, priceConversionObj), '41.7000');
		assert.equal(fracker.decimaltoString(41.0, priceConversionObj), '41.0000');
		assert.equal(fracker.decimaltoString(41, priceConversionObj), '41.0000');
		assert.equal(fracker.decimaltoString(41.5, priceConversionObj), '41.5000');
		assert.equal(fracker.decimaltoString(41.25, priceConversionObj), '41.2500');
		assert.equal(fracker.decimaltoString(-41.5, priceConversionObj), '-41.5000');
		assert.equal(fracker.decimaltoString(-41.123, priceConversionObj), '-41.1230');
		assert.equal(fracker.decimaltoString(-41.1234, priceConversionObj), '-41.1234');
		assert.equal(fracker.decimaltoString(-41.12345, priceConversionObj), '-41.12345');
		assert.equal(fracker.decimaltoString(-41, priceConversionObj), '-41.0000');
		assert.equal(fracker.decimaltoString(-41.232, priceConversionObj), '-41.2320');
		assert.equal(fracker.decimaltoString(-41.2333, priceConversionObj), '-41.2333');
		assert.equal(fracker.decimaltoString(-41.12245, priceConversionObj), '-41.12245');
		assert.equal(fracker.decimaltoString(-0.5, priceConversionObj), '-0.5000');

	});

	it('5 decimals', function() {
		var priceConversionObj = {
			base: 10,
			primaryDivisor: 100000,
			secondaryDivisor: 1
		};

		assert.equal(fracker.decimaltoString(0, priceConversionObj), '0.00000');
	});

	it('6 decimals');
});

describe('Convert to a single fractional string from number', function(){
	it('halves to string', function() {
		var priceConversionObj = {
			base: 2,
			primaryDivisor: 2,
			secondaryDivisor: 1
		}
	});
	it('test2')
});