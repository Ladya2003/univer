const NodeRSA = require('node-rsa');
const ElGamal = require('elgamal').default;
const crypto = require('crypto');
const Buffer = require('safe-buffer').Buffer; 
const schnorr = require('bip-schnorr');


const hash = crypto.createHash('sha256');
hash.update("Hello!");
let message = hash.digest('hex');

const key = new NodeRSA({b: 512});
 
let start = Date.now();
let encrypted = key.encrypt(message, 'base64');
let end = Date.now();

console.log(`Создание подписи RSA: ${encrypted}(время: ${end - start}мс)`);

start = Date.now();
let decrypted = key.decrypt(encrypted, 'utf8');
end = Date.now();

if (message === decrypted) 
    console.log(`Проверка подписи RSA: ${decrypted}(время: ${end - start}мс)`);

(async () => {
    const eg = await ElGamal.generateAsync();

    start = Date.now();
    encrypted = await eg.encryptAsync(message);
    end = Date.now();
    console.log('Создание подписи Эль-Гамаля:');
    console.log(encrypted)
    console.log(`(время: ${end - start}мс)`);

    start = Date.now();
    decrypted = await eg.decryptAsync(encrypted);
    end = Date.now();
    
    if (message === decrypted.toString()) 
        console.log(`Проверка подписи Эль-Гамаля: ${decrypted.toString()}(время: ${end - start}мс)`);
})().then(() => {

    const privateKeyHex = 'B7E151628AED2A6ABF7158809CF4F3C762E7160F38B4DA56A784D9045190CFEF';
    message = Buffer.from(message, 'hex');
    
    start = Date.now();
    encrypted = schnorr.sign(privateKeyHex, message);
    end = Date.now();
    
    console.log(`Создание подписи Шнорра: ${encrypted.toString('hex')}(время: ${end - start}мс)`);
    
    const publicKey = Buffer.from('DFF1D77F2A671C5F36183726DB2341BE58FEAE1DA2DECED843240F7B502BA659', 'hex');
    try {
      schnorr.verify(publicKey, message, encrypted);
      // console.log(`Проверка подписи Шнорра: ${message.toString()}(время: ${end - start}мс)`);
    } catch (e) {
      console.error('The signature verification failed: ' + e);
    }
    
})
