// 给定 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0)。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

/**
 * @param {number[]} height
 * @return {number}
 */
var maxArea = function(height) {
  var start = 0;
  var end = height.length - 1;
  
  var area = 0;

  while(start !== end) {
    var h1 = height[start];
    var h2 = height[end];
    area = Math.max(area, Math.min(h1, h2) * (end - start));

    if (h1 < h2) {
      start ++;
    } else {
      end --;
    }
  }
  return area;
};


console.log(maxArea([1,8,6,2,5,4,8,3,7]))