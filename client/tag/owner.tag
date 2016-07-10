<owner>
<div id="main">
<!--1ページ目-->
<div if={ vis == 1}>
    <p>Profile</p>
    <p onclick={toSelect} class="link">Start PingPong</p>
    <p class="link">ログアウト</p>
</div>

<!--2ページ目-->
<div if={ vis == 2}>
    <p>部屋番号：{roomname}&nbsp;&nbsp;参加人数：{guestNumber}</p>
    <form name="question">
    選択肢の数を記入<input type="text" class="inputText" maxlength="1" name="selectNum" pattern="^[0-9A-Za-z]+$">
        <p onclick={selectNumber} class="link">アンケート</p>
    </form>
    <p onclick={toResult} class="link">テキスト送信</p>
    <p onclick={toCreateQ} class="link">問題文作成</p>
    <p onclick={toClose} class="link">退室</p>
</div>

<!--3ページ目　選択問題-->
<div if={ vis == 3}>
    <div id="result"><canvas id="bar" class="canvas"></canvas></div>
    <p onclick={backSelect} class="link">回答を締め切る</p>
</div>
<!--3ページ目　テキスト問題-->
<div if={ vis == 4}>
    <div id="result">
        <ul>
            <li each={textAnswer}>回答者：{Name}ー{Answer}</li>
        </ul>
    </div>
        <p onclick={backSelect} class="link">回答を締め切る</p>
    </div>
<!--4ページ目　問題文作成画面-->
<div if={ vis == 5}>
  <form name="Q">
    問題文作成<input type="text" id="Qtext" name="question">
    選択肢の数を入力<input type="text" id="selectNum" name="num">
    <p onclick={getSelectNum} class="link">選択肢数決定</p>
    <ul>
        <li each={selectNumber}>{Number}:<input type="text" id="Answer" name="Q{Number}"></li>
    </ul>
    <p onclick={sendCreateQ} class="link">送信</p>
  </form>
</div>
</div>
<script>
    var self = this;
    self.socket = io.connect();
    this.vis = 1;
    self.guestNumber = 0;
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
    
    
 
//-------------------------------------------onClick,emit送信
        toSelect = function(){
          self.socket.emit('makeRoom');
          self.vis = 2;
        }
        //選択肢問題の回答要請
        selectNumber = function(){
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
            self.vis = 5;
            self.update();
        }
        //問題文作成,選択肢の数を決定
        getSelectNum = function(){
            var selectNum = document.Q.num.value;//選択肢数
            for (var i = 0;i<selectNum;i++){
                self.selectNumber.push({Number:i+1}); 
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
            Kaitou_Data.SN = document.Q.num.value;//選択肢数
            var Question = document.Q.question.value;//問題文
            var data = {
                type:'createQ',
                SN:Kaitou_Data.SN,
                Q:Question,//問題文
                QContent:self.QselectContent//選択肢、選択肢の項目
            }
            console.log(data);
            self.socket.emit('OtoG',data);
            document.Q.num.value = "";
            document.Q.question.value ="";
            self.selectNumber.length = 0;
            for( var i = 0;i<Kaitou_Data.SN;i++){
                Kaitou_Data.X[i] = i + 1;
                Kaitou_Data.Y[i] = 0; 
            }
            self.vis = 3;
            self.update();
        }
        //回答形式の選択画面（２ページ目）へ
        backSelect = function(){
            if( Kaitou_Data.SN == 0){
                self.textAnswer.length = 0;
                self.vis = 2;
            }else if(Kaitou_Data.SN > 0){
                Date_Zero(Kaitou_Data);
                chart(Kaitou_Data);
                Kaitou_Data.SN = 0;
                self.vis = 2;
            }
        }
        //退室
        toClose = function(){
            var data = {
                type:'close'
            }
            self.socket.emit('OtoG',data);
            location.href = 'http://0.0.0.0:3000/';
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
                self.update();   
            }
            if(data.type == 'createQ_answer'){
                console.log(data);
                Kaitou_Check(data);
                chart(Kaitou_Data); 
                
            }
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
    p { 
        background:green;
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
      }
      #result{
          border:1px solid green;
          height:250px;
      }
      .inputText{
          width:30px;
          height:50px;
          font-size:30pt;
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
  </style>
</owner>
