const { Document, Paragraph, TextRun, Packer } = require('docx');
const fs = require('fs');

const doc = new Document({
    sections: [
        {
            properties: {},
            children: [
                new Paragraph({
                    children: [
                        new TextRun("Hello World"),
                        new TextRun({
                            text: "\tFoo Bar",
                            bold: true,
                        }),
                        new TextRun({
                            text: "\nGithub is the best",
                            bold: true,
                        }),
                    ],
                }),
            ],
        },
    ],
});

Packer.toBuffer(doc).then(buffer => {
    fs.writeFileSync('test.docx', buffer);
})
