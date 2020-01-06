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
          if (i - coin >= 0) {
              if (arr[i] !== -1) {
                arr[i] = Math.min(1 + arr[i - coin], arr[i])
              }
              arr[i] = 1 + arr[i - coin]
          }
      }
      i++
  }
  return arr[n]
}

console.log(coinChange([2], 3))