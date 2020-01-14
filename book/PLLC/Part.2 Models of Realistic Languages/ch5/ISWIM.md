### ISWIM
Church 将 lambda演算 发展为一种学习数学运算的方式，与机械式的运算方式一起成为两种相反的思路。
1960 年代，Landin 证明 Chruch 的lambda演算对于大部分程序语言来说，并不是一个合适的模型。
比如: (λx.1) (sub1 λy.y)
* 这个表达式可以被规约为 1，即使很多语言会对 (sub1 λy.y) 产生抱怨
* 这个问题不是关于 sub1 和 λy.y 的编码，而是在表达式中进行 β规约 时，可以完全忽略所有的参数

这种 [call-by-name](https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_name) 的行为是否令人满意是存在争议的。

备注:
* call-by-name: 函数体中使用参数表达式时，再求值，多次使用多次求值
* call-by-value: 传入的参数表达式提前求值，将结果值绑定至函数中相应变量，通常是将结果value拷贝一份存储起来