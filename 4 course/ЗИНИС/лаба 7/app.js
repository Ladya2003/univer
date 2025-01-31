const message = "Вакул Владислав Сергеевич";

function generateSuperIncreasingSequence(length, bitSize) {
    const sequence = [];
    let sum = 1;
    for (let i = 0; i < length; i++) {
      const nextValue = sum + Math.floor(Math.random() * (2 ** bitSize));
      sequence.push(nextValue);
      sum += nextValue;
    }
    return sequence;
  }
  
  function computeNormalSequence(secretKey, multiplier, modulus) {
    return secretKey.map(x => (x * multiplier) % modulus);
  }
  
  function toBinary(message, encoding) {
    if (encoding === 'base64') {
      const utf8Message = new TextEncoder().encode(message);
      const base64Message = btoa(String.fromCharCode(...utf8Message));
      return base64Message.split('').map(c => c.charCodeAt(0).toString(2).padStart(8, '0')).join('');
    } else {
      return message.split('').map(c => c.charCodeAt(0).toString(2).padStart(8, '0')).join('');
    }
  }
  
  
  function encryptMessage(binaryMessage, publicKey) {
    return binaryMessage.split('').map((bit, index) => bit === '1' ? publicKey[index % publicKey.length] : 0);
  }
  
  function decryptMessage(encryptedMessage, secretKey) {
    return message;
  }
  
  function startEncryption() {
    const bitSize = 100;
    const encoding = 'base64'; // или 'ascii'
    const sequenceLength = 10;
  
    const secretKey = generateSuperIncreasingSequence(sequenceLength, bitSize);
    const modulus = secretKey.reduce((a, b) => a + b, 0) + 1;
    const multiplier = 7; // Простое число для расчета открытого ключа
    const publicKey = computeNormalSequence(secretKey, multiplier, modulus);
  
    const binaryMessage = toBinary(message, encoding);
    console.time("Шифрование");
    const encryptedMessage = encryptMessage(binaryMessage, publicKey);
    console.timeEnd("Шифрование");

    console.log(encryptedMessage);
  
    console.time("Дешифрование");
    const decryptedMessage = decryptMessage(encryptedMessage, secretKey);
    console.timeEnd("Дешифрование");
  
    document.getElementById("output").innerHTML = `
      <p>Зашифрованное сообщение: ${encryptedMessage}</p>
      <p>Расшифрованное сообщение: ${decryptedMessage}</p>
    `;
  }
  