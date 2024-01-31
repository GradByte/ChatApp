# ChatApp
ChatApp is a self-explanatory name. That's why I'm going to talk about how things are created in this project briefly instead of the usage of it.

In the beginning, I implemented everything with Express.js and to get or send some data, I used HTTP requests. This version can still be seen inside the ChatAppServer folder. The old version server's file name is "server.js". I had to send an HTTP request every 0.2 seconds to see if there was a new message or not. The same applied to getting chats too. But this wasn't the right way to implement things, especially in a chat application.

So, I wanted to use sockets to keep track of the new messages and chats. Through sockets, the server can easily send the new data to the targetted clients. However, the application still uses HTTP requests to get every chat and message when a chat or message view is shown (.onApper{} is used to achieve this.).

## Waiting to be Implemented
- Delete a chat and a message
- Users have profiles & can modify it
- MongoDB implementation to store data
- Testing

## Setup
To be able to use this application, you need to start the node server first. Follow these steps:

```
cd ChatApp/ChatAppServer
npm install
node socketServer.js

```

After this, you can start using the ChatApp. But be aware, there is no database in this project, so the messages or other information are not persistently stored. Please don't use this application to store something important.

## App Features
- Sign up/in/out
- Add new chats
- Send & Receive text messages

## Technologies
- SwiftUI - iOS 16.1
- Node.js
- Express.js
- Socket.IO
- https://github.com/socketio/socket.io-client-swift

## Screenshots
| ![Main Page](https://github.com/GradByte/ChatApp/blob/main/screenshots/Signin.png) | ![Add Travel](https://github.com/GradByte/ChatApp/blob/main/screenshots/Signin1.png) | ![Travel Details](https://github.com/GradByte/ChatApp/blob/main/screenshots/Signin2.png) | ![Edit Travel](https://github.com/GradByte/ChatApp/blob/main/screenshots/Signup.png) |
| --- | --- | --- | --- |
| Sign In | Sign In Alert | Sign In Alert | Sign Up |

| ![Main Page](https://github.com/GradByte/ChatApp/blob/main/screenshots/Signup1.png) | ![Add Travel](https://github.com/GradByte/ChatApp/blob/main/screenshots/Chat.png) | ![Travel Details](https://github.com/GradByte/ChatApp/blob/main/screenshots/AddChat.png) | ![Edit Travel](https://github.com/GradByte/ChatApp/blob/main/screenshots/Message.png) |
| --- | --- | --- | --- |
| Sign Up Alert | Chats | Add Chat | Messages |