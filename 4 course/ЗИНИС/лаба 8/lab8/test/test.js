import {RC4} from "../assets/js/index.js";

const keys = [8, 92, 40, 93, 7];
const text = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut';

for(let n = 1; n <= 29; n++) {
  test(n, keys, text);
}

function test(n, keys, text) {
  const rc4 = new RC4(n, keys);
  
  console.time(`RC4 Encrypt | n = ${n}`);
  rc4.encrypt(text);
  console.timeEnd(`RC4 Encrypt | n = ${n}`);
}