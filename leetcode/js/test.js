let arr = [
  [
    ['1-7', '2-6'],
    '4-6',
    [
      ['2-0', '1-4'],
      ['3-9'],
      '4-5',
    ],
  ]
]

// Q1: 完成数组 flat 函数
function flat(arr) {
  return arr.reduce((a, i) => {
    if (Array.isArray(i)) {
      return a.concat(flat(i))
    }
    return a.concat(i);
  }, [])
}

arr = flat(arr);
console.log(arr);

// Q2: 计算 arr 中所有的值：'1-7' => 1 * 7 = 7， 返回一个数字组成的数组
function calc(arr) {
  return arr.map((i) => {
    return i.split('-').reduce((num, i) => i * num, 1);
  })
}

arr = calc(arr);
console.log(arr);

// Q3: 对这个数组排序和去重
function sortAndReduce(arr) {
  // code
  return arr.sort((a,b) => a > b);
}

arr = sortAndReduce(arr);
console.log(arr);