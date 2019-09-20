/**
 * @param {number} dividend
 * @param {number} divisor
 * @return {number}
 */
var divide = function(dividend, divisor) {
  var sign = true;
  var r = 0;
  var MAX = Math.pow(2, 31);
  if ((dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0)) {
    sign = false;
  }
  dividend = Math.abs(dividend);
  divisor = Math.abs(divisor);
  while(dividend >= divisor) {
    if (sign) {
      r ++;
    } else {
      r --;
    }
    dividend -= divisor;
  }
  if (r > MAX - 1 || r < -MAX) {
      return MAX - 1;
  }
  return r;
};

console.log(divide(-2147483648, -1))
console.log(divide(-2147483648, 1))