/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
const twoSum = function(nums, target) {
  let map = {};
  for (let i = 0, l = nums.length; i < l; i ++) {
    let num = nums[i];
    if (map[target - num]) {
      return [num, target - num]
    }
    map[num] = true;
  }
};

console.log(twoSum([3,2,4], 6));