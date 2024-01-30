var express = require('express');
const bodyParser = require('body-parser');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io')(server);
// Middleware to parse JSON requests
app.use(bodyParser.json());
connections = [];
server.listen(process.env.PORT || 3000);
console.log('Server is running....');

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
  const newMessageObject = {id: counter, senderId: senderId, receiverId: receiverId, message: text};
  if (receiverId in chats[senderId]) {
    chats[senderId][receiverId].push(newMessageObject);
    chats[receiverId][senderId].push(newMessageObject);
  }
  counter += 1
}

function createNewMessageSocket(senderId, receiverId, text) {
    const newMessageObject = {id: counter, senderId: senderId, receiverId: receiverId, message: text};
    if (receiverId in chats[senderId]) {
        chats[senderId][receiverId].push(newMessageObject);
        chats[receiverId][senderId].push(newMessageObject);
 
        io.sockets.emit(`${senderId}-getMessage`, {id: counter, senderId: senderId, receiverId: receiverId, message: text});
        io.sockets.emit(`${receiverId}-getMessage`, {id: counter, senderId: senderId, receiverId: receiverId, message: text});
 
    }
    counter += 1
  }



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
          // sender updates his/her chats with this json
          res.json(keys);
          // receiver will get the new chat through its socket
          io.sockets.emit(`${receiverId}-getChats`, {chat: senderId});
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



io.sockets.on('connection', function(socket){
    connections.push(socket);
    console.log('Connect: %s sockets are connected', connections.length);

    //Disconnection happens
    socket.on('disconnect', function(data) {
        connections.splice(connections.indexOf(socket), 1);
        console.log('Disconnect: %s sockets are connected', connections.length);
    });

    /**
    socket.on('NodeJS Server Port', function(data) {
        //'data' will have the info/data that comes from SwiftUI
        console.log(data);
        const interval = setInterval(function() {
            io.sockets.emit('iOS Client Port', {msg: 'Hi iOS Client!'});
          }, 5000);
        
    });
    */

    socket.on('SendMessage-Server', function(data) {
        const senderId = data['senderId'];
        const receiverId = data['receiverId'];
        const message = data['message'];
        console.log(senderId);
        console.log(receiverId);
        console.log(message);
    
        if (senderId && receiverId && message) {
            createNewMessageSocket(senderId, receiverId, message);
        }

    });


});