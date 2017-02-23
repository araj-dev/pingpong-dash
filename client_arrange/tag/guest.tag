<guest>
    <div id="header">
        <header if={vis==2||vis==3||vis==3.1||vis==4||vis==4.1||vis==5||vis==6}>
            <ul class="menu_ul" if={vis==2||vis==3||vis==3.1||vis==4||vis==4.1||vis==5||vis==6}>
                <li class="menu width">ようこそ！<span>{Name}</span>さん</li>
                <li class="room_number menu min_width_none"><span>部屋番号:</span>{Room}</li>
            </ul>
        </header>
        <div id="header_under">
        </div>
    </div>
    <!--1ページ目-->
    <div id="body">
        <div if={ vis==1 } class="top">
            <div class="content_center">
                <!-- form starts here -->
                <form class="sign-up">
                    <div class="username">

                        <input type="text" id="roomcode" placeholder="部屋番号" />
                    </div>
                    <div class="password">
                        <input type="text" id="username" placeholder="名前" />
                    </div>
                    <p onclick={toWait} class="entry_room pointer">入室</p>
                    <a href="javascript:history.back();" class="Q_plus_minus">
                        <p class="back_room pointer">戻る</p>
                    </a>
                </form>
            </div>
        </div>
        <!--2ページ目-->
        <div if={ vis==2 } class="top">
            <div class="content_center">
                <div class="guest_select">
                    <p>お待ち下さい</p>
                </div>
                <!--    <p onclick={toClose} class="link">退室</p>-->
                <!--    <a onclick={toClose} class="button button-border pointer margin_back">退室</a>-->
                <p onclick={toClose}　class="getout pointer base_buttom">退室</p>
            </div>

        </div>
        <!--3ページ目　選択問題の回答ページ-->
        <div if={ vis==3 } class="top Select_width">
            <div class="content_center">
                <div class="guest_select">
                    <p class="Behavior">選ぶ</p>
                    <a class="buttonSelect pointer" each={choice} onclick={toResult_choice}>{number}</a>
                </div>
            </div>
        </div>
        <!--3ページ目　テキスト問題の回答ページ-->
        <div if={ vis==4 } class="top">
            <div class="content_center">
                <div class="guest_select">
                    <p class="base_result_title text_result_color Behavior">回答記入</p>
                    <form name="text">
                        <textarea name="answer" id="textAnswer" cols="30" rows="10" maxlength="140"></textarea><br>
                        <span class="button-dropdown" data-buttons="dropdown">
       <p  onclick={toResult_text}　class="text_send pointer base_buttom">送信</p>
       </span>
                    </form>
                </div>
            </div>
        </div>
        <!--3ページ目　事前作成済み、選択式問題の回答ページ-->
        <div if={ vis==3 .1} class="top Select_width">
            <div class="content_center　Qpadding-top">
                <div class="guest_select pb_height">
                    <p class="CreateQ base_Q_content choice_Q_content_color">{Q}</p>
                    <a class="buttonCreate pointer" each={choice} onclick={toResult_prebuild_num}><span class="CreateNum CreateNum_width">
       <table class="prebuild_table_number">
           <tr>
               <td class="pb_table_td">{number}</td>
               <td>{content}</td>
           </tr>
       </table>
       </span>
       </a>

                </div>

            </div>



        </div>
        <!--3ページ目　事前作成済み、テキスト式問題の回答ページ-->
        <div if={ vis==4 .1} class="top Select_width">
            <div class="content_center　Qpadding-top">
                <div class="guest_select pb_height">
                    <p class="CreateQ base_Q_content text_Q_content_color">{Q}</p>
                    <form name="text">
                        <textarea name="answer" id="textAnswer" cols="30" rows="10" maxlength="140"></textarea><br>
                        <span class="button-dropdown" data-buttons="dropdown">
       <p  onclick={toResult_text}　class="text_send pointer base_buttom">送信</p>
       </span>
                    </form>

                </div>

            </div>



        </div>
        <!--3ページ目　作成問題の回答ページ-->
        <div if={ vis==5 } class="top Select_width">
            <!--    選択肢数非固定-->


            <div class="content_center">
                <div class="guest_select">
                    <p class="CreateQ">{Q}</p>
                    <p class="CreateTime">制限時間:<span id="time"></span>秒</p>
                    <a class="buttonCreate pointer" each={choice} onclick={toResult_createQ}><span class="CreateNum">{number}</span>{content}</a>

                </div>

            </div>



        </div>
        <!--4ページ目　回答送信後の待ち-->
        <div if={ vis==6 } class="top">

            <div class="content_center">
                <div class="wait">
                    <p class="Behavior">お待ち下さい</p>
                    <div id="resultText">
                    </div>
                </div>
                <p onclick={toClose}　class="getout pointer base_buttom">退室</p>
            </div>
        </div>
    </div>
    <!--スクリプト-->
    <script>
        var self = this;
        self.socket = io.connect();
        self.choice = [];
        self.index;
        self.vis = 1;
        self.Answer; //回答
        var guestdata = {}; //ゲストデータ
        self.Name; //回答者
        self.Room; //部屋番号
        self.answerFinish = false; //回答済みか判定
        var setAnswerTime = 0;

        //----------------------------------------mount,socket.on受信
        this.on('mount', function() {
            self.socket.on('joinResult', function(data) {
                //ルームコード確
                if (data.result == 0) {
                    alert("番号が違います");
                }
                if (data.result == 1) {
                    if (self.Name == "") {
                        self.Name = data.name;
                    }
                    self.vis = 2;
                    self.update();
                    document.body.style.backgroundColor = "#f8f8f8";
                    document.getElementById("header_under").style.backgroundColor = "#333300";
                }

                console.log(data.name);
            });
            self.socket.on('count', function(data) {
                console.log(data);
                console.log("A");
            });
            self.socket.on('OtoG', function(data) {
                //選択肢問題受信
                if (data.type == 'select') {
                    self.choice.length = 0;
                    for (var i = 0; i < data.SN; i++) {
                        self.choice[i] = {
                            number: i + 1
                        };
                    }
                    self.title = "選ぶ";
                    console.log(self.choice);
                    self.answerFinish = false; //未回答へ変更
                    document.getElementById("header_under").style.backgroundColor = "#00a7ea";
                    self.vis = 3;
                    self.update();
                }
                //テキスト問題受信
                if (data.type == 'text') {
                    self.title = "テキスト入力";
                    self.answerFinish = false; //未回答へ変更
                    self.vis = 4;
                    document.getElementById("header_under").style.backgroundColor = "#99CC00";
                    self.update();
                }
                //事前作成済み、選択問題の受信
                if (data.type == 'prebuild_select') {
                    console.log(data);
                    self.choice.length = 0;
                    self.Q = data.Q; //問題文
                    for (var i = 0; i < data.SN; i++) {
                        self.choice[i] = {
                            number: i + 1, //選択肢数
                            content: data.QContent[i].Choice //項目
                        }
                    }
                    self.answerFinish = false; //未回答へ変更
                    document.getElementById("header_under").style.backgroundColor = "#00a7ea";
                    self.vis = 3.1;
                    self.update();
                }
                //事前作成済み、テキスト問題の受信
                if (data.type == 'prebuild_text') {
                    self.Q = data.Q;
                    self.answerFinish = false; //未回答へ変更
                    self.vis = 4.1;
                    document.getElementById("header_under").style.backgroundColor = "#99CC00";
                    self.update();
                }
                //問題文作成問題受信
                if (data.type == 'createQ') {
                    self.choice.length = 0;
                    console.log(data.Time);
                    setAnswerTime = data.Time;
                    count = data.Time;
                    timerID = setInterval(function() {
                        document.getElementById("time").innerHTML = count;
                        count--;
                        if (count < 0) {
                            alert("Time UP!");
                            self.vis = 6;
                            Answer = "未回答";
                            self.answerFinish　 = true; //回答済みに変更
                            clearInterval(timerID);
                            self.update();
                        }
                    }, 1000);
                    self.Q = data.Q; //問題文
                    for (var i = 0; i < data.SN; i++) {
                        self.choice[i] = {
                            number: data.QContent[i].num + 1, //選択肢数
                            content: data.QContent[i].content //項目
                        }
                    }
                    self.title = "選ぶ";
                    self.answerFinish = false; //未回答へ変更
                    document.getElementById("header_under").style.backgroundColor = "#E34933";
                    self.vis = 5;
                    self.update();
                }
                //未回答だが回答締め切りされた場合
                if (data.type == 'deadline') {
                    self.vis = 6;
                    Answer = "未回答";
                    self.answerFinish　 = true; //回答済みに変更
                    self.update();

                }
                //主催者退室した場合
                if (data.type == 'close') {
                    alert('主催者が退室しました。本日はありがとうございました。')
                    location.href = location.origin;
                }


            });
        });
        //-----------------------------------------onClick,emit送信
        toWait = function() {
                guestdata.roomname = document.querySelectorAll('#roomcode')[0].value;
                guestdata.username = document.querySelectorAll('#username')[0].value;
                self.Name = guestdata.username;
                self.Room = guestdata.roomname;
                self.socket.emit('joinRoom', guestdata);
            }
            //選択肢問題回答
        toResult_choice = function(event) {
                var item = event.item;
                self.Answer = [];
                self.Answer = self.choice.indexOf(item) + 1;
                data = {
                    type: 'select_answer',
                    kaitou: self.Answer,
                };
                self.socket.emit('GtoO', data);
                self.answerFinish　 = true; //回答済みに変更
                document.getElementById("header_under").style.backgroundColor = "#333300";
                self.vis = 6;
                self.update();
            }
            //事前作成済み、選択問題回答
        toResult_prebuild_num = function() {
                var item = event.item;
                self.Answer = [];
                self.Answer = self.choice.indexOf(item) + 1;
                data = {
                    type: 'pb_select_answer',
                    kaitou: self.Answer,
                };
                self.socket.emit('GtoO', data);
                self.answerFinish　 = true; //回答済みに変更
                document.getElementById("header_under").style.backgroundColor = "#333300";
                self.vis = 6;
                self.update();
            }
            //テキスト問題回答
        toResult_text = function() {
                self.Answer = [];
                self.Answer = document.text.answer.value;
                data = {
                    type: 'text_answer',
                    Name: self.Name,
                    Answer: self.Answer,
                }
                self.socket.emit("GtoO", data);
                document.text.answer.value = "";
                self.answerFinish　 = true; //回答済みに変更
                document.getElementById("header_under").style.backgroundColor = "#333300";
                self.vis = 6;
                self.update();
            }
            //作成問題の回答
        toResult_createQ = function() {
            var item = event.item;
            self.Answer = [];
            self.Answer = self.choice.indexOf(item) + 1;
            answerTime = setAnswerTime - count;
            data = {
                type: 'createQ_answer',
                Name: guestdata.username,
                kaitou: self.Answer,
                zikan: answerTime
            }
            console.log(data);
            self.socket.emit('GtoO', data);
            self.answerFinish　 = true; //回答済みに変更
            clearInterval(timerID);
            self.vis = 6;
            self.update();
        }
        toClose = function() {
                location.reload();
            }
            //------------------------------------------function
    </script>


    <!-- style -->
    <style scoped>
        .base_result_title {
            height: 30px;
            font-size: 30px;
            padding-left: 20px;
            text-align: left;
            line-height: 1;
        }
        
        .text_result_color {
            color: #3c3c3c;
            border-left: 10px solid #99cc00;
        }
        
        .entry_room {
            background: #285294;
            height: 1.25em;
            width: 330px;
            padding: 10px 0;
            color: white;
            font-size: 20px;
            margin-bottom: 10px;
        }
        
        .back_room {
            background: #FFA103;
            height: 1.25em;
            width: 330px;
            padding: 10px 0;
            color: white;
            font-size: 20px;
        }
        
        .back_room:hover,
        .entry_room:hover {
            opacity: 0.5;
        }
        
        .base_buttom {
            width: 216px;
            height: 32px;
            margin: 0 auto;
            font-size: 14px;
            padding: 0px 25.6px;
            line-height: 30px;
            margin-top: 10px;
        }
        
        .getout {
            border: 2px solid #666;
            color: #666;
        }
        
        .text_send {
            color: white;
            background: #99cc00;
        }
        /*     -------------------------------header部分*/
        
        header {
            background: #333300;
            padding-top: 10px;
            padding-bottom: 10px;
            height: 25px;
        }
        
        #header {
            position: fixed;
            top: 0px;
            right: 0px;
            bottom: 0px;
            width: 100%;
            height: 50px;
        }
        
        .menu_ul {
            text-align: center;
        }
        
        .menu {
            display: inline-block;
            font-size: 15px;
            width: 170px;
            color: white;
            vertical-align: middle;
        }
        
        .width span {
            font-weight: bold;
        }
        
        .width {
            width: 200px;
        }
        
        #header_under {
            height: 5px;
            background: #f8f8f8;
        }
        /*      -----------------------------------ログイン*/
        
        .sign-up {
            margin: 50px auto;
            width: 330px;
            padding: 33px 0px 33px;
            background: #f8f8f8;
        }
        
        input {
            height: 1.25em;
            width: 328px;
            font-size: 20px;
            padding: 10px 0px;
            text-align: center;
            border: 0.033em #285294 solid;
            background: transparent;
            margin-bottom: 10px;
        }
        
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px #f8f8f8 inset;
        }
        
        ::placeholder {
            color: #285294;
        }
        
        ::-moz-placeholder {
            color: #285294;
        }
        
        :-ms-input-placeholder {
            color: #285294;
        }
        
        ::-webkit-input-placeholder {
            color: #285294;
        }
        /*      -----------------------------------#body部分*/
        /*      選択問題ボタン*/
        
        .buttonSelect {
            position: relative;
            display: block;
            padding: 1em 0;
            color: #fff;
            font-size: 88%;
            border-radius: 3px;
            text-align: center;
            line-height: 22px;
            text-decoration: none;
            text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.3);
            background: #00acee;
            box-shadow: 0 5px 0 #0092ca;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        
        .buttonSelect:hover {
            -webkit-transform: translate3d(0px, 5px, 1px);
            -moz-transform: translate3d(0px, 5px, 1px);
            transform: translate3d(0px, 5px, 1px);
            box-shadow: none;
            background: #0092ca;
        }
        
        .buttonCreate:hover {
            -webkit-transform: translate3d(0px, 5px, 1px);
            -moz-transform: translate3d(0px, 5px, 1px);
            transform: translate3d(0px, 5px, 1px);
            box-shadow: none;
            background: #0092ca;
        }
        
        .buttonCreate {
            position: relative;
            display: flex;
            padding: 1em 0;
            color: #fff;
            font-size: 2vw;
            border-radius: 3px;
            text-align: left;
            line-height: 120%;
            text-decoration: none;
            text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.3);
            background: #00acee;
            box-shadow: 0 5px 0 #0092ca;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        /*      退室ボタンのマージン*/
        
        .margin_back {
            margin-top: 20px;
        }
        /*      -----------------------------------#body部分*/
        
        #body {
            height: 100%;
            min-height: 100%;
            width: 100%;
            /*          margin-top:49px;*/
        }
        
        .top {
            display: table;
            height: 100%;
            margin: 0 auto;
        }
        
        .content_center {
            display: table-cell;
            vertical-align: middle;
        }
        
        .link {
            cursor: pointer;
            background: #00a7ea;
            color: white;
            padding: 10px;
            width:
        }
        
        .link:hover {
            color: red;
            cursor: pointer;
        }
        
        .padding-top {
            padding-top: 50px;
        }
        
        .main {
            word-wrap: break-word;
            text-align: center;
            height: 70%;
        }
        
        #result {
            width: 80%;
            height: 70%;
            margin: 40px auto;
            line-height: 180%;
        }
        
        #roomcode {}
        
        #resultText {
            width: 80%;
            margin: 0px auto;
            line-height: 180%;
        }
        
        #roomcode {}
        
        .select {
            overflow: auto;
            height: 70%;
            margin-top: 20px;
            padding: 20px;
            margin-bottom: 15px;
        }
        
        .guest_select {
            height: 70%;
            margin-top: 20px;
            padding: 20px;
            margin-bottom: 15px;
        }
        
        .pb_height {
        }
        
        .wait {
            overflow: auto;
            height: 80%;
            margin-top: 20px;
            padding: 20px;
            margin-bottom: 15px;
        }
        
        .Behavior {
            font-size: 20px;
            margin-bottom: 20px;
        }
        
        .Select_width {
            width: 80%;
        }
        
        .CreateQ {
            text-align: left;
            font-size: 13px;
            margin-top: 2em;
            margin-bottom: 1em;
        }
        
        .CreateNum {
            margin-left: 10px;
            margin-right: 30px;
        }
        
        .CreateNum_width {
            width: 100%;
        }
        
        .CreateTime {
            font-size: 3vw;
        }
        
        #index {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        
        #index span {
            margin-left: 100px;
            max-width: 300px;
        }
        
        #textAnswer {
            font-size: 20px;
            margin-bottom: 20px;
        }
        /*      ボタンホバー時のポインタ*/
        
        .pointer {
            cursor: pointer;
        }
        /*      退室ボタンのマージン*/
        
        .margin_back {
            margin-top: 15px;
            width: 165px;
        }
        /*      回答済み待機中のtable*/
        
        .wait_answer {}
        /*      設問あり問題のデザインバランス用*/
        /*      設問あり問題、設問文デザイン*/
        
        .base_Q_content {
            padding-left: 10px;
            color: #3c3c3c;
        }
        
        .text_Q_content_color {
            border-left: 10px solid #99cc00;
        }
        
        .choice_Q_content_color {
            border-left: 10px solid #00a7ea;
        }
        
        @media screen and ( min-width:600px) {
            .Select_width {
                width: 600px;
            }
            .CreateQ {
                font-size: 15px;
            }
            .CreateTime {
                font-size: 15px;
            }
            .buttonCreate {
                font-size: 15px;
            }
        }
        
        section table {
            width: 100%;
            word-break: break-all;
        }
        
        section td {
            text-align: center;
        }
        /*----------------------------------------------------
    .demo01
----------------------------------------------------*/
        
        .demo01 th {
            width: 30%;
            text-align: center;
        }
        
        @media only screen and (max-width:480px) {
            .entry_room {
                width: 315.59px;
            }
            .back_room {
                width: 315.59px;
            }
            .min_width_none {
                display: none;
            }
            .select {
                padding: 0px;
            }
            .guest_select {
                padding: 0px;
            }
            .test {
                width: 99%;
                margin: 0 auto;
            }
            .sign-up {
                width: 320px;
            }
            input {
                width: 98%;
            }
            #result {
                width: 100%;
            }
            .demo01 {
                margin: 0 auto;
                word-wrap: break-word;
            }
            .demo01 th,
            .demo01 td {
                width: 100%;
                display: block;
                border-top: none;
            }
        }
        /*      事前資料作成選択画面table*/
        
        .prebuild_table_number {
            width: 100%;
        }
        
        .pb_table_td {
            width: 10%;
        }
        /*      a リンク　装飾解除*/
        
        a {
            text-decoration: none;
            color: black;
        }
        
        a:link {
            color: black;
        }
        
        a:visited {}
        
        a:hover {
            color: #00a7ea;
            cursor: pointer;
        }
        
        a:active {}
    </style>
</guest>
