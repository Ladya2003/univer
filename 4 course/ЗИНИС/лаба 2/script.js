// Белорусский алфавит (исправленный)
const alphabet = "абвгдеёжзійклмнопрстуўфхцчшьыэюя";
const n = alphabet.length;
const keyWord = "вакуленчык";

// Функция для подсчета частоты символов
function countFrequency(text) {
    const frequency = {};

    // Инициализируем частоту для каждой буквы алфавита нулями
    for (let i = 0; i < n; i++) {
        frequency[alphabet[i]] = 0;
    }

    // Считаем частоту букв в тексте
    for (let char of text) {
        if (alphabet.includes(char)) {
            frequency[char]++;
        }
    }

    return frequency;
}

// Функция для рисования гистограммы
function drawFrequencyChart(frequency, title) {
    const ctx = document.getElementById('frequencyChart').getContext('2d');

    // Данные для гистограммы
    const labels = Object.keys(frequency);
    const data = Object.values(frequency);

    // Если график уже существует, его нужно обновить
    if (window.myChart) {
        window.myChart.destroy();
    }

    window.myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: title,
                data: data,
                backgroundColor: 'rgba(75, 192, 192, 0.6)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Шифр Цезаря
function caesarEncrypt() {
    const text = document.getElementById("inputText").value.toLowerCase();
    const encryptedText = text.split('').map(char => {
        const index = alphabet.indexOf(char);
        if (index === -1) return char;
        return alphabet[(index + 5) % n];
    }).join('');
    document.getElementById("outputText").value = encryptedText;

    // Подсчет частоты символов для исходного текста
    const originalFrequency = countFrequency(text);
    drawFrequencyChart(originalFrequency, 'Частота символов исходного текста');

    // Подсчет частоты символов для зашифрованного текста
    const encryptedFrequency = countFrequency(encryptedText);
    setTimeout(() => drawFrequencyChart(encryptedFrequency, 'Частота символов зашифрованного текста'), 2000); // Ожидание 2 секунды перед перерисовкой
}

function caesarDecrypt() {
    const text = document.getElementById("inputText").value.toLowerCase();
    const decryptedText = text.split('').map(char => {
        const index = alphabet.indexOf(char);
        if (index === -1) return char;
        return alphabet[(index - 5 + n) % n];
    }).join('');
    document.getElementById("outputText").value = decryptedText;

    // Подсчет частоты символов для исходного текста
    const originalFrequency = countFrequency(text);
    drawFrequencyChart(originalFrequency, 'Частота символов исходного текста');

    // Подсчет частоты символов для расшифрованного текста
    const decryptedFrequency = countFrequency(decryptedText);
    setTimeout(() => drawFrequencyChart(decryptedFrequency, 'Частота символов расшифрованного текста'), 2000); // Ожидание 2 секунды перед перерисовкой
}

// Шифр Виженера
function vigenereEncrypt() {
    const text = document.getElementById("inputText").value.toLowerCase();
    let encryptedText = '';
    let keyIndex = 0;

    for (let i = 0; i < text.length; i++) {
        const char = text[i];
        const index = alphabet.indexOf(char);

        if (index === -1) {
            encryptedText += char;
        } else {
            const keyChar = keyWord[keyIndex % keyWord.length];
            const keyCharIndex = alphabet.indexOf(keyChar);
            const newIndex = (index + keyCharIndex) % n;
            encryptedText += alphabet[newIndex];
            keyIndex++;
        }
    }
    document.getElementById("outputText").value = encryptedText;

    // Подсчет частоты символов для исходного текста
    const originalFrequency = countFrequency(text);
    drawFrequencyChart(originalFrequency, 'Частота символов исходного текста');

    // Подсчет частоты символов для зашифрованного текста
    const encryptedFrequency = countFrequency(encryptedText);
    setTimeout(() => drawFrequencyChart(encryptedFrequency, 'Частота символов зашифрованного текста'), 2000); // Ожидание 2 секунды перед перерисовкой
}

function vigenereDecrypt() {
    const text = document.getElementById("inputText").value.toLowerCase();
    let decryptedText = '';
    let keyIndex = 0;

    for (let i = 0; i < text.length; i++) {
        const char = text[i];
        const index = alphabet.indexOf(char);

        if (index === -1) {
            decryptedText += char;
        } else {
            const keyChar = keyWord[keyIndex % keyWord.length];
            const keyCharIndex = alphabet.indexOf(keyChar);
            const newIndex = (index - keyCharIndex + n) % n;
            decryptedText += alphabet[newIndex];
            keyIndex++;
        }
    }
    document.getElementById("outputText").value = decryptedText;

    // Подсчет частоты символов для исходного текста
    const originalFrequency = countFrequency(text);
    drawFrequencyChart(originalFrequency, 'Частота символов исходного текста');

    // Подсчет частоты символов для расшифрованного текста
    const decryptedFrequency = countFrequency(decryptedText);
    setTimeout(() => drawFrequencyChart(decryptedFrequency, 'Частота символов расшифрованного текста'), 2000); // Ожидание 2 секунды перед перерисовкой
}
