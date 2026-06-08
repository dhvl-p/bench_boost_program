function countPrimes(max) {
  let count = 0;
  for (let i = 2; i <= max; i++) {
    let isPrime = true;
    for (let j = 2; j * j <= i; j++) {
      if (i % j === 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) count++;
  }
  return count;
}

self.onmessage = function (e) {
  const max = e.data;
  const count = countPrimes(max);
  self.postMessage(count);
};
