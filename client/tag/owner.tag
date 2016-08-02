<owner>
<div id="hanbaga_menu">
            <ul class="munu_han">
              <li class="menuhan" onclick={toFunction}>機能</li>
              <li class="menuhan" onclick={toCustom}>カスタム</li>
              <li class="menuhan" onclick={toURL}>URL</li>
          </ul>    
        </div>
<div id="header">
        <header>
         <i class="fa fa-bars hanbaga" id="show" if={vis==2 ||vis==2.1 ||vis==3 ||vis==4 ||vis==5 ||vis==6||vis==7} onclick={hanbaga}></i>
          <ul class="menu_ul2" if={vis==2 ||vis==2.1 ||vis==3 ||vis==4 ||vis==5 ||vis==6||vis==7}>
              <li class="menu2" onclick={toFunction}>機能</li>
              <li class="menu2" onclick={toCustom}>カスタム</li>
              <li class="menu2" onclick={toURL}>URL</li>
          </ul>   
          <ul class="menu_ul3" if={vis==2 ||vis==2.1 ||vis==3 ||vis==4 ||vis==5 ||vis==6||vis==7}>
              <li class="menu3"><span>部屋番号:</span>{roomname}</li>
     <li class="fa fa-user icon_user menu3" aria-hidden="true">{guestNumber}</li>
          </ul>
        </header>
        <div id="header_under"> 
        </div>
</div>
<!--1ページ目-->
<div id="body">
<div if={ vis == 1}  class="top padding-top">
    <div class="entry content_center">CreateRoom!<br><span class="button-dropdown" data-buttons="dropdown">
    <a  onclick={toSelect}  class="button button-rounded button-flat-action">部屋作成 </a>
    </span></div>

</div>

<!-----------------------------------------------選択画面-->
<!--選択・テキスト-->
<div if={ vis == 2} class="top padding-top">
 
  <ul class="menu_ul content_center">
     <li class="room_number"><span>部屋番号:</span>{roomname}</li>
     <li class="fa fa-user icon_user gestNumber_text" aria-hidden="true">{guestNumber}</li>
      <li class="function">   <span class="button-dropdown" data-buttons="dropdown">
              <a class="button button-rounded button-flat-primary">選択肢     ⬇︎</a>

              <ul class="button-dropdown-menu-below" style="display: none;" id="choiceNumber_ul">
                <li onclick={getNum}><a href="#">２つ</a></li>
                <li onclick={getNum}><a href="#">３つ</a></li>
                <li onclick={getNum}><a href="#">４つ</a></li>
                <li onclick={getNum}><a href="#">５つ</a></li>
                <li onclick={getNum}><a href="#">６つ</a></li>
                <li class="button-dropdown-divider"><a href="#">Option 3</a></li>
              </ul>
    </span></li>
      <li class="function"><span class="button-dropdown" data-buttons="dropdown">
  <a onclick={toText} class="button button-rounded button-flat-action"> テキスト </a>
</span></li>
  </ul>
</div>
<!--4ページ目　問題文作成画面-->
<div if={ vis == 6} class="top padding-top">
 <div id="result">
 <table>
     <tr>
         <td colspan="3">問題文作成</td>
     </tr>
     <tr>
         <td colspan="3"><input type="text" id="Qtext" name="question"></td>    
     </tr>
     <tr>
         <th>番号</th>
         <th>項目</th>
         <th>正解</th>
     </tr>
     <tr>
         <th>1</th>
         <th><input type="text" id="Answer0" name="Q1"></th>
         <th><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R1"></th>
     </tr>
     <tr>
         <th>2</th>
         <th><input type="text" id="Answer1" name="Q2"></th>
         <th><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R2"></th>
     </tr><tr>
         <th>3</th>
         <th><input type="text" id="Answer2" name="Q3"></th>
         <th><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R3"></th>
     </tr><tr>
         <th>4</th>
         <th><input type="text" id="Answer3" name="Q4"></th>
         <th><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R4"></th>
     </tr>
 </table>
 制限時間を入力<input type="text" id="Time" name="Time" class="inputText">分
    <p onclick={sendCreateQ} class="link">送信</p>
    
    
<!--選択肢選択できる問題作成
  <form name="Q" id="Q">
   <p>問題文作成</p>
    <input type="text" id="Qtext" name="question">
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
-->
  </div>
</div>
<!------------------------------------------------結果画面-->
<!--3ページ目　選択問題-->
<div if={ vis == 3} class="padding-top">
    <div id="result">
       <div id="chart"></div>
    </div>
      <i onclick={toPieChart} class="fa fa-pie-chart barpie" aria-hidden="true"></i>
      <i onclick={tobarChart} class="fa fa-bar-chart barpie" aria-hidden="true"></i><br>
               <span class="button-dropdown" data-buttons="dropdown">
               <a  onclick={backSelect} class="button button-rounded button-flat-primary">回答を締め切る</a>
               </span>
        <p class="link">{finishedAnswer}/{guestNumber}</p>
        <a onclick={shot2} id="shot">テストダウンロード</a><br>
    </div>
<!--3ページ目　テキスト問題-->
<div if={ vis == 4} class="main padding-top">
         <h1>返答</h1>
<div id="result">
<section id="sec01">
    <table class="demo01" id="javascript_sample_table_1">
        <tbody id="javascript_sample_table_1_tbody">
            <tr each={textAnswer}>
                <th>{Name}</th>
                <td>{Answer}</td>
            </tr>
        </tbody>
    </table>
</section>
       </div>
       <span class="button-dropdown" data-buttons="dropdown">
       <a  onclick={backSelect} class="button button-rounded button-flat-action">回答を締め切る</a>
       </span>
        <p class="link">{finishedAnswer}/{guestNumber}</p>
        <a onclick={shot}>テストダウンロード</a><br>
        
 </div>
<!--3ページ目　作成問題-->
<div if={ vis == 5}>
        <div id="chart"></div>
        <button onclick={toPieChart}>円グラフを表示</button><br />
        <button onclick={tobarChart}>棒グラフを表示</button><br />
        <span class="button-dropdown" data-buttons="dropdown">
              <a  onclick={backSelect} class="button button-rounded button-flat-primary">回答を締め切る</a>
               </span>
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
<!--URL表示ページ-->
<div if={ vis == 7}  class="top padding-top">
    <div class="URL content_center">http://<br>0.0.0.0:3000/<br>guest.html<br>部屋番号：{roomname}</div>

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
    var columns = [];//c3.jsのグラフオブジェクト
    var Xziku = [];//c3.jsのグラフのx軸ラベル
    var Color = [];
   // var CHART;
    var chart;
    var timer1;
    var PieChart = [];
    var TextData = [];
    var textAnswerData = "";
    var functionhistory ="";//機能の履歴

    
//-------------------------------------------onClick,emit送信
        toSelect = function(){
          self.socket.emit('makeRoom');
            document.body.style.backgroundColor ="#f8f8f8";
            document.getElementById("header_under").style.backgroundColor = "#00a7ea";
          self.vis = 2;
            functionhistory = 2;
        }
        //選択肢問題の回答要請
        getNum = function(){
            $("#choiceNumber_ul").click(function(e){
                var Text = e.target.innerText;
                if( Text == "２つ")Kaitou_Data.SN = 2;
                if( Text == "３つ")Kaitou_Data.SN = 3;
                if( Text == "４つ")Kaitou_Data.SN = 4;
                if( Text == "５つ")Kaitou_Data.SN = 5;
                if( Text == "６つ")Kaitou_Data.SN = 6;
                choiceNumber();
            });
        }
        function choiceNumber(){
            console.log(Kaitou_Data.SN);
            var data = {
                type:'select',
                SN:Kaitou_Data.SN
            };
            console.log(Kaitou_Data.SN);
            self.socket.emit('OtoG',data);
            //棒グラフのデータセット
            for( var i = 0; i < parseInt(Kaitou_Data.SN)+1; i++){
                if( i == 0){
                    columns[i] = "選択肢";
                    Xziku[i] = "x";
                }else{
                    columns[i] = 0;
                    Xziku[i] = i;
                }
            }
            //円グラフのデータセット
            for( var i = 0;i < parseInt(Kaitou_Data.SN);i++){
                PieChart[i] = ["選択肢"+(i+1),0];
            }
            console.log(PieChart);
            self.vis = 3;
            functionhistory = 3;
            self.update();
            chartSet();
        }
        //テキストの回答要請
        toText = function(){
            var data = {
                type:'text',
            };
            self.socket.emit('OtoG',data);
            document.getElementById("header_under").style.backgroundColor = "#99CC00";
            self.vis = 4;
            functionhistory = 4;
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
//            for( var i = 0 ;i < parseInt(document.Q.num.value);i++){
//                var content = document.Q.elements['Q'+(i+1)].value;
//                document.Q.elements['Q'+(i+1)].value = "";
//                self.QselectContent[i] = {num:i,content:content};
//            }
            for( var i = 0;i < 4;i++){
                var content = document.getElementById("Answer"+i).value;
                self.QselectContent[i] = {num:i,content:content};
            }
            //Kaitou_Data.SN = document.Q.num.value;//選択肢数//グラフ描画する場合
            //グラフ描画しない場合var sentakusi = document.Q.num.value;
            Kaitou_Data.SN = 4;//選択肢の数を固定の場合
            //var Question = document.Q.question.value;//選択肢を選べる場合の問題文
            var Question = document.getElementById( "Qtext" ).value ;//選択肢固定問題文
            var Time = document.getElementById("Time").value*60;//制限時間
            var data = {
                type:'createQ',
                SN:Kaitou_Data.SN,//グラフ描画する場合//グラフ描画しない場合sentakusi,//選択肢の数
                Q:Question,//問題文
                QContent:self.QselectContent,//選択肢、選択肢の項目
                Time:Time//制限時間
            }
            console.log(data);
            self.socket.emit('OtoG',data);
//            document.Q.num.value = "";
//            document.Q.question.value ="";
//            document.Q.Time.value = "";
            self.selectNumber.length = 0;
            //棒グラフのデータセット
            for( var i = 0; i < parseInt(Kaitou_Data.SN)+1; i++){
                if( i == 0){
                    columns[i] = "選択肢";
                    Xziku[i] = "x";
                }else{
                    columns[i] = 0;
                    Xziku[i] = i;
                }
            }
            //円グラフのデータセット
            for( var i = 0;i < parseInt(Kaitou_Data.SN);i++){
                PieChart[i] = ["選択肢"+(i+1),0];
            }
            self.vis = 5;
            self.update();
            chartSet();
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
                Date_Zero();
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
            document.getElementById("header_under").style.backgroundColor = "#00a7ea";
            self.finishedAnswer = 0;//回答者数リセット
            functionhistory = 2;//機能履歴を２にする
        }
        //退室
        toClose = function(){
            var data = {
                type:'close'
            }
            self.socket.emit('OtoG',data);
            location.href = 'http://0.0.0.0:3000/';
        }
        //画面遷移
        //機能ページへ
        toFunction = function(){
            if( functionhistory == 2){
                self.vis = 2;//機能履歴を２にする
            }
            if( functionhistory == 3){
                self.vis = 3;//機能履歴を３にする
            }
            if( functionhistory == 4){
                self.vis = 4;//機能履歴を４にする
            }
        }
        //カスタムページへ
        toCustom = function(){
            self.vis = 6;
        }
        //URLページへ
        toURL = function(){
            self.vis = 7;
        }
        //選択肢回答をファイルでダウンロード
            shot2 = function(){
                //svgをcanvas変換,png変換でダウンロード
//        var G = document.getElementById('chart').innerHTML;
//        console.log(G);
//
//
//  //load a svg snippet in the canvas with id = 'drawingArea'
//  canvg(document.getElementById('canvas'), G);
//          
//            var link = document.createElement('a');
//            link.href = canvas.toDataURL();
//            link.download = 'TextAnswer.png';
//            link.click();
        html2canvas(//document.getElementById('result'), 
            document.body,{
            onrendered: function(canvas) {
                var link2 = document.createElement('a');
                link2.href = canvas.toDataURL();
                link2.download = "SelectAnswer.png";
                link2.click();
                //document.body.appendChild(canvas);
            }
        });

    }
        //テキスト回答をファイルでダウンロード
        shot = function(){
            for( var i = 0;i < TextData.length;i++){
                AD += "名前:"+TextData[i][0]+",　　　回答："+TextData[i][1]+"\n";
            }
            var text = textAnswerData;
            var blob = new Blob([text], { "type" : "text/csv" });    
            var link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'TextAnswer.csv';
            link.click();
            textAnswerData = "";
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
        self.socket.on('GtoO',function(DATA){
            //選択回答の受信
            if( DATA.type == 'select_answer'){
                //棒グラフ、円グラフの回答集計
                if ( DATA.kaitou){
                    columns[DATA.kaitou] = columns[DATA.kaitou] + 1;
                    PieChart[DATA.kaitou-1][1] = PieChart[DATA.kaitou-1][1] + 1;
                }
                if(self.finishedAnswer == 0){
                     chartResult();
                }
            }
            //テキスト回答の受信
            if(DATA.type == 'text_answer'){
                TextData.push([DATA.Name,DATA.Answer]);
                console.log(DATA.Answer);
                self.textAnswer.push({Name:DATA.Name,Answer:DATA.Answer});
            }
            //作成問題の回答受信
            if(DATA.type == 'createQ_answer'){
                if ( DATA.kaitou){
                    columns[DATA.kaitou] = columns[DATA.kaitou] + 1;
                    PieChart[DATA.kaitou-1][1] = PieChart[DATA.kaitou-1][1] + 1;
                }
                if(self.finishedAnswer == 0){
                     chartResult();
                }
                var Correct = 0;//正解数
                if(DATA.kaitou == self.answerNum){
                    Correct = Correct + 1;//回答と正解番号が一致したら正解数をプラス1
                }
                var rank = 1;//順位変数
                var AnswerData = {//回答者データ
                    Rank:rank,
                    Name:DATA.Name,//名前
                    Answer:DATA.kaitou,//回答番号
                    Time:DATA.zikan,//回答時間
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
        function Date_Zero(){
            columns.length = 0;
            Xziku.length = 0;
            console.log(columns);
            console.log(Xziku);
        }
    //チャートセット
    function chartSet(){
        var chart = c3.generate({
                         //bindto: "#test",
                         data: {
                             x:'x',
                             columns:[
                                 Xziku,
                                 columns
                             ],
                             type: 'bar' 
                         },
                         legend: {
                             show: false
                         },
                         width: {
                             ratio: 0.1 
                         },
                         axis: {
                              y: {
                                show:false
                              }
                        }
                     });
    }
    //チャート結果
    function chartResult(){
        var D = parseInt(Kaitou_Data.SN);
        var C = columns.shift();
        var B = Math.max.apply(null,columns);
        var A = columns.indexOf(B);
        for( var i = 0; i < D;i++){
                if( columns[i] == B){
                    Color[i] = '#ff7f0e';
                }else{
                    Color[i] = '#1f77b4';
                }
        }
            
//            if( columns[D] > columns[i]){
//                Color[D+1] = '#ff7f0e';
//            }else{
//                Color[i] = '#1f77b4';
//            }

        columns.unshift(C);
        console.log(Color);
        chart = c3.generate({
                         //bindto: "#test",
                         data: {
                             x:'x',
                             columns:[
                                 Xziku,
                                 columns
                             ],
                             labels:true,
                             color:function(color,d){
                                    return Color[d.index];    
                            },
                             type: 'bar' 
                         },
                         legend: {
                             show: false 
                         },
                         width: {
                             ratio: 0.1 
                         },
                        axis: {
                              y: {
                                show:false
                              }
                        }
                          
                     });
                    timer1 = setInterval(function () {
                        C = columns.shift();
                        B = Math.max.apply(null,columns);
                        A = columns.indexOf(B);
                        for( var i = 0; i < D;i++){
                                if( columns[i] == B){
                                    Color[i] = '#ff7f0e';
                                }else{
                                    Color[i] = '#1f77b4';
                                }
                        }
                        columns.unshift(C);
                        chart.load({
                            color:function(color,d){
                                    return Color[d.index];    
                            },
                            columns:[
                                 Xziku,
                                 columns
                             ],
                            type: 'bar'
                        });
                    }, 3000);
        
    }
    toPieChart = function (){
        clearInterval(timer1);
        chart = c3.generate({
    data: {
        // iris data from R
        columns: PieChart,
        type : 'pie',
    }
});
        timer1 = setInterval(function () {
                        chart.load({
                            columns:PieChart,
                            type: 'pie'
                        });
                    }, 3000);
    }
    tobarChart = function (){
        clearInterval(timer1);
        chart = c3.generate({
                         //bindto: "#test",
                         data: {
                             x:'x',
                             columns:[
                                 Xziku,
                                 columns
                             ],
                             labels:true,
                             color:function(color,d){
                                    return Color[d.index];    
                            },
                             type: 'bar' 
                         },
                         legend: {
                             show: false 
                         },
                         width: {
                             ratio: 0.1 
                         },
                        axis: {
                              y: {
                                show:false
                              }
                        }
                          
                     });
                    timer1 = setInterval(function () {
                        chart.load({
                            columns:[
                                 Xziku,
                                 columns
                             ],
                            type: 'bar'
                        });
                    }, 3000);
    }
    
    
    hanbaga = function(){
        var hanbaga_menu = document.getElementById("hanbaga_menu");
       if(hanbaga_menu.className === 'menu-open') {
           hanbaga_menu.className = '';
       }else{
           hanbaga_menu.className = 'menu-open';
       }
       
    }
    
</script>
 <!-- style -->
  <style scoped>
      .c3-text {
          font-size:50px;
      }
/*      icon*/
      .room_number{
          font-size:40px;
      }
      .room_number span{

          font-size:20px;
      }
      .icon_user{
          font-size:50px;
          display:block;
      }
      .barpie{
          font-size:40px;
          margin-right:15px;
          margin-bottom:10px;
      }
/*     これより上はチャート描写*/
/*     -------------------------------header部分*/
      header{
          background: #333300;
          padding-top:10px;
          padding-bottom:10px;
          height:25px;
            
      }
      #header{
          position: fixed;
          top:0px;
          right:0px;
          bottom:0px;
          width:100%;
          height:50px;
          z-index: 4;
      }
/*     ーーーーーーーーーーーーーーーーーーーーーーー ハンバーガーメニュ*/
      #hanbaga_menu{
/*          background: #333300;*/
          background:#00a7ea;
          padding-top:10px;
          padding-bottom:10px;
          height:25px;
          z-index:4;
          position:absolute;
          top:0px;
          transition: .4s;
          width:100%;
      }
      .hanbaga{
          display:none;
      }
      #show{
          
      }
      .munu_han{
          text-align: left;
      }
      .menuhan{
          padding:0 5px;
          text-align: center;
          display:inline-block; 
          font-size:15px;
          font-weight:bold;
          color:white;
          vertical-align: middle;
          
      }
      .menuhan:hover{
          cursor: pointer;
      }
      
/*      ーーーーーーーーーーーーーーーーーーーーーー*/
      .menu_ul{
          text-align:center;
      }
      .menu{
          display:inline-block; 
          font-size:15px;
          font-weight:bold;
          width:100px;
          color:white;
          vertical-align: middle;
          
      }
      .menu_ul2{
          text-align:left;
          display: inline;
      }
      .menu2{
          text-align: center;
          display:inline-block; 
          font-size:15px;
          font-weight:bold;
          width:100px;
          color:white;
          vertical-align: middle;
      }
      .menu2:hover{
          cursor: pointer;
          background: white;
          
      }
      .menu_ul3{
          text-align:right;
          display:inline;
      }
      .menu3{
          text-align: center;
          display:inline-block; 
          font-size:15px;
          font-weight:bold;
          width:130px;
          color:white;
          vertical-align: middle;
          
      }
      .menu:hover{
          background:#00a7ea;
          border-radius:5px;
          width:100px;
          height:20px;
      }
      #header_under{
          height:5px;
          background:#00a7ea;
          z-index: 2;
      }
/*      -----------------------------------#body部分*/
      #body{
          height:100%;
          min-height:100%;
          width:100%;
/*          margin-top:50px;*/
          z-index: 2;
/*          background:#f8f8f8;*/
      }
      .gestNumber_text{
          letter-spacing: 1em;
          margin-left: 45px;
          margin-top: 10px;
      }
      .top{
          display: table;
          height:100%;
          margin:0 auto;
      }
      .content_center{
          display:table-cell;
          vertical-align: middle;
      }
      .entry{
          font-size:100px;
          color:white;
          font-family: 'Raleway', sans-serif;
          
      }
      .URL{
          font-size:150px;
          font-weight: bold;
          color:black;
          font-family: 'Raleway', sans-serif;
          
      }
      .function{
          display:inline-block;
          margin-top:10px;
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
      .padding-top{
          padding-top:50px;
      }
      .margin-top{
          margin-top: 50px;
      }
      .main{
/*          width:500px;*/
          word-wrap: break-word;
          text-align: center;
          height:70%;
      }
      #test{
          width:100%;
          height:100%;
      }
      #result{
          width: 100%;
          height:70%;
	margin: 40px auto;
	line-height:180%;
          overflow:scroll;
/*
          border:1px solid #00a7ea;
          width:500px;
          height:100%;
          margin:0 auto;
*/
      }
      #chart{
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
/*選択肢自由問題作成
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
*/

      @media screen and ( max-width:600px ){
          .menu_ul2{
              display: none;
          }
          .hanbaga{
              color:white;
              float:left;
              margin-left:10px;
              font-size:x-large;
              display:block;
              cursor: pointer;
          }
          .hanbaga:hover{
              cursor:pointer;
          }
          #hanbaga_menu.menu-open{
              top:45px;
          }  
          .entry{
          font-size:14vw;
          
      }
      }
section table   { width: 100%;
      word-break:break-all;}
section th, section td  { padding: 10px; border: 1px solid #ddd; }
section th  { background: #f4f4f4; }
section td  { text-align: left; }
 
/*----------------------------------------------------
    .demo01
----------------------------------------------------*/
.demo01 th  { width: 30%; text-align: left; }
 
@media only screen and (max-width:480px){
/*
    #result{
        width:100%;
    }
*/
    .demo01 { margin: 0 -10px; 
    word-wrap: break-word;}
    .demo01 th,
    .demo01 td{
        width: 100%;
        display: block;
        border-top: none;
    }
    .demo01 tr:first-child th   { border-top: 1px solid #ddd; }
} 


  </style>
</owner>