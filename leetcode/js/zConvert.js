/**
 * @param {string} s
 * @param {number} numRows
 * @return {string}
 */
var convert = function(s, numRows) {
  var rows = [];
  if (!s.length) return '';

  for (var i = 0, l = Math.min(s.length, numRows); i < l; i ++) rows[i] = '';

  var down = false;
  var idx = 0;
  for (c of s) {
    rows[idx] += c;
    if (idx === 0 || idx === numRows - 1) {
      down = !down;
    }
    down ? idx += 1 : idx -= 1;
  }
  var result = '';
  for (c of rows) {
    result += c;
  }
  return result;
};

// convert('avbssdds', 2);