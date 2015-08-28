var express = require('express');
var app = express();
app.use(express.static(__dirname));
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    setTimeout(function() {
      io.emit('chat message', 'You don\'t say! Is it true that: ' + msg);
    }, 2000);
  });
});


http.listen(3000, function(){
  console.log('listening on *:3000');
});
