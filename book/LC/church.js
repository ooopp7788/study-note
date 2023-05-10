
const ZERO = f => x => x;
const ONE = f => x => f(x);
// ...

const ADD1 = n => f => x => f(n(f)(x))
const ADD = n => m => f => x => m(f)(n(f)(x))
// ...

const TRUE = x => y => x;
const FALSE = x => y => y;

// const AND = a => b => x => y => b(a(x)(y))(y)
// const OR = a => b => x => y => b(x)(a(x)(y))



