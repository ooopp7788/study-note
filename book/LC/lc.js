// church 计数: 用过程表示数
console.log('====== number ======');
ZERO = f => x => x;
ONE  = f => x => f(x);
TWO  = f => x => f(f(x));
THREE  = f => x => f(f(f(x)));
FOUR  = f => x => f(f(f(f(x))));
// ...
// 辅助函数
const toNumber = n => n(x => x + 1)(0);
console.log(toNumber(ZERO), toNumber(ONE), toNumber(TWO), toNumber(THREE));

INCREMENT = n => f => x => f(n(f)(x));
console.log(toNumber(INCREMENT(ZERO)))

// Q1: 如何定义 ADD , MULTIPLY ?
// ADD = n => m => f => x => ...
// MULTIPLY = n => m => f => x => ...
ADD = n => m => n(INCREMENT)(m);
console.log(toNumber(ADD(THREE)(FOUR)));
MULTIPLY = n => m => n(ADD(m))(ZERO);
console.log(toNumber(MULTIPLY(THREE)(FOUR)));

// boolean
console.log('====== boolean ======');
TRUE = x => y => x;
FALSE = x => y => y;
const toBoolean = b => b(true)(false);
console.log(toBoolean(TRUE), toBoolean(FALSE));
BoolAnd = a => b => x => y => b(a(x)(y))(y);
console.log(toBoolean(BoolAnd(TRUE)(FALSE)), toBoolean(BoolAnd(TRUE)(TRUE)));
BoolOr = a => b => x => y => b(x)(a(x)(y));
console.log(toBoolean(BoolOr(TRUE)(FALSE)), toBoolean(BoolOr(TRUE)(TRUE)));
BoolNot = a => x => y => a(y)(x);
console.log(toBoolean(BoolNot(TRUE)), toBoolean(BoolNot(FALSE)));

// IF = a => x => y => ...
IF = a => x => y => a(x)(y)
console.log(IF(TRUE)('good')('bad'), IF(FALSE)('good')('bad'))

// 谓词
IS_ZERO = n => n(x => FALSE)(TRUE);
console.log(toBoolean(IS_ZERO(ZERO)), toBoolean(IS_ZERO(ONE)), toBoolean(IS_ZERO(TWO)));

// IS_ONE = n => n(x => FALSE)(TRUE);
// console.log(toBoolean(IS_ONE(TWO)), toBoolean(IS_ONE(ONE)));

// PAIR
console.log('====== pair ======');
PAIR = x => y => f => f(x)(y);
LEFT = p => p(x => y => x);
RIGHT = p => p(x => y => y);
console.log(toNumber(LEFT(PAIR(ONE)(THREE))));
console.log(toNumber(RIGHT(PAIR(ONE)(THREE))));

// DECREMENT
console.log('====== DECREMENT ======');
SLIDE = p => PAIR(RIGHT(p))(INCREMENT(RIGHT(p)));
DECREMENT = n => LEFT(n(SLIDE)(PAIR(ZERO)(ZERO)));
SUBTRACT = n => m => m(DECREMENT)(n);
IS_LESS_OR_EQUAL = n => m => IF(IS_ZERO(SUBTRACT(n)(m)));
console.log(toNumber(DECREMENT(TWO)));
console.log(toNumber(SUBTRACT(THREE)(ONE)));
console.log(toBoolean(IS_LESS_OR_EQUAL(ONE)(THREE)));

// 迭代：Y 组合子
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

// LIST PAIR  实现
console.log('====== list ======');
EMPTY = PAIR(TRUE)(TRUE);
UNSHIFT = l => e => PAIR(FALSE)(PAIR(e)(l));
IS_EMPTY = LEFT;
FIRST = l => LEFT(RIGHT(l));
REST = l => RIGHT(RIGHT(l));
my_list = UNSHIFT(
    UNSHIFT(
        UNSHIFT(
            UNSHIFT(EMPTY)(THREE)
        )(TWO)
    )(ONE)
)(ZERO);

console.log(toNumber(FIRST(my_list)));
console.log(toNumber(FIRST(REST(my_list))));
const toArray = l => {
    const arr = [];
    if (toBoolean(IS_EMPTY(l))) {
        return arr;
    }
    return [FIRST(l), ...toArray(REST(l))];
}
console.log(toArray(my_list).map(i => toNumber(i)))
const FACT = Y(
    f => n => IF(IS_ZERO(n))(ONE)(x => MULTIPLY(n)(f(DECREMENT(n)))(x));
);
console.log(toNumber(FACT(FOUR)));


