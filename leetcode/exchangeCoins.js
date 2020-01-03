function coinChange(coins, n) {
  function _findCoin(n) {
    let l = coins.length
    while(l --) {
      const coin = coins[l]
      console.log(coin, n)
      if (n >= coin) {
        coins = coins.slice(0, l + 1)
        return coin
      }
    }
    return false
  }
  const coin = _findCoin(n)
  if (coin && n > 0) {
    const count = Math.floor(n / coin)
    return count + coinChange(coins, n - coin * count)
  }
  return -1
}
console.log(coinChange([1,2,5],11))
function sums(coins, sum) {
  if (sum === 0) {
    return 1
  } else if (sum < 0) {
    return 0
  }
  if (coins.length === 0) {
    return 0
  }
  return sums(coins, sum - coins[0]) + sums(coins.slice(1), sum)
}

// console.log(sums([1,2,3,4,5,6], 7))