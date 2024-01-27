const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// message id counter
var counter = 0;

// first key represents the userId, value is the chats that user have with other users.
var chats = {
  'john': {
    'paul': [],
    'david': []
  },
  'paul': {
    'john': []
  },
  'david': {
    'john': []
  },
  'angel': {

  }
};

// keys are usedId, values are password.
var users = {
  'john': '123',
  'paul': '123',
  'david': '123',
  'angel': '123'
};

function createNewMessage(senderId, receiverId, text) {
  const newMessageObject = { id: counter, senderId: senderId, receiverId: receiverId, message: text};
  if (receiverId in chats[senderId]) {
    chats[senderId][receiverId].push(newMessageObject);
    chats[receiverId][senderId].push(newMessageObject);
  }
  counter += 1
}

// Middleware to parse JSON requests
app.use(bodyParser.json());





// SIGN OPERATIONS
app.post('/sign-up', (req, res) => {
  const userId = req.body.userId;
  const password = req.body.password;
  
  if (userId && password) {
    if (!(userId in users)) {
      // user is added with password.
      users[userId] = password;

      // chats are available now.
      chats[userId] = {};
      
      res.json({ success: true, message: 'You have account now!' });
      console.log(users);
    } else {
      res.status(400).json({ success: false, message: 'UserID is taken.' });
    }
  } else {
    res.status(400).json({ success: false, message: 'There was a problem.' });
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







// CHATS
app.post('/get-chats', (req, res) => {
  const senderId = req.body.senderId;
  
  if (senderId) {
    // inside keys, you can find the receiverIds
    // of already created chats for this senderId
    const keys = Object.keys(chats[senderId]);
    res.json(keys);
  }

});

app.post('/add-chat', (req, res) => {
  const senderId = req.body.senderId;
  const receiverId = req.body.receiverId;
  
  if (senderId && receiverId) {
    if (receiverId in users) {
      if (!(receiverId in chats[senderId])) {
        chats[senderId][receiverId] = []
        chats[receiverId][senderId] = []
        // inside keys, you can find the receiverIds
        // of already created chats for this senderId
        const keys = Object.keys(chats[senderId]);
        res.json(keys);
      }
    }
  }
});





// MESSAGES
app.post('/get-messages', (req, res) => {
  const senderId = req.body.senderId;
  const receiverId = req.body.receiverId;

  if (senderId && receiverId) {
    res.json(chats[senderId][receiverId]);
  }

});

app.post('/send-message', (req, res) => {
  const senderId = req.body.senderId;
  const receiverId = req.body.receiverId;
  const message = req.body.message;

  if (senderId && receiverId && message) {
    createNewMessage(senderId, receiverId, message);
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});