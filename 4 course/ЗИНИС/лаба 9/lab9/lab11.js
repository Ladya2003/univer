const crypto = require('crypto');

var hash = crypto.createHash('sha256');
let start = Date.now();
hash.update('foo');
let end = Date.now();


console.log(`Хеширование SHA256: ${hash.digest('hex')}(время: ${end - start}мс)`);
