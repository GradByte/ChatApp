const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

var counter = 0;
var messages = [];
var users = {
  1: 'pass1',
  2: 'pass2'
};

function createNewMessage(messages, userID, text) {
  const newMessageObject = { id: counter, senderId: userID, message: text}
  messages.push(newMessageObject);
  counter += 1
}

// Middleware to parse JSON requests
app.use(bodyParser.json());

app.get('/messages', (req, res) => {
  res.json(messages);
});

app.post('/send-message', (req, res) => {
  const userId = req.body.senderId;
  const text = req.body.message;

  if (text && userId) {
    createNewMessage(messages, userId, text);
    console.log('GEGEGGEGE')
    res.json({ success: true, message: 'Item added successfully' });
  } else {
    res.status(400).json({ success: false, message: 'Invalid request' });
  }
});

app.post('/sign-in', (req, res) => {
  const userId = req.body.userId;
  const password = req.body.password;
  console.log(req.body);
  console.log(`UserID: ${userId}`);
  console.log(`Password: ${password}`);
  console.log(`C: ${users[userId]}`);
  
  if (userId && password) {
    if (userId in users) {
      if (password === users[userId]){
        res.json({ success: true, message: 'Right Credentials' });
        console.log('FINALLY')
      }
    }
  } else {
    res.status(400).json({ success: false, message: 'Invalid Credentials' });
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});