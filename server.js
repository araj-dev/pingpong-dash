//
// # SimpleServer
//
// A pingpong-like application server using Socket.IO, Express, and Async.
//
var http = require('http');
var path = require('path');

var async = require('async');
var socketio = require('socket.io');
var express = require('express');

//
// ## SimpleServer `SimpleServer(obj)`
//
// Creates a new instance of SimpleServer with the following options:
//  * `port` - The HTTP port to listen on. If `process.env.PORT` is set, _it overrides this value_.
//
var router = express();
var server = http.createServer(router);
var io = socketio.listen(server);

router.use(express.static(path.resolve(__dirname, 'client')));


//--------------//
var rooms = [];

io.on('connection', function (socket) {
  console.log("ID: "+socket.id.substring(2)+"has connected");

  socket.on('event_name',function(data){
    console.log(data);
    socket.emit('send',{aisatsu:"こんにちは"});
  });


//-----主催者用のイベント-------//
  socket.on('makeRoom',function(){
      var roomname = Math.floor(Math.random()*(9999-1000)+1000);
      rooms[] = roomname;
      socket.roomname = roomname;
      socket.flg = 1 ;
      console.log(socket);
  });

  socket.on('choice',function(data){
    if(!socket.flg){
      return;
    }
    // rooms[socket.roomname].foreach(socket){
    //   socket.emit('choice',data);
    io.to(roomname).broadcast()
    }
  });



//----参加者用のイベント-------//
  socket.on('joinRoom',function(roomname){
    //roomsの配列にdata.roomnameがあるかどうかチェック
    if([!rooms[]=data.noomname]){
      return;
    }
      //ある場合、その配列に自分のsocketを追加する。
      socket.join(roomname);
      console.log(roomname);
  });

});

server.listen(process.env.PORT || 3000, process.env.IP || "0.0.0.0", function(){
  var addr = server.address();
  console.log("Chat server listening at", addr.address + ":" + addr.port);
});
