<guest>
<div id="main">
<div if={ vis == 1}>
<form action="">
          <br><span>ルームコード入力:</span><input type="text" style="width:300px"><br><br>
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
<p each={choice} onclick={toResult} class="link">{number}</p>
</div>

<div if={ vis == 4 }>
<div id="roomcode">ルームコード</div>
<div id="select"><p onclick={toSelect}>主催者からの要請をお待ち下さい</p></div>
</div>


</div>



<script>
var self = this;
self.choice =[ {number:1},{number:2},{number:3},{number:4}]
this.vis = 1;

toWait = function(){
this.vis = 2;
}

toSelect = function(){
this.vis = 3;
}

toResult = function(){
this.vis = 4;
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
    }
    .Behavior{
    font-size:20px;
    margin-bottom:20px;
    padding:20px;
    border-bottom:1px solid black;
    
    }




  </style>









</guest>