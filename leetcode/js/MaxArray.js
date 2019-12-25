function maxArray(nums) {
  let max = -Infinity;
  let sum = 0;
  for (n of nums) {
    sum += n
    console.log(sum, max)
    max = Math.max(max, sum)
    if (sum < 0) {
      sum = 0
    }
  }
  return max;
}

console.log(maxArray( [-2,1,-3,4,-1,2,1,-5,4]))
console.log(maxArray( [-2,-10,-3,-4,-1,-2,-1,-5,-4]))