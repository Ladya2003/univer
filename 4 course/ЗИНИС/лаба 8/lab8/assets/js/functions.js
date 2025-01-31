export function NOD(a, b) {
  let x, y;
  let _a, _b, prevB;
  
  _a = a > b ? a : b;
  _b = a > b ? b : a;
  
  do {
    x = Math.floor(_a / _b);
    y = _a - x * _b;
    
    _a = _b;
    prevB = _b;
    _b = y;
  } while (y !== 0);
  
  return prevB;
}

export function isOdd(n) {
  return n % 2 !== 0;
}

export function isEven(n) {
  return n % 2 === 0;
}

export function numberToBinary(n) {
  return n.toString(2).padStart(8, '0');
}