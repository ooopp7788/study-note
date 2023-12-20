/**
 * @param {number[][]} costs
 * @return {number}
 */
var minCost = function(cs) {
    var n = cs.length;
    var a = cs[0][0], b = cs[0][1], c = cs[0][2];
    for (var i = 0; i < n - 1; i++) {
       var a_tmp = Math.min(b, c) + cs[i + 1][0];
       var b_tmp = Math.min(c, a) + cs[i + 1][1];
       var c_tmp = Math.min(b, a) + cs[i + 1][2];
       a = a_tmp;
       b = b_tmp;
       c = c_tmp;
       console.log(a, b , c);
    }
    return Math.min(a_tmp, Math.min(b_tmp, c_tmp));
};

var costs = [[17,2,17],[16,16,5],[14,3,19]]

console.log(minCost(costs))