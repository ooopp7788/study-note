function exchange(coins, n) {
  function _findCoin(n) {
    let l = coins.length
    while(l --) {
      const coin = coins[l]
      if (n >= coin) {
        coins = coins.slice(0, l + 1)
        return coin
      }
    }
    return false
  }
  const coin = _findCoin(n)
  if (coin && n > 0) {
    return [coin, ...exchange(coins, n - coin)]
  }
  return []
}

coins = [1, 5, 10, 50];
console.log(exchange(coins, 6))