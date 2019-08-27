function threeSum(nums) {
  let l = nums.length;
  let r = [];

  for (let i = 0; i < l; i ++) {
    let j = i + 1;
    let k = l - 1;
    while (nums[i] === nums[i + 1]) {
      i ++;
    }
    while(j < k) {
      if (nums[i] > 0 || nums[i] * nums[k] > 0) {
        break;
      }
      const result = nums[i] + nums[j] + nums[k];
      if (result === 0) {
        r.push([nums[i], nums[j], nums[k]]);
      }
      if (result <= 0) {
        j ++;
        while (nums[j] === nums[j + 1]) {
          j ++;
        }
      } else {
        k --;
        while (nums[k] === nums[k - 1]) {
          k --;
        }
      }
    }
  }
  return r;
}

console.log(threeSum([0,-1,-1,-4,2,1]));
console.log(threeSum([0,0,0,0,0]));