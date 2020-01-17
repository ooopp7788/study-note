### ISWIM
Church 将 lambda演算 发展为一种学习数学运算的方式，与机械式的运算方式一起成为两种相反的思路。
1960 年代，Landin 证明 Chruch 的lambda演算对于大部分程序语言来说，并不是一个合适的模型。
比如: (λx.1) (sub1 λy.y)
* 这个表达式可以被规约为 1，即使很多语言会对 (sub1 λy.y) 产生抱怨
* 这个问题不是关于 sub1 和 λy.y 的编码，而是在表达式中进行 β规约 时，可以完全忽略所有的参数

这种 [call-by-name](https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_name) 的行为是否令人满意是存在争议的。
很多语言采用[call-by-value](https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_value)，参数在应用于函数前，会被完全求值。

备注:
* call-by-name: 函数体中使用参数表达式时，再求值，多次使用多次求值
* call-by-value: 传入的参数表达式提前求值，将结果值绑定至函数中相应变量，通常是将结果value拷贝一份存储起来

这一章中，我们会介绍 Landin‘s ISWIM，这门语言更接近的模拟了 `call-by-value`类型语言（如Scheme 和 ML）的核心。
* ISWIM 的基本语法和 λ-calculus 一致，自由变量和代换也是一样
* 和 λ-calculus 不一样的是，它更像一门真实的程序语言
* ISWIM 提供基本常量和初级操作的集合
* 更更笨的不同时 ISWIM 使用 `call-by-value` 规约规则

#### 5.1 ISWIM Expressions
```BNF
M,N,L,K  =  X
         |  (λX.M)
         |  (M M)
         |  b
         |  (o^n M ... M)

X   =  avariable: x,y,...           // 变量
b   =  a basic constant             // 常量
o^n =  an n-ary primitive operation // n元基本操作
```
注*: n-ary 基本操作: 接受 N 个参数的操作符

进一步定义:
b   =  { ⌈n⌉ | n ∈ Z }
o^1 =  { add1,sub1,iszero }
o^2 =  { +, -, *, }

(if0 K M N) ≐ (((iszero K) (λX.M) (λX.N)) ⌈0⌉) where X ̸∈ FV(M) ∪ FV(N)

#### 5.2 ISWIM Reductions
ISWIM 中的函数，仅接受完全求值后的参数，所以我们需要定义 values 集合
```BNF
V,U,W  =  b      // 常量
       |  X      // 变量
       |  (λX.M) // 函数
```

* ISWIM 中的核心规约关系是 βv，和 β 很像，只是规约参数要求必须在集合 V 中，而不是 M；
((λX.M) V) βv M[X ← V]
* ISWIM 中，((λx.1) (sub1 λy.y)) 无法被 βv 规约为 1，因为参数要求必须是集合 V 的成员，类似的((λx.1) (sub1 1)) 会首先被规约为 ((λx.1) 0) ，然后规约为 1，这就是规约内在的顺序
* ISWIM 中没有类似 η 规约的关系，这个反映了一个事实：一种程序语言的实现通常不会将函数抽象出来，然后在另一个函数中调用
* 从现在起，α 规约不在看做一种规约，而是一种等价关系，用来比较表达式是否等价

##### δ
* ISWIM 规约规则需要对初级操作做出解释
* 大体上看，b 和 o^n 是通过同一种方式抽象出来的（即使我们定义了具体的集合做为示例）
* 与基本操作相关的规约，用抽象 δ 表示，δ 关系将每个 o^n 加上n个基本常量 映射到一个 value

例子:
```
(add1 ⌈m⌉)   b1  ⌈m+1⌉
(sub1 ⌈m⌉)   b1  ⌈m−1⌉
(iszero ⌈0⌉) b1  λxy.x
(iszero ⌈n⌉) b1  λxy.y  n != 0
(+⌈m⌉ ⌈n⌉)   b2  ⌈m+n⌉
(−⌈m⌉ ⌈n⌉)   b2  ⌈m−n⌉
(∗⌈m⌉ ⌈n⌉)   b2  ⌈m·n⌉
(↑ ⌈m⌉ ⌈n⌉)  b2  ⌈m^n⌉

δ = b1 U b2
```

最后我们得到完整的规约 v
v = βv U δ
以及 `->v` `->>v` `=v`

#### Yv 组合子
SIWIM 中的 Y 和 LC 中的 Y 组合子一样，但是事实上 Y 组合子并没有很大用处
Y ≐ λf.(λx.f (x x)) (λx.f (x x))
Y f  =    (λf.(λx.f (x x)) (λx.f (x x))) f
     ->v  (λx.f (x x)) (λx.f (x x))
     ->v  f ((λx.f (x x) (λx.f (x x))
问题是: 最后的表达式，是 `f (M M)` 形式，f 函数的参数 (M M) 形式，并不是 values 的元素，并且无法被规约。所以 `(Y f)` 并没有产生不动点函数
* 为了避免无限规约的情况，我们将 Y 中所有的 M 表达式通过 `逆η转换` 转换成 (λX.M X) 函数。（函数是 values 集合中的元素）
* 这种 `逆η转换` 使用 value 替换掉了无限规约的表达式
λf.(λx.f (x x)) (λx.f (x x))

(λf.
  (λg.((λx.f (x x))
       (λx.f (x x))) g))

λg.f (g g) 逆转换: f 输入参数 (g g) 转化为 value
得 λg.(f (λx.((g g) x)))
替换得:
Yv =  (λf.
        (λx.
          ((λg.(f (λx.((g g) x))))
           (λg.(f (λx.((g g) x)))) x)))

##### 定理5.1 Yv 不动点定理
If K = λgx.L, then (K (Yv K)) =v (Yv K).

证明:
Yv K  =   ((λf.(λx.((λg.(f (λx.((g g) x)))) (λg.(f (λx.((g g) x)))) x))) K)
      ->v λx.((λg.(K (λx.((g g) x)))) (λg.(K (λx.((g g) x)))) x)
      ->v λx.((K (λx.(((λg.(K (λx.((g g) x)))) (λg.(K (λx.((g g) x))))) x))) x)
      ->v λx.(((λgx.L) (λx.(((λg.((λgx.L) (λx.((g g) x)))) (λg.((λgx.L) (λx.((g g) x))))) x))) x)
      ->v λx.(λx.L | g <- [(λx.(((λg.((λgx.L) (λx.((g g) x)))) (λg.((λgx.L) (λx.((g g) x))))) x))]) x)
      ->v λx.L | g <- [(λx.(((λg.((λgx.L) (λx.((g g) x)))) (λg.((λgx.L) (λx.((g g) x))))) x))]
      v<- ((λgx.L) (λx.(((λg.((λgx.L) (λx.((g g) x)))) (λg.((λgx.L) (λx.((g g) x))))) x)))
      =   (K (λx.(((λg.(K (λx.((g g) x)))) (λg.(K (λx.((g g) x))))) x)))
      v<- (K (Yv K ))
证明过程非常复杂，是因为所有过程参数都被转换成 values ，才能进行 βv 规约
但是结果我们得到
Yv k  =  λx.((λg.(K (λx.((g g) x)))) (λg.(K (λx.((g g) x)))) x)
      =  λx.((K (Yv K)) x)
      =  λx.((λgx.L) (Yv K)) x)

##### 定理5.2 If M =v V , then for all (λX.N), ((λX.N) M) =v N[X ← M].
如果 M 可以等价转换成 V，那么 M 可以当做 value 来使用，直接用 M 进行规约
结构归纳法证明，过程略


#### 5.4 Evaluation
对于定义一个求值器，作为 values 形式存在的函数在 ISWIM 和 LC 中有着一样多的问题。
比如表达式:
  (λx.x) (λy.(λx.x) ⌈0⌉)
等价于:
  (λy.(λx.x) ⌈0⌉)
也等价于:
  (λy.⌈0⌉)
该选择哪个作为求值器的结果呢？这些结果都可以代表同一个函数，并且还有无数中表示方法来表达一个函数
我们采取一种本质上大多数实际的编程语言的一种实现：当程序规约一个函数 value 时，evalv 函数仅仅返回一个 token 表示这个 value 是一个函数。

```
evalv(M) = b         if M =v b
         = function  if M =v λX.N
```
如果 evalv(M) 不存在，我们说 M 是发散的。
比如: Ω ≐ ((λx.x x) (λx.x x))