<guest>
<div id="main">
<!--1ページ目-->
<div if={ vis == 1}>
<form action="">
          <br><span>ルームコード入力:</span><input type="text" style="width:300px" id="roomcode"><br><br>
          <span>名前入力:</span><input type="text" style="width:300px" id="username">
</form><br>
       <p class="link" onclick={toWait}>ログイン</p>
</div>
<!--2ページ目-->
<div if={ vis == 2}>
    <div id="roomcode">ルームコード</div>
    <div id="select"><p>主催者からの要請をお待ち下さい</p></div>
    <p onclick={toClose} class="link">退室</p>
</div>
<!--3ページ目　選択問題の回答ページ-->
<div if={ vis == 3}>
    <p class="Behavior">選ぶ</p>
    <p each={choice} onclick={toResult_choice} class="link" >{number}</p>
</div>
<!--3ページ目　テキスト問題の回答ページ-->
<div if={ vis == 4}>
    <p class="Behavior">テキスト回答</p>
    <form name="text">
        <textarea name="answer" id="textAnswer" cols="50" rows="10"></textarea>
        <p class="link" onclick={toResult_text}>送信</p>
    </form>
</div>
<!--3ページ目　作成問題の回答ページ-->
<div if={ vis == 5}>
    <p class="Behavior">選ぶ</p>
    <p>問題；{Q}</p>
    <p id="time">制限時間</p>
    <p each={choice} onclick={toResult_createQ} class="link" >{number}-{content}</p>
</div>
<!--4ページ目　回答送信後の待ち-->
<div if={ vis == 6 }>
    <div id="roomcode">ルームコード</div>
    <div id="select"><p>主催者からの要請をお待ち下さい</p></div>
    <div><p>最新回答:<span id="index">{Answer}</span></p></div>
    <p onclick={toClose} class="link">退室</p>
</div>
</div>
<!--スクリプト-->
<script>
    var self = this;
    self.socket = io.connect();
    self.choice =[];
    self.index;
    self.vis = 1;
    self.Answer;//回答
    var guestdata = {};//ゲストデータ
    self.answerFinish = false;//回答済みか判定
    var setAnswerTime = 0;

//----------------------------------------mount,socket.on受信
    this.on('mount',function(){
        self.socket.on('joinResult',function(data){
            //ルームコード確認
            if( data == 0){
              alert("番号が違います");
            }
            if( data == 1){
              self.vis = 2;
              self.update();
            }
        });
        self.socket.on('count',function(data){
            console.log(data);
            console.log("A");
        });
        self.socket.on('OtoG',function(data){
            //選択肢問題受信
            if(data.type == 'select'){
                self.choice.length = 0;
                for( var i = 0; i < data.SN; i++){
                    self.choice[i] = {number:i+1};
                }
                self.title = "選ぶ";
                console.log(self.choice);
                self.answerFinish = false;//未回答へ変更
                self.vis=3;
                self.update();
            }
            //テキスト問題受信
            if(data.type == 'text'){
                self.title = "テキスト入力";
                self.answerFinish = false;//未回答へ変更
                self.vis=4;
                self.update();
            }
            //問題文作成問題受信
            if(data.type == 'createQ'){
                self.choice.length = 0;
                console.log(data.Time);
                setAnswerTime = data.Time;
                count = data.Time;
                timerID = setInterval(function(){
                    document.getElementById("time").innerHTML = count;
                    count--;
                    if (count < 0){
                        alert("Time UP!");
                        self.vis = 6;
                        Answer = "未回答";
                        self.answerFinish　=true;//回答済みに変更
                        clearInterval(timerID);
                        self.update();
                    }
                },1000);
                self.Q = data.Q;//問題文
                for( var i = 0; i < data.SN; i++){
                    self.choice[i] = {
                        number:data.QContent[i].num+1,//選択肢数
                        content:data.QContent[i].content//項目
                    }
                }
                self.title = "選ぶ";
                console.log(self.choice);
                self.answerFinish = false;//未回答へ変更
                self.vis=5;
                self.update();
            }
            //未回答だが回答締め切りされた場合
            if(data.type == 'deadline'){
                self.vis = 6;
                Answer = "未回答";
                self.answerFinish　=true;//回答済みに変更
                self.update();

            }
            //主催者退室した場合
            if(data.type == 'close'){
                alert('主催者が退室しました。本日はありがとうございました。')
                location.href = location.origin;
            }

        });
    });
//-----------------------------------------onClick,emit送信
    toWait = function(){
        guestdata.roomname = document.querySelectorAll('#roomcode')[0].value;
        guestdata.username = document.querySelectorAll('#username')[0].value;
        self.socket.emit('joinRoom', guestdata);
    }
    //選択肢問題回答
    toResult_choice = function(event){
        var item = event.item;
        Answer = self.choice.indexOf(item) + 1;
        data = {
            type:'select_answer',
            kaitou:Answer,
        };
        self.socket.emit('GtoO',data);
        self.answerFinish　=true;//回答済みに変更
        self.vis = 6;
        self.update();
    }
    //テキスト問題回答
    toResult_text = function(){
        Answer = document.text.answer.value;
        data = {
            type:'text_answer',
            Name:guestdata.username,
            Answer:Answer,
        }
        self.socket.emit("GtoO",data);
        document.text.answer.value ="";
        self.answerFinish　=true;//回答済みに変更
        self.vis = 6;
        self.update();
     }
    //作成問題の回答
    toResult_createQ = function(){
        var item = event.item;
        Answer = self.choice.indexOf(item) + 1;
        answerTime = setAnswerTime - count;
        data = {
            type:'createQ_answer',
            Name:guestdata.username,
            kaitou:Answer,
            zikan:answerTime
        }
        console.log(data);
        self.socket.emit('GtoO',data);
        self.answerFinish　=true;//回答済みに変更
        clearInterval(timerID);
        self.vis = 6;
        self.update();
    }
    toClose = function(){
        location.href = location.origin;
    }
    //------------------------------------------function

</script>


 <!-- style -->
  <style scoped>
    .link{
        cursor:pointer;
        background:#00a7ea;
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
          border-top:1px solid #00a7ea;
          border-bottom:1px solid #00a7ea;
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
