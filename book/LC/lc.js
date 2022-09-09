// church 计数: 用过程表示数
ZERO = f => x => x;
ONE  = f => x => f(x);
TWO  = f => x => f(f(x));
THREE  = f => x => f(f(f(x)));
// ...
add1 = n => f => x => f(n(f)(x));

add1(ZERO)
f => x => f(ZERO(f)(x))
 -> ZERO(f)(x) -> (f => x => x)(f)(x) -> (x => x)(x) => x
f => x => f(x);

// Q1: 如何定义 add ?


// boolean
TRUE = x => y => x;
FALSE = x => y => y;

BoolAnd = a => b => ?

// ;; BoolAnd
// (define (BoolAnd a b)
//   (a b FALSE))
// ;; BoolOr
// ;; let BoolOr = lambda x y. x TRUE y 
// (define (BoolOr a b)
//   (a FALSE b))
// ;; BoolNot
// ;; let BoolNot = lambda x . x FALSE TRUE
// (define (BoolNot a)
//   (a FALSE TRUE))


// // true ≐ λx.λy.x
// x => y => x;
// // false ≐ λx.λy.y
// x => y => y;


