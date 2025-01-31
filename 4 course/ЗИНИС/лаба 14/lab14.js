const StegCloak = require('stegcloak');
const SpaceCrypt = require('spacecrypt');
const fs = require('fs');

const message = 'Voldemort is back';
const text = "The WiFi's not working here!";
const password = 'mischief managed';

const stegcloak = new StegCloak(true, false);
let encodedMessage = stegcloak.hide(message, password, text);

fs.writeFileSync('output.docx', encodedMessage);

let decodedMessage = stegcloak.reveal(encodedMessage, password);

console.log(decodedMessage);

encodedMessage = SpaceCrypt.encrypt(text, message);

fs.writeFileSync('output1.docx', encodedMessage);

decodedMessage = SpaceCrypt.decrypt(encodedMessage);

console.log(decodedMessage); 