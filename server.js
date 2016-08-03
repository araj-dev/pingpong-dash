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
var rooms = {};
var roomnames = [];

io.on('connection', function (socket) {
  console.log("ID: "+socket.id.substring(2)+"has connected");


//-----主催者用のイベント-------//
  socket.on('makeRoom',function(){

    //roomnameがかぶらないための処理
    do {
    var roomname = Math.floor(Math.random()*(9999-1000)+1000).toString();
    }while( 0 <= roomnames.indexOf(roomname));
      console.log(roomname);

      socket.roomname = roomname;
      socket.flg = 1 ;
      socket.emit('success',roomname);
      roomnames.push(roomname);
      rooms[roomname] = socket;
  });

  socket.on('OtoG',function(data){
    if(!socket.flg){
      return;
    }
    io.to(socket.roomname).emit('OtoG',data);
  });



//----参加者用のイベント-------//
  socket.on('joinRoom',function(guestdata){
    //roomnamesの配列にdata.roomnameがあるかどうかチェック
      var roomname = guestdata.roomname.toString();

    if(roomnames.indexOf(roomname) == -1){
      console.log("not exsist");
      socket.emit('joinResult', {result:0});
      return;
    }

      //ある場合、その配列に自分のsocketを追加する;
      console.log("exist");
      socket.join(roomname);
      socket.roomname = roomname;
      socket.flg = 0;
      if("" === guestdata.username){
        var betaname = Math.floor(Math.random()*(9999-1000)+1000).toString();
        socket.username = 'guest'+betaname;
      } else {
        socket.username = guestdata.username;
      }
      console.log(socket.username);
      var data = {
          result:1,
          name:socket.username
      };
      socket.emit('joinResult', data);

      //参加者カウント用
      rooms[roomname].emit('count', 1);
  });

    socket.on('GtoO',function(data){
    console.log("GtoO");
    rooms[socket.roomname].emit('GtoO',data);
  });

    socket.on('disconnect',function(){
        console.log("ID: "+socket.id.substring(2)+"has disconnected");

        //参加者カウント用
        if(!rooms[socket.roomname]){
            return;
        }
        rooms[socket.roomname].emit('count', -1);
        //console.log(socket);

        //オーナーdisconnectの時ルーム情報を削除
        if(socket.flg == 1){
          //console.log(socket.adapter.rooms);
          //console.log(socket.roomname);
          var roomIndex = roomnames.indexOf(socket.roomname);
          roomnames.splice(roomIndex, 1);
          delete rooms[socket.roomname];
          delete socket.roomname;

          // console.log(socket.roomname);
          // console.log(roomnames);
          // console.log(rooms);
        }
    });
});


server.listen(process.env.PORT || 3000, process.env.IP || "0.0.0.0", function(){
  var addr = server.address();
  console.log("Chat server listening at", addr.address + ":" + addr.port);
});
