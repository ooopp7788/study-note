#### 4.1 介绍 λ 表达式
略

#### 4.2 λ-Calculus 语法和规约
```BNF
  M  =  X       // 变量定义
     |  (λX.M)  // λ 表达式定义
     |  (M M)   // M 调用

  X  =  a variable: x, y, z...
```

定义: `FV` relation
FV(M) = R: 将一个表达式 M 映射到一个 M 中所有自由变量的集合 R
FV(x) = { x }
FV((x y)) = { x y }
FV((λx.y)) = { y }
FV(z(λz.z)) = { z }

定义: `_[_ <- _]` relation
M1\[X1 <- M2\]: 将 源表达式M1，使用 表达式M2 替换 M1 中 自由变量X1 得到结果

lambda 表达式 3 个基本关系
α等价替换: 形参替换，表达式不变
β规约: 参数带入表达式
η规约: 在一个函数 f 中使用它的参数调用 g ，可得使用 f 和使用 g 等价

一般规约 n = α U β U η

跟前面一章一样，我们定义
* `->n`
* `->>n`
* `=n`

#### 4.3 布尔值编码
```
true ≐ λx.λy.x
false ≐ λx.λy.y
if ≐ λv.λt.λf.v t f
```
if true M N =   (λv.λt.λf.v t f) (λx.λy.x) M N
            ->β (λt.λf.(λx.λy.x) t f) M N
            ->β (λf.(λx.λy.x) M f) N
            ->β (λx.λy.x) M N
            ->β (λy.M) N
            ->β N

#### 4.4 Pairs
```
⟨M,N⟩  ≐   λs.sMN
mkpair ≐   λx.λy.λs.s x y
fst    ≐   λp.p true
snd    ≐   λp.p false
fst (mkpair M N)  =n  N
snd (mkpair M N)  =n  M
```

#### 4.5 Number
将 f 应用在 x 上的次数
```
0 ≐ λf.λx.x
1 ≐ λf.λx.f x
2 ≐ λf.λx.f (f x)
...

// add1
add1 ≐ λn.λf.λx.f (n f x)

// add: 数字m正好表示将 f 在 n 上应用 m 次
add ≐ λn.λm.m add1 n

// iszero
iszero ≐ λn.n (λx.false) true

// warp
wrap ≐ λf.λp.⟨false, if (fst p) (snd p) (f (snd p))⟩
// sub1
sub1 ≐ λn.λf.λx.snd (n (wrap f) ⟨true, x⟩)
```

#### 4.6 Recusion

##### mult 递归
mult 的递归定义：
  mult ≐ λn.λm.if (iszero n) 0 (add m (mult (sub1 n) m))
mult 函数在内部调用了自己，也就是递归调用，这样的递归无法扩展到一个纯的 LC 表达式

##### LC表达式通过自身应用实现递归
step1:将自调用函数抽象为参数传入
mkmult0 ≐ λt.λn.λm.if (iszero n) 0 (add m (t (sub1 n) m))

##### 不动点 和 Y 组合子
```
Y ≐ λf.(λx.f (x x)) (λx.f (x x))
```

#### 4.7 λ-Calculus
表达式完全规约，指一个表达式子无法被 ->β 规约 和 ->η 规约，也叫一个表达式是`正则形式 normal form`

如果 M =n N 且 N 是一个`正则形式`表达式，那么 M 有 `正则形式`表达式 N

##### 定理 4.2
如果 L =n M, L =n N 且 M N 都是`正则形式`表达式，那么 M =α N

##### 定理 4.3 Church-Rosser for =n
如果 M =n N，那么一定存在一个 L，使得 M ->>n L 且 N ->>n L

##### 定理 4.4 钻石性质 for ->>n
注*: 钻石性质 对 ->n 是无效的，因为 β规约 和 η规约 可能将表达式变得更加复杂，使得单次规约无法得到相等表达式
比如:
表达式:          (λx.x x) ((λy.y) (λz.z))
->n 规约结果一:   (((λy.y) (λz.z)) ((λy.y) (λz.z)))
->n 规约结果二:   (λx.x x) (λz.z)
下一章会看到，针对这种问题的解决方案，是在独立的子表达式中定义一种并行规约，那么结果一中的 2个 ((λy.y) (λz.z)) 子表达式可以马上被规约

##### 并非所有表达式都可以转化为`正则形式`表达式
如: Ω ≐ ((λx.x x) (λx.x x))
这种无法终止的规约的问题是: 我们会对一个函数的参数求值，但这个参数不会被函数体所使用
这个暗示了一个策略: 我们应该应用表达式`最左边`的 β 或 η规约，以获得`正则形式`表达式

##### 定理4.5 正则序规约：只有当 M ->>n̄ N 时，M 有正则形式 N
定义`->n̄`: 表示标准顺序规约，如果存在`正则形式`表达式，这个关系符保证一定能找到`正则形式`表达式
虽然标准顺序规约总是能找到`正则形式`表达式（如果存在的话），但是没有编程语言使用它，因为它很强大的同时，速度也很慢。

#### 4.8 历史
在 Turing 发明图灵机之前，Church 就发明了 lambda验算
Barendregt 以逻辑系统的形式，提供了一个lambda验算的综合学习
他的书提供了许多可应用于计算的技术，但书中并没有将lambda演算作为一个计算来代替程序语言