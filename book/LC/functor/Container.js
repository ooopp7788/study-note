
class Container {
    value: null;
    of(value) {
        this.value = value;
    }
    map(f) {
        return Container.of(f(this.value));
    }
}

const fmap = f => c => c.of(c.map(f));
