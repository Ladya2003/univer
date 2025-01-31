export class RC4 {
  constructor(n, keys) {
    this.n = n;
    this.keys = keys;
  }
  
  encrypt(text) {
    return this
      .#initS()
      .#initK(text.length)
      .#xor(text);
  }
  
  decrypt(text) {
    return this.encrypt(text);
  }
  
  #initS() {
    let s = [];
    let i, j;
    let length = 2 ** this.n;
    
    for (i = 0; i < length - 1; i++) {
      s[i] = i;
    }
    
    j = 0;
    
    for (i = 0; i < length - 1; i++) {
      j = (j + s[i] + this.keys[i % this.keys.length]) % length;
      this.#swapS(s, i, j);
    }
    
    this.S = s;
    return this;
  }
  
  #initK(messageLength) {
    let
      i = 0,
      j = 0,
      t;
    
    let k = [];
    let s = this.S;
    
    for (let l = 0; l < messageLength; l++) {
      i = (i + 1) % s.length;
      j = (j + s[i]) % s.length;
      
      this.#swapS(s, i, j);
      
      t = (s[i] + s[j]) % s.length;
      k.push(s[t]);
    }
    
    this.K = k;
    return this;
  }
  
  #xor(text) {
    let k = this.K;
    let res = '';
    
    for (let i = 0; i < text.length; i++) {
      res += String.fromCharCode(text.charCodeAt(i) ^ k[i]);
    }
    
    return res;
  }
  
  #swapS(s, i, j) {
    [s[i], s[j]] = [s[j], s[i]];
  }
}

