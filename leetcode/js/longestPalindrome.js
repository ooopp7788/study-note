/**
 * @param {string} s
 * @return {string}
 */
var longestPalindrome = function(s) {
  var max = '';
  var l = s.length;
  while(l --) {
    let chr = s.charAt(l);
    let chrNext = s.charAt(l + 1);

    let result = expandStr(l, l, s);
    if (result.length > max.length) {
      max = result;
    }

    if (chr === chrNext) {
      let result = expandStr(l, l + 1, s);
      if (result.length > max.length) {
        max = result;
      }
    }
  }
  return max;
};

var expandStr = function(start, end, s) {
  while(start > 0 && end < s.length && s[start - 1] === s[end + 1]) {
    start--;
    end++;
  }
  return s.substring(start, end + 1);
}

console.log(longestPalindrome("ccc"));