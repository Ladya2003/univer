import {isEven, NOD} from "./functions.js";

export class BBS {
  constructor({ n, p, q, start } = {}) {
    this.start = start || 1;
    if(n) {
      this.n = n;
      this.gen = this.generate();
      return;
    }
    
    if(p % 4 !== 3 || q % 4 !== 3) throw new Error('p and q must be prime numbers and p % 4 === 3 and q % 4 === 3');
    
    this.q = q;
    this.p = p;
    
    this.n = this.q * this.p;
    this.gen = this.generate();
  }
  
  *generate() {
    let x = this.#chooseFirst();
    
    while(true) {
      x = x ** 2 % this.n;
      yield x;
    }
  }
  
  generateSequence(length) {
    let res = '';
    let value;
    
    for(let i = 0; i < length; i++) {
      value = this.gen.next().value;
      res += isEven(value) ? '0' : '1';
    }
    
    return res;
  }
  
  #chooseFirst() {
    let res = 1;
    
    for(let i = 2, j = 0; i <= this.n; i++) {
      if(NOD(i, this.n) !== 1) continue;
      res = i;
      if(++j === this.start) break;
    }
    
    return res;
  }
}