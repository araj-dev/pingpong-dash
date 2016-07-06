<guest>
<div id="main">
<div if={ vis == 1}>
<form action="">
          <br><span>ルームコード入力:</span><input type="text" style="width:300px" id="roomcode"><br><br>
          <span>名前入力:</span><input type="text" style="width:300px">
</form><br>
       <p class="link" onclick={toWait}>ログイン</p>
</div>

<div if={ vis == 2}>
<div id="roomcode">ルームコード</div>
<div id="select"><p onclick={toSelect}>主催者からの要請をお待ち下さい</p></div>
</div>

<div if={ vis == 3}>
<p class="Behavior">選ぶ</p>
<p each={choice} onclick={toResult} class="link" >{number}</p>
</div>

<div if={ vis == 4 }>
<div id="roomcode">ルームコード</div>
<div id="select"><p onclick={toSelect}>主催者からの要請をお待ち下さい</p></div>
<div><p>最新回答:<span id="index">{self.index}</span></p></div>
</div>


</div>



<script>
    var self = this;
    this.on('mount',function(){
      self.socket = io.connect();
    });
    
    self.choice =[ {number:1},{number:2},{number:3},{number:4}];
    self.ndex;
    self.vis = 1;

    toWait = function(){
        var roomcode = document.querySelectorAll('#roomcode')[0].value;
        self.socket.emit('joinRoom',roomcode);
        self.vis = 2;
    }

    toSelect = function(){
        self.vis = 3;
    }

    toResult = function(event){
        self.vis = 4;
        var item = event.item;
        index = self.choice.indexOf(item) + 1;
        console.log(index);
    }
</script>


 <!-- style -->
  <style scoped>

    .link{
    cursor:pointer;
    background:green;
      color:white;
      padding:10px;
      width:
    }

    .link:hover {
        color: red;
        cursor: pointer;
    }
   
    #main{
    width:500px;
    }
    #roomcode{
    background:black;
    color:white;
    padding:10px;
    }
    #select{
    height:250px;
    border-top:1px solid green;
    border-bottom:1px solid green;
    margin-top:20px;
    padding:20px;
    margin-bottom:30px;
    }
    .Behavior{
    font-size:20px;
    margin-bottom:20px;
    padding:20px;
    border-bottom:1px solid black;
    }
    #index{
    background:red;
    padding:10px 15px;
    border-radius:5px;
    color:white;
    
    }




  </style>









</guest>