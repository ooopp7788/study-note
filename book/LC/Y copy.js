const fact1 = n => {
    if (n === 0) return 1
    return fact1(n - 1) * n
}

const fact2 = (n, self)=> {
    if (n === 0) return 1
    return self(n - 1, self) * n
}

// console.log(fact2(5, fact2));

const fact3 = self => {
    return n => {
        if (n === 0) return 1
        return self(self)(n - 1) * n
    }
}

// console.log(fact3(fact3)(5));
// fact 业务逻辑
const g = q => {
    return n => {
        if (n === 0) return 1
        return q(n - 1) * n
    }
}

const fact4 = self  => {
    return n => {
        return g(self(self))(n);
    }
}

// console.log(fact4(fact4)(5));

const q = self => {
    return self(self);
}
const Y = g => {
    return q(self  => {
        return n => {
            return g(self(self))(n);
        }
    })
}

const fact = Y(g)

console.log(fact(5));
