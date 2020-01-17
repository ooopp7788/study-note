// v1
var fact = function(x) {
  if (x == 0) {
    return 1
  }
  return x * fact(x - 1)
}

// v2
var fact2 = function(self) {
  return function (x) {
    if (x == 0) {
      return 1
    }
    if (x > 0) {
      return x * self(self)(x - 1)
    }
  }
}
// console.log(fact2(fact2)(3))

// v3: fab 业务代码抽离到 f
var fact3 = function(h) {
  return function (x) {
    // 业务抽象
    var f = function(q) {
      return function(x) {
        if (x == 0) {
          return 1
        }
        if (x > 0) {
          // h(h) 抽象为 q
          // return x * h(h)(x - 1)
          return x * q(x - 1)
        }
      }
    }
    // 递归在外部完成
    return f(h(h))(x)
  }
}
// console.log(fact3(fact3)(4))

// 业务抽象
var f = function(q) {
  return function(x) {
    if (x == 0) {
      return 1
    }
    if (x > 0) {
      // h(h) 抽象为 q
      // return x * h(h)(x - 1)
      return x * q(x - 1)
    }
  }
}
// v4
var fact4 = function(h) {
  return function (x) {
    // 递归在参数中完成
    return f(h(h))(x)
  }
}
// console.log(fact4(fact4)(4))

// v5
// Y 组合子
var Y = function(f) {
  // 自己调用自己
  // fact(fact)
  return (function(g) {
    return g(g)
  })(function(h) {
    return function (x) {
      // 递归在参数中完成
      return f(h(h))(x)
    }
  })
}
// 使用 Y 组合子，匿名函数 f 递归
var fact5 = Y(function(q) {
  return function(x) {
    if (x == 0) {
      return 1
    }
    if (x > 0) {
      // h(h) 抽象为 q
      // return x * h(h)(x - 1)
      return x * q(x - 1)
    }
  }
})
// console.log(fab4(fab4)(4))
// Y(f) = fab4(fab4)
console.log(fact5(4))