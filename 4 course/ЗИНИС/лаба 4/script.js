const rotorI = "EKMFLGDQVZNTOWYHXUSPAIBRCJ".split('');
const rotorII = "AJDKSIRUXBLHWTMCQGZNPYFVOE".split('');
const rotorIII = "BDFHJLCPRTXVZNYEIWGAKMUSQO".split('');

const reflectorB = {
  A: 'Y', B: 'R', C: 'U', D: 'H', E: 'Q', F: 'S', G: 'L', H: 'D',
  I: 'P', J: 'X', K: 'N', L: 'G', M: 'O', N: 'K', O: 'M', P: 'I',
  Q: 'E', R: 'B', S: 'F', T: 'Z', U: 'C', V: 'W', W: 'V', X: 'J',
  Y: 'A', Z: 'T'
};

let rotorPosI = 0;
let rotorPosII = 2;
let rotorPosIII = 2;

function rotateRotors() {
  rotorPosI = (rotorPosI + 1) % 26;
  if (rotorPosI === 0) {
    rotorPosII = (rotorPosII + 1) % 26;
    if (rotorPosII === 0) {
      rotorPosIII = (rotorPosIII + 1) % 26;
    }
  }
}

function encryptCharacter(char) {
  rotateRotors();
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  let index = alphabet.indexOf(char);

  index = alphabet.indexOf(rotorI[(index + rotorPosI) % 26]);
  index = alphabet.indexOf(rotorII[(index + rotorPosII) % 26]);
  index = alphabet.indexOf(rotorIII[(index + rotorPosIII) % 26]);

  char = reflectorB[alphabet[index]];

  index = rotorIII.indexOf(char);
  index = rotorII.indexOf(alphabet[index]);
  index = rotorI.indexOf(alphabet[index]);

  return alphabet[index];
}

function encryptText(text) {
  return text.split('').map(char => encryptCharacter(char.toUpperCase())).join('');
}

function updateRotorPositions() {
  rotorPosI = parseInt(document.getElementById('rotor1-pos').value);
  rotorPosII = parseInt(document.getElementById('rotor2-pos').value);
  rotorPosIII = parseInt(document.getElementById('rotor3-pos').value);
}

document.getElementById('encrypt-button').addEventListener('click', () => {
  updateRotorPositions();
  const inputText = document.getElementById('input-text').value;
  const output = encryptText(inputText);
  document.getElementById('output').innerText = output;
});

document.getElementById('multi-encrypt-button').addEventListener('click', () => {
  const inputText = document.getElementById('input-text').value;
  let output = "";
  
  for (let i = 0; i < 5; i++) {
    rotorPosI = i;
    rotorPosII = (i + 1) % 26;
    rotorPosIII = (i + 2) % 26;
    
    output += `Variant ${i + 1}: ${encryptText(inputText)}\n`;
  }
  
  document.getElementById('output').innerText = output;
});
