<test>
   <div class="blog-masthead">
    <div class="container">
        <nav class="blog-nav">
            <a class="blog-nav-item active" href="#" onclick={test}>Home</a>
            <a class="blog-nav-item" href="#" onclick={test2}>アンケート</a>
            <a class="blog-nav-item" href="#" onclick={test3}>問題作成</a>
            <a class="blog-nav-item" href="#" onclick={test4}>問題作成</a>
            <a class="blog-nav-item" href="#" onclick={test}>退室</a>
            <a class="blog-nav-item" href="#" onclick={test} id="roomNum">部屋番号：９９９９</a>
            <a class="blog-nav-item" href="#" onclick={test} id="menberNum">参加人数：６人</a>
        </nav>
    </div>
</div>

<div class="container">
<div id="main">
<!--1ページ目-->
<div if={ vis == 1}>
    <p id="roomcode">ようこそ！</p>
    <p onclick={toSelect} class="link">Start G's Rally</p>
    <p class="link">ログアウト</p>
</div>

<!--2ページ目-->
<div if={ vis == 2}>
    <p id="roomcode">部屋番号：{roomname}&nbsp;&nbsp;参加人数：{guestNumber}</p>
    <form name="question">
    
        <p>選択肢の数を記入<input type="text" class="inputText" maxlength="1" name="selectNum" pattern="^[0-9A-Za-z]+$"><span onclick={choiceNumber} class="link">アンケート</span></p>
    </form>
    <p onclick={toResult} class="link">テキスト送信</p>
    <p onclick={toCreateQ} class="link">問題文作成</p>
    <p onclick={toClose} class="link">退室</p>
</div>

<!--3ページ目　選択問題-->
<div if={ vis == 3}>
    <div id="result"><canvas id="bar" class="canvas"></canvas></div>
    <p onclick={backSelect} class="link">回答を締め切る</p>
    <p class="link">{finishedAnswer}/{guestNumber}</p>
</div>
<!--3ページ目　テキスト問題-->
<div if={ vis == 4}>
    <div id="result">
        <table>
        <tr>
            <th class="first">回答者</th>
            <th class="second">回答</th>
        </tr>
        <tr each={textAnswer}>
            <td class="first">{Name}</td>
            <td class="second">{Answer}</td>
        </tr>
    </table>
    </div>
        <p onclick={backSelect} class="link">回答を締め切る</p>
        <p class="link">{finishedAnswer}/{guestNumber}</p>
    </div>
<!--3ページ目　作成問題-->
<div if={ vis == 5}>
    <div id="result">
        <canvas id="bar" class="canvas"></canvas>
    </div>
        <p onclick={backSelect} class="link">回答を締め切る</p>
        <p class="link">{finishedAnswer}/{guestNumber}</p>
                <table>
        <tr>
            <th class="ichi">順位</th>
            <th class="ni">回答者</th>
            <th class="san">正解数</th>
            <th class="yon">回答時間</th>
        </tr>
        <tr each={rankData}>
            <td class="ichi">{Rank}</td>
            <td class="ni">{Name}</td>
            <td class="san">{Correct}問</td>
            <td class="yon">{Time}秒</td>

        </tr>
    </table>
</div>
<!--4ページ目　問題文作成画面-->
<div if={ vis == 6}>
  <form name="Q" id="Q">
    問題文作成<input type="text" id="Qtext" name="question">
    選択肢の数を入力
    <p><input type="text" class="inputText" name="num"><span onclick={getSelectNum} class="link">選択肢数決定</span></p>
    <table>
        <tr>
            <th class="one">番号</th>
            <th class="two">項目</th>
            <th class="three">正解</th>
        </tr>
        <tr each={selectNumber}>
            <td>{Number}</td>
            <td><input type="text" id="Answer" name="Q{Number}"></td>
            <td><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R{Number}"></td>
        </tr>
    </table>
    制限時間を入力<input type="text" id="Time" name="Time" class="inputText">分
    <p onclick={sendCreateQ} class="link">送信</p>
  </form>
</div>
<!--URLページ　-->
<div if={ vis == 7}>
    <h1 id="URL">http://0.0.0.0:3000/<br>bootstrap.html#</h1>
    <h1 id="URL">部屋番号：９３９２</h1>
</div>
</div>
<script>
    var self = this;
    self.socket = io.connect();
    this.vis = 1;
    self.guestNumber = 0;//参加人数
    var X= [];//チャートのラベル
    var Y = [];//チャートのラベルに対する回答者数
    self.textAnswer = [];//テキスト問題の回答の配列
    var Kaitou_Data = {
        X:X,
        Y:Y,
        guest:0,
        SN:0
    }//チャートオブジェクト
    self.selectNumber = [];//問題作成の選択肢数の配列
    self.answerNum = 0;//正解番号
    self.finishedAnswer = 0;//回答者数
    self.rankData = [];//ランキング表データ



//-------------------------------------------onClick,emit送信
        toSelect = function(){
          self.socket.emit('makeRoom');
          self.vis = 2;
        }
        //選択肢問題の回答要請
        choiceNumber = function(){
            Kaitou_Data.SN = document.question.selectNum.value;
            var data = {
                type:'select',
                SN:Kaitou_Data.SN
            };
            console.log(Kaitou_Data.SN);
            self.socket.emit('OtoG',data);
            document.question.selectNum.value ="";
            for( var i = 0;i<Kaitou_Data.SN;i++){
                Kaitou_Data.X[i] = i + 1;
                Kaitou_Data.Y[i] = 0;
            }
            self.vis = 3;
            self.update();
        }
        //テキストの回答要請
        toResult = function(){
            var data = {
                type:'text',
            };
            self.socket.emit('OtoG',data);
            self.vis = 4;
            self.update();
        }
        //問題文作成
        toCreateQ = function(){
            self.vis = 6;
            self.update();
        }
        //問題文作成,選択肢の数を決定
        getSelectNum = function(){
            var selectNum = document.Q.num.value;//選択肢数
            for (var i = 0;i<selectNum;i++){
                self.selectNumber.push({Number:i+1});
            }
        }
        //ラジオボタンのチェック判断で正解の取得
        trueORfalse = function(){
            self.answerNum = 0;
            for( var i = 1;i < parseInt(document.Q.num.value)+1;i++){
                 check = document.Q.elements['R'+ i].checked;
                if(check == true){
                    self.answerNum = i;
                }
            }
        }
        //問題文作成,選択肢の項目を設定し、送信
        sendCreateQ = function(){
            self.QselectContent = [];
            for( var i = 0 ;i < parseInt(document.Q.num.value);i++){
                var content = document.Q.elements['Q'+(i+1)].value;
                document.Q.elements['Q'+(i+1)].value = "";
                self.QselectContent[i] = {num:i,content:content};
            }
            Kaitou_Data.SN = document.Q.num.value;//選択肢数//グラフ描画する場合
            //グラフ描画しない場合var sentakusi = document.Q.num.value;
            var Question = document.Q.question.value;//問題文
            var Time = document.Q.Time.value*60;//制限時間
            var data = {
                type:'createQ',
                SN:Kaitou_Data.SN,//グラフ描画する場合//グラフ描画しない場合sentakusi,//選択肢の数
                Q:Question,//問題文
                QContent:self.QselectContent,//選択肢、選択肢の項目
                Time:Time//制限時間
            }
            console.log(data);
            self.socket.emit('OtoG',data);
            document.Q.num.value = "";
            document.Q.question.value ="";
            document.Q.Time.value = "";
            self.selectNumber.length = 0;
            for( var i = 0;i<Kaitou_Data.SN;i++){
                Kaitou_Data.X[i] = i + 1;
                Kaitou_Data.Y[i] = 0;
            }
            self.vis = 5;
            self.update();
        }
        //回答形式の選択画面（２ページ目）へ
        backSelect = function(){
            console.log("チェック");
            //テキスト回答,作成問題の場合の処理
            if( Kaitou_Data.SN == 0){
                self.textAnswer.length = 0;
                self.rankData.length = 0;//ランキングデータリセット
                self.vis = 2;
            }
            if(Kaitou_Data.SN > 0){
                Date_Zero(Kaitou_Data);
                chart(Kaitou_Data);
                Kaitou_Data.SN = 0;
                self.vis = 2;
            }
            //回答出来なかった参加者がいた場合の処理
            if(self.finishedAnswer != self.guestNumber){
                var data = {
                    type:'deadline'
                }
                self.socket.emit("OtoG",data);
                alert("回答を締め切りました")
            }
            self.finishedAnswer = 0;//回答者数リセット
        }
        //退室
        toClose = function(){
            var data = {
                type:'close'
            }
            self.socket.emit('OtoG',data);
            location.href = 'http://0.0.0.0:3000/';
        }
        test = function(){
            self.vis = 2;
        }
        test2 = function(){
            self.vis = 3;
        }
        test3 = function(){
            self.vis = 6;
        }
        test4 = function(){
            self.vis = 7;
        }
//-------------------------------------mount,socket.on受信
    this.on('mount',function(){
        self.socket.on('success',function(roomcode){
            self.roomname = roomcode;
            console.log(self.roomname);
            self.update();
        });
        self.socket.on('count',function(data){
            Kaitou_Data.guest = Kaitou_Data.guest + data;
            self.guestNumber = Kaitou_Data.guest;
            self.update();
        });
        self.socket.on('GtoO',function(data){
            //選択回答の受信
            if( data.type == 'select_answer'){
                Kaitou_Check(data);
                chart(Kaitou_Data);
            }
            //テキスト回答の受信
            if(data.type == 'text_answer'){
                console.log(data.Answer);
                self.textAnswer.push({Name:data.Name,Answer:data.Answer});
            }
            //作成問題の回答受信
            if(data.type == 'createQ_answer'){

                console.log(data);
                Kaitou_Check(data);
                chart(Kaitou_Data);
                var Correct = 0;//正解数
                if(data.kaitou == self.answerNum){
                    Correct = Correct + 1;//回答と正解番号が一致したら正解数をプラス1
                }
                var rank = 1;//順位変数
                var AnswerData = {//回答者データ
                    Rank:rank,
                    Name:data.Name,//名前
                    Answer:data.kaitou,//回答番号
                    Time:data.zikan,//回答時間
                    Correct:Correct//正解数
                    }

                self.rankData.push(AnswerData);

                self.rankData.sort(//正解数、回答時間で並べ替え
                        function(a,b){
                                var aCorrect = a["Correct"];
                                var bCorrect = b["Correct"];
                                var aTime = a["Time"];
                                var bTime = b["Time"];
                                if( aCorrect < bCorrect ) return 1;
                                if( aCorrect > bCorrect ) return -1;
                                if( aTime < bTime ) return -1;
                                if( aTime > bTime ) return 1;
                                return 0;
                        }
                );
                if(self.rankData.length > 1){
                    var num = 1;
                    for( var i = 0; i < self.rankData.length;i++){

                        if(self.rankData[0] == self.rankData[i]){
                            self.rankData[0].Rank = num;
                        }
                        if(self.rankData[0] != self.rankData[i]){
                                if( self.rankData[i].Correct == self.rankData[i-1].Correct && self.rankData[i].Time == self.rankData[i-1].Time ){
                                    self.rankData[i].Rank = num;
                                }else{
                                    num = num + 1;
                                    self.rankData[i].Rank = num;
                                }
                        }
                    }
                }
                console.log(self.rankData);

            }
            //回答者数 / 参加人数
            self.finishedAnswer = self.finishedAnswer + 1;
            self.update();
        });
    });
  //----------------------------------------------------function
        //チャートのラベル、回答数リセット
        function Date_Zero(obj){
            obj.X.length = 0;
            obj.Y.length = 0;
        }
        //チャート、選択肢ごとの回答数のカウント
        function Kaitou_Check(data2){

                if ( data2.kaitou){
                    Kaitou_Data.Y[data2.kaitou-1] = Kaitou_Data.Y[data2.kaitou-1] + 1;
                }
        }
        //チャート描画
        function chart(data){
                var barChartData = {
                  labels : data.X,
                  datasets : [
                    {
                      fillColor : "rgba(220,220,220,0.5)",
                      strokeColor : "rgba(220,220,220,1)",
                      data : data.Y
                    }

                  ]
                }
                var option = {
                      scaleOverride : true,
                    tooltipEvents: [],
                    onAnimationComplete: function(){
                      this.eachBars(function(bar){
                        var tooltipPosition = bar.tooltipPosition();
                        new Chart.Tooltip({
                          x: Math.round(tooltipPosition.x),
                          y: Math.round(tooltipPosition.y),
                          xPadding: this.options.tooltipXPadding,
                          yPadding: this.options.tooltipYPadding,
                          fillColor: this.options.tooltipFillColor,
                          textColor: this.options.tooltipFontColor,
                          fontFamily: this.options.tooltipFontFamily,
                          fontStyle: this.options.tooltipFontStyle,
                          fontSize: this.options.tooltipFontSize,
                          caretHeight: this.options.tooltipCaretSize,
                          cornerRadius: this.options.tooltipCornerRadius,
                          text: bar.value,
                          chart: this.chart
                        }).draw();
                      });
                    },
                    showTooltips: true,
                    showScale:true,
                    scaleShowVerticalLines:false,
                    //縦軸の区切りの数
                      scaleSteps : 1,
                      //縦軸の目盛り区切りの間隔
                      scaleStepWidth : Kaitou_Data.guest,
                      //縦軸の目盛りの最小値
                      scaleStartValue : 0,
                      animation : false
                }
                var myLine = new Chart(document.getElementById("bar").getContext("2d")).Bar(barChartData,option);
        }
</script>
 <!-- style -->
  <style scoped>
      header{
/*          background-image: url("./img/paper-a1.png");*/
          background: #00a7ea;
          padding-top:20px;
          padding-bottom:20px;
          
          
      }
      #sukima{
         background-image: url("./img/syasen.png");
         
          height:3px;
      }
      ul{
          text-align:center;
          padding:0px;
          
      }
      li{
        display:inline-block; 
          font-size:15px;
          padding:10px;
/*          font-weight:bold;*/
          border-left:1px solid black;
          border-right:1px solid black;
          width:80px;
          height:10px;
          color:white;
          
      }
      li:hover{
          background:#00a7ea;
          border-radius:5px;
          width:80px;
          height:10px;
      }
      #self{
          color:red;
          width:150px;
          background:yellow;
      }
    p {
        background:#00a7ea;
        color:white;
        padding:10px;
      }
      #roomcode{
          background:black;
          color:white;
          padding:10px;
      }
      .link{
          cursor:pointer;
      }
      .link:hover {
          color: red;
          cursor: pointer;
      }
      #main{
          width:500px;
          margin-top:100px;
          margin-left:auto;
          margin-right:auto;
          position:relative;
          
          
      }
      #result{
          border:1px solid #00a7ea;
          height:250px;
      }
      .inputText{
          width:20px;
          height:30px;
          font-size:20pt;
          color:black;
      }
      .canvas{
          height:250px;
          width:500px;
      }
      #Qtext{
          width:500px;
      }
      #selectNum{
          width:30px;
          height:50px;
          font-size:30pt;
      }
      #Answer{
          width:400px;
      }
      .first{
          width:100px;
          text-align:left;
      }
      .second{
          text-align:left;
      }
      .one{
          width:100px;
          text-align:left;
      }
      .two{
          width:300px;
          text-align:left;
      }
      .three{
          width:50px;
          text-align:left;
      }
      .ichi{
          width:100px;
          text-align:left;
      }
      .ni{
          width:100px;
          text-align:left;
      }
      .san{
          width:100px;
          text-align:left;
      }
      .yon{
          width:100px;
          text-align:left;
      }
      #URL{
          font-size:100px;
      }
      #roomNum{
          position:absolute;
          top:0;
          left:800px;
         
      }
      #menberNum{
          position:absolute;
          top:0;
          left:950px;
          
      }
      
  </style>


</div><!-- /.container -->

</test>