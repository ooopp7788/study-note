/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
const twoSum = function(nums, target) {
  let i = 0;
  while(nums.length) {
    const num = nums.shift();
    let j = 0;
    while(j < nums.length) {
      if (num + nums[j++] === target) {
        return [i, j + i];
      }
    }
    i++;
  }
};


console.log(twoSum([3,2,4], 6));