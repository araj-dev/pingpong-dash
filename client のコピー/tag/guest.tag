<guest>
<div id="header">
        <header>
          <ul class="menu_ul" if={vis==2||vis==3||vis==4||vis==5||vis==6}>
              <li class="menu width">ようこそ！<span>{Name}</span>さん</li>
              <li class="room_number menu"><span>部屋番号:</span>{Room}</li>
          </ul>   
        </header>
        <div id="header_under"> 
        </div>
</div>
<!--1ページ目-->
<div id="body">
<div if={ vis == 1}  class="top">
<div class="content_center">
<!-- form starts here -->
<form class="sign-up">
<div class="username">
   <h1 class="login_title">Entrance</h1>
    <input type="text" id="roomcode" placeholder="部屋番号"/>
  </div>
  <div class="password">
    <input type="text"  id="username"placeholder="名前"/>
  </div>
  </form>
    <span class="button-dropdown" data-buttons="dropdown">
    <a onclick={toWait} class="button button-rounded button-flat-action pointer">入室 </a>
    </span>
</div>
</div>
<!--2ページ目-->
<div if={ vis == 2} class="top">
<div class="content_center">
    <div class="select"><p>待機中</p></div>
<!--    <p onclick={toClose} class="link">退室</p>-->
    <a onclick={toClose} class="button button-border pointer margin_back">退室</a>
</div>

</div>
<!--3ページ目　選択問題の回答ページ-->
<div if={ vis == 3} class="top Select_width">
<div class="content_center">
    <div class="select"><p class="Behavior">選ぶ</p>
    <a class="buttonSelect pointer"  each={choice} onclick={toResult_choice}>{number}</a>
<!--	<a class="twitter"  each={choice} onclick={toResult_choice}>{number}</a>-->
   </div>
<!--    <a onclick={toClose} class="button button-border">退室</a>-->
</div>
</div>
<!--3ページ目　テキスト問題の回答ページ-->
<div if={ vis == 4} class="top">
   <div class="content_center">
   <div class="select">
   <p class="Behavior">テキスト記入</p>
    <form name="text">
        <textarea name="answer" id="textAnswer" cols="30" rows="6" maxlength="140"></textarea><br>
        <span class="button-dropdown" data-buttons="dropdown">
       <a onclick={toResult_text} class="button button-rounded button-flat-action pointer">送信</a>
       </span>
    </form>
</div>
</div>
</div>
<!--3ページ目　作成問題の回答ページ-->
<div if={ vis == 5} class="top Select_width">
<!--    選択肢数非固定-->
<!--    <p each={choice} onclick={toResult_createQ} class="link" >{number}-{content}</p>-->
<!--
<div class="buttons margin"  each={choice}>
    <a class="twitter" onclick={toResult_choice}>{number}<br><span>{content}</span></a>
   </div>
-->
   
   
   <div class="content_center">
    <div class="select">
    <p class="CreateQ">{Q}</p>
    <p class="CreateTime">制限時間:<span id="time"></span>秒</p>
    <a class="buttonCreate pointer"  each={choice}  onclick={toResult_createQ}><span class="CreateNum">{number}</span>{content}</a>

   </div>

</div>



</div>
<!--4ページ目　回答送信後の待ち-->
<div if={ vis == 6 } class="top">

    <div class="content_center">
    <div class="wait"><p class="Behavior">待機中</p></div>
    <div id="resultText">
<section id="sec01">
    <table class="demo01">
            <tr each={textAnswer}>
                <th>回答</th>
                <td>{Answer}</td>
            </tr>
    </table>
</section>
       </div>
    <a onclick={toClose} class="button button-border pointer margin_back">退室</a>
</div>
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
    self.Name;//回答者
    self.Room;//部屋番号
    self.answerFinish = false;//回答済みか判定
    var setAnswerTime = 0;

//----------------------------------------mount,socket.on受信
    this.on('mount',function(){
        self.socket.on('joinResult',function(data){
            //ルームコード確
            if( data.result == 0){
              alert("番号が違います");
            }
            if( data.result == 1){
                if(self.Name == ""){
                    self.Name = data.name;
                }
              self.vis = 2;
              self.update();
                document.body.style.backgroundColor ="#f8f8f8";
                document.getElementById("header_under").style.backgroundColor = "#333300";
            }
            
            console.log(data.name);
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
                document.getElementById("header_under").style.backgroundColor = "#00a7ea";
                self.vis=3;
                self.update();
            }
            //テキスト問題受信
            if(data.type == 'text'){
                self.title = "テキスト入力";
                self.answerFinish = false;//未回答へ変更
                self.vis=4;
                document.getElementById("header_under").style.backgroundColor = "#99CC00";
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
                document.getElementById("header_under").style.backgroundColor = "#E34933";
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
        self.Name = guestdata.username;
        self.Room = guestdata.roomname;
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
        document.getElementById("header_under").style.backgroundColor = "#333300";
        self.vis = 6;
        self.update();
    }
    //テキスト問題回答
    toResult_text = function(){
        Answer = document.text.answer.value;
        data = {
            type:'text_answer',
            Name:self.Name,
            Answer:Answer,
        }
        self.socket.emit("GtoO",data);
        document.text.answer.value ="";
        self.answerFinish　=true;//回答済みに変更
        document.getElementById("header_under").style.backgroundColor = "#333300";
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
      }.menu_ul{
          text-align:center;
      }
      .menu{
          display:inline-block; 
          font-size:15px;
          
          width:170px;
          color:white;
          vertical-align: middle;
          
      }
      .width span{
          font-weight:bold;
      }
      .width{
          width:200px;
      }
      #header_under{
          height:5px;
          background:#00a7ea;
      }
      /*      -----------------------------------ログイン*/

/*


html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed,
figure, figcaption, footer, header, hgroup,
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}
*/
/*

article, aside, details, figcaption, figure,
footer, header, hgroup, menu, nav, section {
  display: block;
}
*/



/*
* Author: Pali madra
 * URI: http://www.agilewebsitedev.com
                   and
         http://www.agileseo.net
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */


.sign-up {
  position: relative;
  margin: 50px auto;
  width: 280px;
  padding: 33px 25px 29px;
  background: white;
  border-bottom: 1px solid #c4c4c4;
  border-radius: 5px;
  -webkit-box-shadow: 0 1px 5px rgba(0, 0, 0, 0.25);
  box-shadow: 0 1px 5px rgba(0, 0, 0, 0.25);
}
      input {
  height: 1.25em;
  width: 8.125em;
  font-size: 20px;
          padding:10px 30px;
  text-align:center;
  border: 0;
  outline: 0;
  color: black;
  background: transparent;
  border:0.033em #00a7ea solid;
          margin-bottom:10px;
          
}
      .login_title{
          margin: -40px -25px 25px;
          border-top-right-radius:5px;
          border-top-left-radius:5px;
  padding: 15px 25px;
  line-height: 35px;
  font-size: 50px;
  font-weight: 300;
  color: white;
  text-align: center;
/*  text-shadow: 0 1px rgba(255, 255, 255, 0.75);*/
  background: #285294;
      }
::placeholder {
  color: #00a7ea;
}

::-moz-placeholder {
  color: #00a7ea;
}

:-ms-input-placeholder {
  color: #00a7ea;
}

::-webkit-input-placeholder {
  color: #00a7ea;
}




      /*      -----------------------------------#body部分*/
/*
      .buttons {
          vertical-align: middle;
          display: inline;
}
        .buttons a {
                               background: #222;
  color: white;
  text-shadow: 2px 2px 3px rgba(255,255,255,0.1);
            font-size:30px;
            
    
            text-decoration: none;
	margin-right: 10px;
	margin-left: 10px;
	margin-top: 10px;
	margin-bottom: 10px;
            
	width: 64px;
	height: 64px;
	display: inline-block;
	position: relative;
	line-height: 64px;
	background-color: #eaeaea;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#72bedd), to(#00a7ea));
	background-image: -webkit-linear-gradient(top, #72bedd, #00a7ea);
	background-image: -moz-linear-gradient(top, #f6f6f6, #eaeaea); 
	background-image: -ms-linear-gradient(top, #f6f6f6, #eaeaea); 
	background-image: -o-linear-gradient(top, #f6f6f6, #eaeaea);
	background-image: linear-gradient(top, #f6f6f6, #eaeaea);
	-moz-border-radius: 32px;
	-webkit-border-radius: 32px;
	border-radius: 32px;
	-moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .25), 0 2px 3px rgba(0, 0, 0, .1);
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .25), 0 2px 3px rgba(0, 0, 0, .1);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .25), 0 2px 3px rgba(0, 0, 0, .1);
}
        .buttons a:active {
	top: 1px;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#00a7ea), to(#72bedd));
	background-image: -webkit-linear-gradient(top, #00a7ea, #72bedd);
	background-image: -moz-linear-gradient(top, #eaeaea, #f6f6f6); 
	background-image: -ms-linear-gradient(top, #eaeaea, #f6f6f6); 
	background-image: -o-linear-gradient(top, #eaeaea, #f6f6f6);
	background-image: linear-gradient(top, #eaeaea, #f6f6f6);
}
      .buttons a::before{
	content: '';
	position: absolute;
	z-index: -1;
	top: -8px;
	right: -8px;
	bottom: -8px;
	left: -8px;
	background-color: #eaeaea;
	-moz-border-radius: 140px;
	-webkit-border-radius: 140px;
	border-radius: 140px;
	opacity: 0.5;		
}
        .buttons a:active::before {
	top: -9px;
}
 
.buttons a:hover::before {
	opacity: 1;
}
        .buttons a.twitter:hover::before {
	background-color: #c6f0f8;
}
      .twitter span{
          color:black;
      }
      .margin{
          margin-left:50px;
          margin-right:50px;
      }
 
.buttons a.facebook:hover::before {
	background-color: #dae1f0;
}
 
.buttons a.dribble:hover::before {
	background-color: #fadae6;
}
 
.buttons a.rss:hover::before {
	background-color: #f8ebb6;
}
        .twitter img {
	vertical-align: -7px;
}
 
.dribble img {
	vertical-align: -12px;
}
 
.facebook img {
	vertical-align: -12px;
}
 
.rss img {
	vertical-align: -7px;
}
*/
/*      選択問題ボタン*/
      .buttonSelect {
        position:relative;
	display:block;
	padding:1em 0;
	color:#fff;
	font-size:88%;
	border-radius:3px;
	text-align:center;
	line-height: 22px;
	text-decoration: none;
	text-shadow:1px 1px 0 rgba(255,255,255,0.3);
        background:#00acee;
	box-shadow:0 5px 0 #0092ca;
          margin-top:10px;
          margin-bottom:10px;
}

        
        
      .buttonSelect:hover{
          -webkit-transform: translate3d(0px, 5px, 1px);
	-moz-transform: translate3d(0px, 5px, 1px);
	transform: translate3d(0px, 5px, 1px);
	box-shadow:none;
            background:#0092ca;
      }
      .buttonCreate:hover {
   -webkit-transform: translate3d(0px, 5px, 1px);
	-moz-transform: translate3d(0px, 5px, 1px);
	transform: translate3d(0px, 5px, 1px);
	box-shadow:none;
            background:#0092ca;
}
            .buttonCreate {
        position:relative;
	display:block;
	padding:1em 0;
	color:#fff;
	font-size:2vw;
	border-radius:3px;
	text-align:left;
	line-height: 22px;
	text-decoration: none;
	text-shadow:1px 1px 0 rgba(255,255,255,0.3);
        background:#00acee;
	box-shadow:0 5px 0 #0092ca;
          margin-top:10px;
          margin-bottom:10px;
}

        
      /*      退室ボタンのマージン*/
      .margin_back{
          margin-top:20px;
      }
      /*      -----------------------------------#body部分*/
      #body{
          height:100%;
          min-height:100%;
          width:100%;
/*          margin-top:49px;*/
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
      .padding-top{
          padding-top:50px;
      }
      .main{
/*          width:500px;*/
          word-wrap: break-word;
          text-align: center;
          height:70%;
      }
      #result{
          width: 80%;
          height:70%;
	margin: 40px auto;
	line-height:180%;
      }
      #roomcode{
      }
      #resultText{
          width: 80%;
	margin: 0px auto;
	line-height:180%;
      }
      #roomcode{
      }
      .select{
          overflow: scroll;
          height:70%;
/*
          border-top:1px solid #00a7ea;
          border-bottom:1px solid #00a7ea;
*/
          margin-top:20px;
          padding:20px;
          margin-bottom:15px;
      }
      .wait{
          overflow: scroll;
          height:250px;
/*
          border-top:1px solid #00a7ea;
          border-bottom:1px solid #00a7ea;
*/
          margin-top:20px;
          padding:20px;
          margin-bottom:15px;
      }
      .Behavior{
          font-size:20px;
          margin-bottom:20px;
      }
      .Select_width{
          width:80%;
      }
      .CreateQ{
          text-align: left;
          font-size: 4vw;
          margin-top: 10px;
          margin-bottom: 10px;
      }
      .CreateNum{
          margin-left: 10px;
          margin-right: 30px;
      }
      .CreateTime{
          font-size: 3vw;
      }
      #index{
          margin-top:10px;
          margin-bottom:10px;
      }
      #index span{
          margin-left:100px;
          max-width: 300px;
      }
      #textAnswer{
          font-size:20px;
          margin-bottom:20px;
      }
      /*      ボタンホバー時のポインタ*/
      .pointer{
          cursor:pointer;
      }
      /*      退室ボタンのマージン*/
      .margin_back{
          margin-top:15px;
          width:165px;
      }
      
      
      @media screen and ( min-width:600px ){
          .Select_width{
              width:600px;
          }
          .CreateQ{
              font-size:20px; 
          }
          .CreateTime{
              font-size:15px;
          }
          .buttonCreate{
              font-size:15px;
          }
      }
section table   { width: 100%;
      word-break:break-all;}
section td  { text-align: center; }
 
/*----------------------------------------------------
    .demo01
----------------------------------------------------*/
.demo01 th  { width: 30%; text-align: center; }
 
@media only screen and (max-width:480px){
    #result{
        width:100%;
    }
    .demo01 { margin: 0 auto; 
    word-wrap: break-word;}
    .demo01 th,
    .demo01 td{
        width: 100%;
        display: block;
        border-top: none;
    }
} 
  </style>
</guest>
