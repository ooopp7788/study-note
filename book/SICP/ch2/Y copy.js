power = (n) => {
  if (n === 0) return 0
  return power(n - 1);
}
// v1
(n) => {
  if (n === 0) return 0
  return self(n - 1);
}
// v2
P = (self, n) => {
  if (n === 0) return 0
  return n * self(self, n - 1);
}
P(P, 2);
// v3
P = (self, n) => {
  if (n === 0) return 0
  return n * self(n - 1);
}
P(power, n);

P(power) = power