function sum(arr, k) {
  let count = 0
  let sumList = []
  let decadeSum = 0
  let target = 0
  for(let i = 0, l = arr.length; i < l; i++) {
    let num = arr[i]
    target += num
    decadeSum += num
    if (num < 0) {
      sumList.push({
        index: i,
        value: decadeSum
      })
      decadeSum = 0
    }
  }

  if (target > k) {
    const first = sumList[0]
    if (first) {
      if (first.value)
    } else if (last) {

    } else {
      return count
    }
    const last = sumList[sumList.length - 1]
  }
  console.log(sumList, target)
}

sum([-3, 2, 19, -5, 3002, -293], 2003)

