const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

let a = getRandomInt(10000)
let b = getRandomInt(10000)
let c = getRandomInt(10000)

var messages = [
  { id: a, senderId: 1, message: 'Hello, how are you?' },
  { id: b, senderId: 2, message: 'Fine, you?' },
  { id: c, senderId: 1, message: 'Thanks for asking!' }
];

// Middleware to parse JSON requests
app.use(bodyParser.json());

app.get('/messages', (req, res) => {
  res.json(messages);
});

app.post('/send-message', (req, res) => {
  const userID = req.body.senderId;
  const message = req.body.message;

  if (message && userID) {
    const newMessageObject = { id: getRandomInt(10000), senderId: userID, message: message}
    messages.push(newMessageObject);

    res.json({ success: true, message: 'Item added successfully' });
  } else {
    res.status(400).json({ success: false, message: 'Invalid request' });
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});