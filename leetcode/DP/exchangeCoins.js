/**
 * @param {number[]} coins
 * @param {number} amount
 * @return {number}
 */
function coinChange(coins, n) {
  let arr = new Array(n + 1).fill(-1)
  arr[0] = 0
  let i = 1
  while (i <= n) {
    for (coin of coins) {
      if (i >= coin && arr[i - coin] >= 0) {
        if (arr[i] < 0) {
          arr[i] = arr[i - coin] + 1
        } else {
          arr[i] = Math.min(1 + arr[i - coin], arr[i])
        }
      }
    }
    i++
  }
  return arr[n]
}

console.log(coinChange([2, 3],30))