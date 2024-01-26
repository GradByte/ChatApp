const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

var counter = 0;
var messages = [];
var users = {
  '1': 'pass1',
  '2': 'pass2'
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
    res.json({ success: true, message: 'Item added successfully' });
  } else {
    res.status(400).json({ success: false, message: 'Invalid request' });
  }
});

app.post('/sign-in', (req, res) => {
  const userId = req.body.userId;
  const password = req.body.password;
  
  if (userId && password) {
    if (userId in users) {
      if (password === users[userId]){
        res.json({ success: true, message: 'Right Credentials' });
      } else {
        res.status(400).json({ success: false, message: 'Wrong password!' });
      }
    } else {
      res.status(400).json({ success: false, message: 'UserId is not created!' });
    }
  } else {
    res.status(400).json({ success: false, message: 'Something missing!' });
  }
});

app.post('/sign-up', (req, res) => {
  const userId = req.body.userId;
  const password = req.body.password;
  
  if (userId && password) {
    if (!(userId in users)) {
      users[userId] = password
      res.json({ success: true, message: 'You have account now!' });
      console.log(users)
    } else {
      res.status(400).json({ success: false, message: 'UserID is taken.' });
    }
  } else {
    res.status(400).json({ success: false, message: 'There was a problem.' });
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});