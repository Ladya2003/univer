// RC4 Encryption function
function RC4(key, text) {
    const s = [];
    const keyLength = key.length;
    let j = 0;
    let result = [];

    // Initialize state array s[0 ... 255]
    for (let i = 0; i < 256; i++) {
        s[i] = i;
    }

    // Key-scheduling algorithm (KSA)
    for (let i = 0; i < 256; i++) {
        j = (j + s[i] + key[i % keyLength]) % 256;
        [s[i], s[j]] = [s[j], s[i]];  // Swap s[i] and s[j]
    }

    // Pseudo-random generation algorithm (PRGA)
    let i = 0;
    j = 0;
    for (let k = 0; k < text.length; k++) {
        i = (i + 1) % 256;
        j = (j + s[i]) % 256;
        [s[i], s[j]] = [s[j], s[i]];  // Swap s[i] and s[j]
        const t = (s[i] + s[j]) % 256;
        result.push(text[k] ^ s[t]);  // XOR the plaintext with the generated keystream
    }

    return result;
}

// Convert string to byte array
function stringToBytes(str) {
    const bytes = [];
    for (let i = 0; i < str.length; i++) {
        bytes.push(str.charCodeAt(i));
    }
    return bytes;
}

// Convert byte array to hex string
function bytesToHex(bytes) {
    return bytes.map(byte => byte.toString(16).padStart(2, '0')).join('');
}

// Handle encryption and time measurement
document.getElementById('encrypt').addEventListener('click', function () {
    const inputText = document.getElementById('inputText').value;
    const key = [121, 14, 89, 15];  // Fixed key as decimal numbers
    const textBytes = stringToBytes(inputText);

    const startTime = performance.now();  // Start time measurement

    const encryptedBytes = RC4(key, textBytes);

    const endTime = performance.now();  // End time measurement

    document.getElementById('outputText').value = bytesToHex(encryptedBytes);  // Display result in hex
    document.getElementById('timeTaken').value = (endTime - startTime).toFixed(2);  // Display time in ms
});
