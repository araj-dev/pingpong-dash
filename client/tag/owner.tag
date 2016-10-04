<owner>
    <!--ハンバーガーメニュー-->
    <div id="hanbaga_menu" if={vis==2 ||vis==2.1 ||vis==3 ||vis==4 ||vis==5 ||vis==6||vis==7||vis==8||vis==9||vis==10}>
        <ul class="munu_han">
            <li class="menuhan" onclick={toFunction}>基本機能</li>
            <li class="menuhan" onclick={toPrebuilt}>作成済設問</li>
            <li class="menuhan" onclick={toURL}>URL</li>
        </ul>
    </div>
    <!--        ヘッダー部分-->
    <div id="header">
        <header if={vis==2 ||vis==2.1 ||vis==3 ||vis==4 ||vis==5 ||vis==6||vis==7||vis==8||vis==9||vis==10}>
            <i class="fa fa-bars hanbaga" id="show" if={vis==2 ||vis==2.1 ||vis==5 ||vis==6||vis==7||vis==8||vis==9} onclick={hanbaga}></i>
            <ul class="menu_ul2" if={vis==2 ||vis==2.1 ||vis==5 ||vis==6||vis==7||vis==8||vis==9}>
                <li class="menu2" onclick={toFunction}>基本機能</li>
                <li class="menu2" onclick={toPrebuilt}>作成済設問</li>
                <li class="menu2" onclick={toURL}>URL</li>
            </ul>
            <ul class="menu_ul3" if={vis==2 ||vis==2.1 ||vis==3 ||vis==4 ||vis==5 ||vis==6||vis==7||vis==8||vis==9||vis==10}>
                <li class="menu3"><span>部屋番号:</span>{roomname}</li>
                <li class="fa fa-user icon_user menu3" aria-hidden="true">{guestNumber}</li>
            </ul>
        </header>
        <div id="header_under">
        </div>
    </div>
    <div id="body">
        <!--ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー部屋作成画面-->
        <div if={ vis==1 } class="top">
            <div class="entry content_center">
                <p class="entry_toppage pointer test_margin" onclick={toSelect}>部屋を作成する</p>
                <a href="create.html">
                    <p class="entry_toppage pointer">設問を作成する</p>
                </a>
                <a href="javascript:history.back();">
                    <p class="back_room pointer">戻る</p>
                </a>
            </div>
        </div>
        <!--ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー選択肢、テキスト選択画面-->
        <!--選択・テキスト-->
        <div if={ vis==2 } class="top padding-top">

            <ul class="menu_ul content_center">
                <li class="room_number"><span>部屋番号:</span>{roomname}</li>
                <li class="fa fa-user icon_user gestNumber_text" aria-hidden="true">{guestNumber}</li>
                <li class="function">
                    <span class="button-dropdown" data-buttons="dropdown">
              <a class="button button-rounded button-flat-primary pointer">選択肢     ⬇︎</a>

              <ul class="button-dropdown-menu-below" style="display: none;" id="choiceNumber_ul">
                <li onclick={getNum}><a href="#">２つ</a></li>
                <li onclick={getNum}><a href="#">３つ</a></li>
                <li onclick={getNum}><a href="#">４つ</a></li>
                <li onclick={getNum}><a href="#">５つ</a></li>
                <li onclick={getNum}><a href="#">６つ</a></li>
              </ul>
              </span>
                </li>
                <li class="function"><span class="button-dropdown" data-buttons="dropdown">
  <a onclick={toText} class="button button-rounded button-flat-action pointer"> テキスト </a>
</span></li>
                <li>
                    <label for="file" class="button button-rounded button-flat-caution pointer usepb">
             作成済みの設問を使用する
              
               <input id="file" type="file" onclick={toPrebuilt} style="display:none;"/>
           </label>

                    <li><a onclick={toClose} class="button button-border margin_back pointer">退室</a></li>
            </ul>
        </div>
        <!--ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー事前作成済み-->
        <!--作成済み設問一覧画面-->
        <div class="flex" if={ vis==8 }>
            <div id="flexdiv">
                <label for="file" class="button button-rounded button-flat-caution pointer">
             読み込み
              
               <input id="file" type="file" onchange={loadfile} style="display:none;"/>
           </label>
                <!--           <div id="view"></div>-->
                <table class="prebuild_table">
                    <thead>
                        <tr>
                            <th class="pb01" id="pb01">回答形式</th>
                            <th class="pb02" id="pb02">設問文</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={result_list}>
                            <td>{format}</td>
                            <td onclick={toResult_detaile}>{question}</td>

                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!--作成済み設問詳細確認画面、送信-->
        <div class="flex" if={ vis==9 }>
            <div id="flexdiv">
                <div class="Q">
                    <table class="Qtable">
                        <tr>
                            <td colspan="2" class="table_title">設問文</td>
                        </tr>
                        <tr>
                            <td colspan="2"><textarea type="text" class="question" name="question" rows="7" cols="30"></textarea>
                        </tr>
                        <tr each={name, i in result_detail}>
                            <td class="pb01_detail">{(i+1)}</td>
                            <td class="pb02_detail"><input type="text" class="Coices_text" value={name.Choice}></td>
                        </tr>
                    </table>
                    <a　onclick={toPrebuilt} class="back pointer">←</a>
                        <span class="button-dropdown" data-buttons="dropdown" show={visible}>
                 <a onclick={prebuild_select} class="button button-rounded button-flat-primary pointer">選択肢</a>
                 </span>
                        <span class="button-dropdown" data-buttons="dropdown" hide={visible}>
                 <a onclick={prebuild_text} class="button button-rounded button-flat-action pointer">テキスト</a>
                 </span>
                </div>
            </div>
        </div>
        <!--ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー設問分作成画面-->
        <div if={ vis==6 } class="top padding-top table_width">
            <div id="result_table">
                <table id="Create_table">
                    <tr>
                        <td colspan="3" id="table_title">文章作成</td>
                    </tr>
                    <tr>
                        <td colspan="3"><textarea type="text" id="Qtext" name="question" rows="3"></textarea>
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
                    </tr>
                    <tr>
                        <th>3</th>
                        <th><input type="text" id="Answer2" name="Q3"></th>
                        <th><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R3"></th>
                    </tr>
                    <tr>
                        <th>4</th>
                        <th><input type="text" id="Answer3" name="Q4"></th>
                        <th><input type="radio" name="trueORfalse" onclick={trueORfalse} id="R4"></th>
                    </tr>
                </table>
                <p id="limit">制限時間を入力<input type="text" id="Time" name="Time" class="inputText">分</p>
                <span class="button-dropdown" data-buttons="dropdown">
  <a  onclick={sendCreateQ} class="button button-rounded button-flat-action pointer color">送信</a>
</span> 選択肢選択できる問題作成
                <form name="Q" id="Q">
                    <p>問題文作成</p>
                    <input type="text" id="Qtext" name="question"> 選択肢の数を入力
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
        </div>

        <!--ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー結果画面-->
        <!--選択問題-->
        <div class="flex" if={ vis==3 }>
            <div id="pb_flexdiv">
                <div class="pb_result">
                    <p class="base_result_title choice_result_color">集計結果</p>
                    <div id="chart"></div>
                    <div class="bottom">
                        <img src="./img/pie.png" width="40px" height="auto" onclick={toPieChart} id="pie" class="chart pointer">
                        <img src="./img/bar.png" width="40px" height="auto" onclick={tobarChart} id="bar" class="chart pointer">
                        <img src="./img/data.png" width="15px" height="auto" onclick={shot2} id="shot" class="data pointer"><br>
                        <span class="button-dropdown" data-buttons="dropdown">
                    <a  onclick={backSelect} class="button button-rounded button-flat-primary hover pointer" data-hover="回答を締め切る"><span class="front">回答者数：{finishedAnswer}/{guestNumber}</span></a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!--テキスト問題-->
        <div class="flex" if={ vis==4 }>
            <div id="pb_flexdiv">
                <div class="pb_result">

                    <p class="base_result_title text_result_color">返答</p>
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

                    <div class="bottom">
                        <img src="./img/data.png" width="15px" height="auto" onclick={Textshot} id="shot" class="data pointer" style="
    margin: 0 auto 10px;"><br>
                        <!--            <i class="fa fa-camera-retro pointer" aria-hidden="true" onclick={Textshot}></i>-->
                        <span class="button-dropdown" data-buttons="dropdown">
       <a  onclick={backSelect} class="button button-rounded button-flat-action hover pointer" data-hover="回答を締め切る"><span class="front">{finishedAnswer}/{guestNumber}</span></a>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!--作成済み設問,選択問題-->
        <div class="flex" if={ vis==1 0}>
            <div id="pb_flexdiv">
                <div class="pb_result">
                    <p class="pb_question">{question}</p>
                    <table class="pb_result_choice">
                        <tr each={name, i in result_detail}>
                            <td class="pb01_detail">{(i+1)}</td>
                            <td class="pb02_detail">{name.Choice}</td>
                        </tr>
                    </table>
                    <div id="chart"></div>
                    <div class="bottom">
                        <img src="./img/pie.png" width="40px" height="auto" onclick={toPieChart} id="pie" class="chart pointer">
                        <img src="./img/bar.png" width="40px" height="auto" onclick={tobarChart} id="bar" class="chart pointer">
                        <img src="./img/data.png" width="15px" height="auto" onclick={shot2} id="shot" class="data pointer"><br>
                        <span class="button-dropdown" data-buttons="dropdown">
                           <a  onclick={backSelect} class="button button-rounded button-flat-primary hover pointer" data-hover="回答を締め切る"><span class="front">回答者数：{finishedAnswer}/{guestNumber}</span></a>
                        </span>
                        </div>
                </div>

            </div>
        </div>
        <!--作成済み設問,テキスト問題-->
        <div class="flex" if={ vis==1 1}>
            <div id="pb_flexdiv">
                <div class="pb_result">
                    <h1>返答</h1>
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

                    <div class="bottom">
                        <i class="fa fa-camera-retro pointer" aria-hidden="true" onclick={Textshot}></i><br><br>
                        <span class="button-dropdown" data-buttons="dropdown">
       <a  onclick={backSelect} class="button button-rounded button-flat-action hover pointer" data-hover="回答を締め切る"><span class="front">{finishedAnswer}/{guestNumber}</span></a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!--作成問題-->
        <div if={ vis==5 }>
            <div id="chart"></div>
            <i onclick={toPieChart} class="fa fa-pie-chart barpie  pointer" aria-hidden="true"></i>
            <i onclick={tobarChart} class="fa fa-bar-chart barpie  pointer" aria-hidden="true"></i><i class="fa fa-camera-retro pointer" aria-hidden="true" onclick={shot2} id="shot"></i><br>
            <span class="button-dropdown" data-buttons="dropdown">
              <a  onclick={backSelect} class="button button-rounded button-flat-primary pointer color hover" data-hover="回答を締め切る"><span class="front">{finishedAnswer}/{guestNumber}</span></a>
            </span>
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
        <!--ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーURL表示ページ-->
        <div if={ vis==7 } class="top padding-top">
            <div class="URL content_center"><span id="roomnum">部屋番号：</span>{roomname} <img src="./img/QR_Code.jpg"><br>http://pingpong-<br>dash.herokuapp.<br>com/guest.html</div>

        </div>





    </div>
    <script>
        var self = this;
        self.socket = io.connect();
        this.vis = 1;
        self.guestNumber = 0; //参加人数
        var chart_State = 1; //チャートがバーチャート（１）か円グラフ（２）か
        var X = []; //チャートのラベル
        var Y = []; //チャートのラベルに対する回答者数
        self.textAnswer = []; //テキスト問題の回答の配列
        var Kaitou_Data = {
                X: X,
                Y: Y,
                guest: 0,
                SN: 0 //選択肢の数
            } //チャートオブジェクト
        self.selectNumber = []; //問題作成の選択肢数の配列
        self.answerNum = 0; //正解番号
        self.finishedAnswer = 0; //回答者数
        self.rankData = []; //ランキング表データ
        var columns = []; //c3.jsのグラフオブジェクト
        var Xziku = []; //c3.jsのグラフのx軸ラベル
        var Color = [];
        // var CHART;
        var chart;
        var timer1;
        var PieChart = [];
        var TextData = [];
        var textAnswerData = "";
        var functionhistory = ""; //機能の履歴
        self.result_list = [{
            format: "",
            question: ""
        }]; //事前作成資料のリストオブジェクト
        var For_result_detail = []; //result_detailにセットする前の仮配列
        self.result_detail = []; //事前作成資料の詳細オブジェクト
        var Qnum = ""; //事前作成資料のリストのリスト番号
        self.question = ""; //事前作成の設問文表示のための変数
        self.visible = true; //事前作成詳細画面の選択肢、テキストボタンの切り替えのため


        //-------------------------------------------onClick,emit送信
        toSelect = function() {
                self.socket.emit('makeRoom');
                document.body.style.backgroundColor = "#f8f8f8";
                document.getElementById("header_under").style.backgroundColor = "#333300";
                self.vis = 2;
                functionhistory = 2;
            }
            //選択肢問題の回答要請
        getNum = function() {
            $("#choiceNumber_ul").click(function(e) {
                var Text = e.target.innerText;
                if (Text == "２つ") Kaitou_Data.SN = 2;
                if (Text == "３つ") Kaitou_Data.SN = 3;
                if (Text == "４つ") Kaitou_Data.SN = 4;
                if (Text == "５つ") Kaitou_Data.SN = 5;
                if (Text == "６つ") Kaitou_Data.SN = 6;
                choiceNumber();
            });
        }

        function choiceNumber() {
            console.log(Kaitou_Data.SN);
            var data = {
                type: 'select',
                SN: Kaitou_Data.SN
            };
            console.log(Kaitou_Data.SN);
            self.socket.emit('OtoG', data);
            //棒グラフのデータセット

            for (var i = 0; i < parseInt(Kaitou_Data.SN) + 1; i++) {
                if (i == 0) {
                    columns[i] = "選択肢";
                    Xziku[i] = "x";
                } else {
                    columns[i] = 0;
                    Xziku[i] = i;
                }
            }
            //円グラフのデータセット
            PieChart = [];
            for (var i = 0; i < parseInt(Kaitou_Data.SN); i++) {
                PieChart[i] = ["選択肢" + (i + 1), 0];
            }
            console.log(PieChart);
            document.getElementById("header_under").style.backgroundColor = "#00A1CB";
            self.vis = 3;
            functionhistory = 3;
            self.update();
            chartSet();
        }
        //テキストの回答要請
        toText = function() {
                var data = {
                    type: 'text',
                };
                self.socket.emit('OtoG', data);
                document.getElementById("header_under").style.backgroundColor = "#8fcf00";
                self.vis = 4;
                functionhistory = 4;
                self.update();
            }
            //問題文作成,選択肢の数を決定
        getSelectNum = function() {
                var selectNum = document.Q.num.value; //選択肢数
                for (var i = 0; i < selectNum; i++) {
                    self.selectNumber.push({
                        Number: i + 1
                    });
                }
            }
            //ラジオボタンのチェック判断で正解の取得
        trueORfalse = function() {
                self.answerNum = 0;
                for (var i = 1; i < parseInt(document.Q.num.value) + 1; i++) {
                    check = document.Q.elements['R' + i].checked;
                    if (check == true) {
                        self.answerNum = i;
                    }
                }
            }
            //問題文作成,選択肢の項目を設定し、送信
        sendCreateQ = function() {
                self.QselectContent = [];
                for (var i = 0; i < 4; i++) {
                    var content = document.getElementById("Answer" + i).value;
                    self.QselectContent[i] = {
                        num: i,
                        content: content
                    };
                }
                Kaitou_Data.SN = 4; //選択肢の数を固定の場合
                var Question = document.getElementById("Qtext").value; //選択肢固定問題文
                var Time = document.getElementById("Time").value * 60; //制限時間
                var data = {
                    type: 'createQ',
                    SN: Kaitou_Data.SN, //グラフ描画する場合//グラフ描画しない場合sentakusi,//選択肢の数
                    Q: Question, //問題文
                    QContent: self.QselectContent, //選択肢、選択肢の項目
                    Time: Time //制限時間
                }
                console.log(data);
                self.socket.emit('OtoG', data);
                document.getElementById("Qtext").value = "";
                document.getElementById("Time").value = "";
                for (var i = 0; i < 4; i++) {
                    document.getElementById("Answer" + i).value = "";
                }
                self.selectNumber.length = 0;
                //棒グラフのデータセット
                for (var i = 0; i < parseInt(Kaitou_Data.SN) + 1; i++) {
                    if (i == 0) {
                        columns[i] = "選択肢";
                        Xziku[i] = "x";
                    } else {
                        columns[i] = 0;
                        Xziku[i] = i;
                    }
                }
                //円グラフのデータセット
                for (var i = 0; i < parseInt(Kaitou_Data.SN); i++) {
                    PieChart[i] = ["選択肢" + (i + 1), 0];
                }
                document.getElementById("header_under").style.backgroundColor = "#E34933";
                document.getElementById("hanbaga_menu").style.backgroundColor = "#E34933";
                self.vis = 5;
                self.update();
                chartSet();
            }
            //回答形式の選択画面（２ページ目）へ
        backSelect = function() {
                console.log("チェック");
                //テキスト回答,作成問題の場合の処理
                if (Kaitou_Data.SN == 0) {
                    self.textAnswer.length = 0;
                    self.rankData.length = 0; //ランキングデータリセット
                    self.vis = 2;
                }
                if (Kaitou_Data.SN > 0) {
                    PieChart = [];
                    Date_Zero();
                    Kaitou_Data.SN = 0;
                    self.vis = 2;
                }
                //回答出来なかった参加者がいた場合の処理
                if (self.finishedAnswer != self.guestNumber) {
                    var data = {
                        type: 'deadline'
                    }
                    self.socket.emit("OtoG", data);
                    alert("回答を締め切りました")
                }
                document.getElementById("header_under").style.backgroundColor = "#333300";
                self.finishedAnswer = 0; //回答者数リセット
                functionhistory = 2; //機能履歴を２にする
            }
            //退室
        toClose = function() {
                var data = {
                    type: 'close'
                }
                self.socket.emit('OtoG', data);
                location.reload();
            }
            //画面遷移
            //機能ページへ
        toFunction = function() {
                if (functionhistory == 2) {
                    self.vis = 2; //機能履歴を２にする
                }
                if (functionhistory == 3) {
                    self.vis = 3; //機能履歴を３にする
                }
                if (functionhistory == 4) {
                    self.vis = 4; //機能履歴を４にする
                }
                document.getElementById("header_under").style.backgroundColor = "#333300";
            }
            //カスタムページへ
        toCustom = function() {
                self.vis = 6;
            }
            //事前作成ページへ
        toPrebuilt = function() {

            self.vis = 8;
            document.getElementById("header_under").style.backgroundColor = "#E34933";
        }
        loadfile = function(e) {
                document.getElementById("pb01").style.display = "table-cell";
                document.getElementById("pb02").style.display = "table-cell";
                var file = e.target.files[0];
                // FileReader.onloadイベントに
                // ファイル選択時に行いたい処理を書く
                var reader = new FileReader();
                reader.onload = function(e) {
                    // 選択したCSVファイルから２次元配列を生成
                    var arr = toArray(e.target.result);
                    self.result_list = arr;
                    self.update();
                    // ２次元配列からテーブルを生成
                    var table = createTableFromArray(arr);
                    // divにテーブルを挿入
                    $("#view").empty();
                    $("#view").append(table);

                };
                // Textとしてファイルを読み込む
                reader.readAsText(file);
                console.log(self.result_list);

                self.update();
                //    });
                //},false);
            }
            //事前作成済み設問の確認画面へ
        toResult_detaile = function(e) {
                Qnum = e.item.Number;
                //選択肢問題の場合
                if (e.item.format == "選択肢") {
                    self.result_detail = For_result_detail[Qnum - 1];
                    self.visible = true;
                    self.vis = 9;
                    self.update();
                    $(".question").val(self.result_list[Qnum - 1].question);
                    self.question = self.result_list[Qnum - 1].question;
                }
                //テキスト問題の場合
                if (e.item.format == "テキスト") {
                    self.result_detail = "";
                    self.visible = false;
                    self.vis = 9;
                    self.update();
                    $(".question").val(self.result_list[Qnum - 1].question);
                }
                console.log(e.item.format);


            }
            //事前作成済みの選択肢問題を送信
        prebuild_select = function() {
                self.QselectContent = []; //選択肢の項目を配列でデータ化


                Kaitou_Data.SN = self.result_detail.length; //選択肢の数
                var data = {
                    type: 'prebuild_select',
                    SN: Kaitou_Data.SN, //グラフ描画する場合//グラフ描画しない場合sentakusi,//選択肢の数
                    Q: self.result_list[Qnum - 1].question, //問題文
                    QContent: self.result_detail //選択肢、選択肢の項目
                }
                self.socket.emit('OtoG', data);
                //棒グラフのデータセット
                for (var i = 0; i < parseInt(Kaitou_Data.SN) + 1; i++) {
                    if (i == 0) {
                        columns[i] = "選択肢";
                        Xziku[i] = "x";
                    } else {
                        columns[i] = 0;
                        Xziku[i] = i;
                    }
                }
                //円グラフのデータセット
                for (var i = 0; i < parseInt(Kaitou_Data.SN); i++) {
                    PieChart[i] = ["選択肢" + (i + 1), 0];
                }

                document.getElementById("header_under").style.backgroundColor = "#00A1CB";
                self.vis = 10;
                self.update();
                $(".question").val("");
                $(".Choices_text").val("");
                chartSet();

            }
            //事前作成済みのテキスト問題を送信
        prebuild_text = function() {
                var data = {
                    type: 'prebuild_text',
                    Q: self.result_list[Qnum - 1].question //問題文
                };
                self.socket.emit('OtoG', data);
                document.getElementById("header_under").style.backgroundColor = "#99CC00";
                self.vis = 4;
                self.update();

            }
            //URLページへ
        toURL = function() {
                document.getElementById("header_under").style.backgroundColor = "#F69613";
                self.vis = 7;
            }
            //選択肢回答をファイルでダウンロード
        shot2 = function() {
                //svgをcanvas変換,png変換でダウンロード
                html2canvas(　　
                    document.body, {
                        onrendered: function(canvas) {
                            var link2 = document.createElement('a');
                            link2.href = canvas.toDataURL();
                            link2.download = "SelectData.png";
                            link2.click();
                        }
                    });

            }
            //テキスト回答をファイルでダウンロード保存
        Textshot = function() {

            for (var i = 0; i < TextData.length; i++) {
                textAnswerData += "名前:" + TextData[i][0] + ",　　　回答：" + TextData[i][1] + "\n\n";
            }
            var text = textAnswerData;
            var blob = new Blob([text], {
                "type": "text/csv"
            });
            var link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'TextData.csv';
            link.click();
            textAnswerData = "";
        }

        //-------------------------------------mount,socket.on受信
        this.on('mount', function() {
            self.socket.on('success', function(roomcode) {
                self.roomname = roomcode;
                console.log(self.roomname);
                self.update();
            });
            self.socket.on('count', function(data) {
                Kaitou_Data.guest = Kaitou_Data.guest + data;
                self.guestNumber = Kaitou_Data.guest;
                self.update();
            });
            self.socket.on('GtoO', function(DATA) {
                //選択回答の受信
                if (DATA.type == 'select_answer') {
                    //棒グラフ、円グラフの回答集計
                    if (DATA.kaitou) {
                        columns[DATA.kaitou] = columns[DATA.kaitou] + 1;
                        PieChart[DATA.kaitou - 1][1] = PieChart[DATA.kaitou - 1][1] + 1;
                    }
                    if (self.finishedAnswer == 0) {
                        if (chart_State == 1) {
                            chartResult_bar();
                        }
                        if (chart_State == 2) {
                            chartResult_pie();
                        }
                    }
                    //チャートの形状を確認
                    if (chart_State == 1) {
                        plus();
                    }
                    if (chart_State == 2) {
                        plus_pie();
                    }

                }
                //テキスト回答の受信
                if (DATA.type == 'text_answer') {
                    TextData.push([DATA.Name, DATA.Answer]);
                    console.log(DATA.Answer);
                    self.textAnswer.unshift({
                        Name: DATA.Name,
                        Answer: DATA.Answer
                    });
                }
                //作成済み、選択問題回答の受信
                if (DATA.type == 'pb_select_answer') {
                    //棒グラフ、円グラフの回答集計
                    if (DATA.kaitou) {
                        columns[DATA.kaitou] = columns[DATA.kaitou] + 1;
                        PieChart[DATA.kaitou - 1][1] = PieChart[DATA.kaitou - 1][1] + 1;
                    }
                    if (self.finishedAnswer == 0) {
                        if (chart_State == 1) {
                            chartResult_bar();
                        }
                        if (chart_State == 2) {
                            chartResult_pie();
                        }
                    }
                    //チャートの形状を確認
                    if (chart_State == 1) {
                        plus();
                    }
                    if (chart_State == 2) {
                        plus_pie();
                    }
                }
                //作成問題の回答受信
                if (DATA.type == 'createQ_answer') {
                    if (DATA.kaitou) {
                        columns[DATA.kaitou] = columns[DATA.kaitou] + 1;
                        PieChart[DATA.kaitou - 1][1] = PieChart[DATA.kaitou - 1][1] + 1;
                    }
                    if (self.finishedAnswer == 0) {
                        chartResult();
                    }
                    var Correct = 0; //正解数
                    if (DATA.kaitou == self.answerNum) {
                        Correct = Correct + 1; //回答と正解番号が一致したら正解数をプラス1
                    }
                    var rank = 1; //順位変数
                    var AnswerData = { //回答者データ
                        Rank: rank,
                        Name: DATA.Name, //名前
                        Answer: DATA.kaitou, //回答番号
                        Time: DATA.zikan, //回答時間
                        Correct: Correct //正解数
                    }

                    self.rankData.push(AnswerData);

                    self.rankData.sort( //正解数、回答時間で並べ替え
                        function(a, b) {
                            var aCorrect = a["Correct"];
                            var bCorrect = b["Correct"];
                            var aTime = a["Time"];
                            var bTime = b["Time"];
                            if (aCorrect < bCorrect) return 1;
                            if (aCorrect > bCorrect) return -1;
                            if (aTime < bTime) return -1;
                            if (aTime > bTime) return 1;
                            return 0;
                        }
                    );
                    if (self.rankData.length > 1) {
                        var num = 1;
                        for (var i = 0; i < self.rankData.length; i++) {

                            if (self.rankData[0] == self.rankData[i]) {
                                self.rankData[0].Rank = num;
                            }
                            if (self.rankData[0] != self.rankData[i]) {
                                if (self.rankData[i].Correct == self.rankData[i - 1].Correct && self.rankData[i].Time == self.rankData[i - 1].Time) {
                                    self.rankData[i].Rank = num;
                                } else {
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
        function Date_Zero() {
            columns.length = 0;
            Xziku.length = 0;
            console.log(columns);
            console.log(Xziku);
        }
        //チャートセット
        function chartSet() {
            var chart = c3.generate({
                //bindto: "#test",
                data: {
                    x: 'x',
                    columns: [
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
                        show: false
                    }
                }
            });
        }
        var A;
        var B;
        var C;
        var D;
        //チャート結果,1人目のデータを受け取った場合
        function chartResult_bar() {
            D = parseInt(Kaitou_Data.SN);
            C = columns.shift();
            B = Math.max.apply(null, columns);
            A = columns.indexOf(B);
            for (var i = 0; i < D; i++) {
                if (columns[i] == B) {
                    Color[i] = '#ff7f0e';
                } else {
                    Color[i] = '#1f77b4';
                }
            }
            columns.unshift(C);
            console.log(Color);
            chart = c3.generate({
                //bindto: "#test",
                data: {
                    x: 'x',
                    columns: [
                        Xziku,
                        columns
                    ],
                    labels: true,
                    color: function(color, d) {
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
                        max: Kaitou_Data.guest,
                        show: false
                    }
                }

            });

        }

        function chartResult_pie() {
            D = parseInt(Kaitou_Data.SN);
            C = columns.shift();
            B = Math.max.apply(null, columns);
            A = columns.indexOf(B);
            for (var i = 0; i < D; i++) {
                if (columns[i] == B) {
                    Color[i] = '#ff7f0e';
                } else {
                    Color[i] = '#1f77b4';
                }
            }
            columns.unshift(C);
            chart = c3.generate({
                data: {
                    // iris data from R
                    columns: PieChart,
                    type: 'pie',
                    order: null
                }
            });
        }
        //チャート結果、2人目以降
        function plus() {

            C = columns.shift();
            B = Math.max.apply(null, columns);
            A = columns.indexOf(B);
            for (var i = 0; i < D; i++) {
                if (columns[i] == B) {
                    Color[i] = '#ff7f0e';
                } else {
                    Color[i] = '#1f77b4';
                }
            }
            columns.unshift(C);
            chart.load({
                color: function(color, d) {
                    return Color[d.index];
                },
                columns: [
                    Xziku,
                    columns
                ],
                type: 'bar'
            });

        }
        toPieChart = function() {
                chart_State = 2; //チャートをpie(2)に変更
                chart = c3.generate({
                    data: {
                        // iris data from R
                        columns: PieChart,
                        type: 'pie',
                        order: null
                    }
                });

            }
            //pieチャートの2人目以降の結果表示
        function plus_pie() {
            chart.load({
                columns: PieChart,
                type: 'pie',
                order: null
            });
        }
        tobarChart = function() {
            chart_State = 1; //チャートをbarチャートに変更
            chart = c3.generate({
                //bindto: "#test",
                data: {
                    x: 'x',
                    columns: [
                        Xziku,
                        columns
                    ],
                    labels: true,
                    color: function(color, d) {
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
                        show: false
                    }
                }

            });
        }


        hanbaga = function() {
            var hanbaga_menu = document.getElementById("hanbaga_menu");
            if (hanbaga_menu.className === 'menu-open') {
                hanbaga_menu.className = '';
            } else {
                hanbaga_menu.className = 'menu-open';
            }

        }

        // CSVテキストを２次元配列にする 
        //参考資料では2次元配列にしていたのをオブジェクトにして
        //eachで展開できるようにする
        function toArray(csv) {
            var preresult = new Array();
            var rows = csv.split("\n");
            var list = [];
            var detail = [];
            $(rows).each(function(i) {
                preresult.push(this.split(","));
                var format = preresult[i].slice(1, 2); //選択肢かテキストかの判断要素を取り出す
                list.push({
                    format: format[0],
                    question: preresult[i][0],
                    Number: i + 1
                });
                preresult[i].splice(0, 3); //選択肢の項目をオブジェクトにするため、それ以外を削除
                var predetail = [];
                //選択肢をオブジェクトにセット、eachで展開するため
                $(preresult[i]).each(function(j) {
                    predetail.push({
                        Choice: preresult[i][j]
                    });
                });
                detail.push(predetail);
            });

            detail.pop();
            For_result_detail = detail;
            list.pop(); //事前作成資料のリスト



            return list;

        }
        // ２次元配列からテーブルを生成する
        function createTableFromArray(arr) {

        }
        // タグをエスケープ
        function escapse(t) {
            return $('<div>').text(t).html();
        }
    </script>
    <!-- style -->
    <style scoped>
        a {
            text-decoration: none;
            color: white;
        }
        
        a:link {
            color: black;
        }
        
        a:visited {}
        
        a:active {}
        
        .entry_toppage {
            background: #285294;
            height: 1.25em;
            width: 330px;
            padding: 10px 0;
            color: white;
            font-size: 20px;
            margin-bottom: 7px;
        }
        
        .back_room:hover,
        .entry_toppage:hover {
            cursor: pointer;
            opacity: 0.5;
        }
        
        .back_room {
            background: #FFA103;
            height: 1.25em;
            width: 330px;
            padding: 10px 0;
            color: white;
            font-size: 20px;
        }
        
        .base_result_title {
            height: 30px;
            font-size: 30px;
            margin-bottom: 10px;
            padding-left: 20px;
            text-align: left;
            line-height: 1;
        }
        
        .text_result_color {
            color: #333300;
            border-left: 10px solid #8fcf00;
        }
        
        .choice_result_color {
            color: #333300;
            border-left: 10px solid #00A1CB;
        }
        
        .c3-text {
            font-size: 40px;
            font-family: 'Noto Sans JP', sans-serif;
        }
        /*      icon*/
        
        .room_number {
            font-size: 40px;
        }
        
        .room_number span {
            font-size: 20px;
        }
        
        .icon_user {
            font-size: 50px;
            display: block;
        }
        
        .barpie {
            font-size: 40px;
            margin-right: 15px;
            margin-bottom: 10px;
        }
        /*     これより上はチャート描写*/
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
            z-index: 4;
        }
        /*     ーーーーーーーーーーーーーーーーーーーーーーー ハンバーガーメニュ*/
        
        #hanbaga_menu {
            background: #333300;
            padding-top: 10px;
            padding-bottom: 10px;
            height: 25px;
            z-index: 4;
            position: absolute;
            top: 0px;
            transition: .4s;
            width: 100%;
        }
        
        .hanbaga {
            display: none;
        }
        
        #show {}
        
        .munu_han {
            text-align: left;
        }
        
        .menuhan {
            padding: 0 5px;
            text-align: center;
            display: inline-block;
            font-size: 15px;
            color: white;
            vertical-align: middle;
        }
        
        .menuhan:hover {
            cursor: pointer;
            color: #00a7ea;
        }
        /*      ーーーーーーーーーーーーーーーーーーーーーー*/
        
        .menu_ul {
            text-align: center;
        }
        
        .menu {
            display: inline-block;
            font-size: 15px;
            font-weight: bold;
            width: 100px;
            color: white;
            vertical-align: middle;
        }
        
        .menu_ul2 {
            text-align: left;
            display: inline;
        }
        
        .menu2 {
            text-align: center;
            display: inline-block;
            font-size: 15px;
            width: 100px;
            color: white;
            vertical-align: middle;
        }
        
        .menu2:hover {
            cursor: pointer;
            color: #00a7ea;
        }
        
        .menu_ul3 {
            text-align: right;
            display: inline;
        }
        
        .menu3 {
            text-align: center;
            display: inline-block;
            font-size: 15px;
            width: 130px;
            color: white;
            vertical-align: middle;
        }
        
        .menu:hover {
            background: #00a7ea;
            border-radius: 5px;
            width: 100px;
            height: 20px;
        }
        
        #header_under {
            height: 5px;
            background: #f8f8f8;
            z-index: 2;
        }
        /*      -----------------------------------#body部分*/
        
        #body {
            height: 100%;
            min-height: 100%;
            width: 100%;
            z-index: 2;
        }
        
        .gestNumber_text {
            letter-spacing: 1em;
            margin-left: 45px;
            margin-top: 10px;
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
        
        .entry {
            font-size: 100px;
            color: white;
            font-family: 'Poiret One', cursive;
        }
        
        .URL {
            text-align: left;
            font-size: 150px;
            font-weight: bold;
            color: black;
            font-family: 'Raleway', sans-serif;
            line-height: 95%;
        }
        
        .URL img {
            vertical-align: bottom;
            width: 300px;
            height: auto;
        }
        
        .function {
            display: inline-block;
            margin-top: 10px;
        }
        
        #roomcode {
            background: black;
            color: white;
            padding: 10px;
        }
        
        .link {
            cursor: pointer;
        }
        
        .link:hover {
            color: red;
            cursor: pointer;
        }
        
        .padding-top {
            padding-top: 50px;
        }
        
        .margin-top {
            margin-top: 50px;
        }
        
        .main {
            word-wrap: break-word;
            text-align: center;
            height: 70%;
        }
        
        #test {
            width: 100%;
            height: 100%;
        }
        
        .result {
            width: 90%;
            height: 70%;
            margin: 60px auto 40px;
            line-height: 100%;
            overflow: auto;
        }
        
        #result_table {
            width: 500px;
            height: 70%;
            margin: 60px auto 40px;
            line-height: 100%;
            overflow: auto;
        }
        
        #chart {
            width: 100%;
            margin: 30px auto 50px;
        }
        
        .inputText {
            width: 20px;
            height: 30px;
            font-size: 20pt;
            color: black;
        }
        
        .canvas {
            height: 250px;
            width: 500px;
        }
        /*      事前作成設問画面へ*/
        
        .usepb {
            margin-top: 7px;
        }
        /*      退室ボタンのマージン*/
        
        .margin_back {
            margin-top: 7px;
            width: 165px;
        }
        /*      締め切り　回答者ボタン*/
        
        .hover {
            display: block;
            width: 100px;
            height: 30px;
        }
        
        .hover:hover>.front {
            opacity: 0;
        }
        
        .hover:hover:after {
            content: attr(data-hover);
            display: block;
            position: absolute;
            top: 0px;
            left: 30px;
        }
        /*      ボタンホバー時のポインタ*/
        
        .pointer:hover {
            cursor: pointer;
        }
        /*ランク機能付き問題送信ボタン*/
        
        .color {
            background: #E34933;
        }
        
        .color:hover {
            background: #E34933;
        }
        /*      制限時間*/
        
        #limit {
            margin: 10px auto;
            text-align: left;
            padding-left: 30px;
        }
        /*      部屋番号用*/
        
        #roomnum {
            font-size: 50px;
        }
        /*      テーブル*/
        
        #Create_table {
            width: 500px;
            margin: 0 auto;
        }
        
        #table_title {
            font-size: 30px;
            height: 50px;
        }
        
        #Create_table textarea {
            width: 90%;
        }
        
        #Create_table td {
            padding: 5px;
        }
        
        #Create_table th {
            padding-top: 2px;
            padding-bottom: 2px;
            padding-left: 30px;
        }
        
        #Create_table input {
            width: 80%;
        }
        /*      グラフ変更用icon*/
        
        .chart {
            margin-bottom: 10px;
        }
        
        .chart:hover {
            opacity: 0.5;
        }
        
        .data {
            margin-left: 35px;
            margin-bottom: 12px;
        }
        
        .data:hover {
            opacity: 0.5;
        }
        
        @media screen and ( max-width:600px) {
            .menu_ul2 {
                display: none;
            }
            .hanbaga {
                color: white;
                float: left;
                margin-left: 10px;
                font-size: x-large;
                display: block;
                cursor: pointer;
            }
            .hanbaga:hover {
                cursor: pointer;
            }
            #hanbaga_menu.menu-open {
                top: 45px;
            }
            .entry {
                font-size: 14vw;
            }
            #result_table {
                width: 100%;
            }
            #Create_table {
                width: 100%;
                margin: 0 auto;
            }
            #table_title {
                font-size: 5vw;
                height: 50px;
            }
            #Create_table textarea {
                width: 90%;
            }
            #Create_table td {
                padding: 5px;
            }
            #Create_table th {
                padding-top: 2px;
                padding-bottom: 2px;
                padding-left: 10px;
            }
            #Create_table input {
                width: 80%;
            }
            #limit {
                padding-left: 10px;
            }
            .table_width {
                width: 90%;
            }
            /*          */
            .prebuild_table {
                width: 90%;
                margin: 0 auto;
            }
            /*          事前作成済み、選択式回答用*/
            .pb_question {
                font-size: 3vw;
                line-height: 120%;
                color: #333300;
            }
        }
        
        section table {
            width: 100%;
            word-break: break-all;
        }
        
        section th,
        section td {
            padding: 10px;
        }
        
        section th {
            background: #d9ec92;
            color: #525252;
            font-weight: bold;
            border-top: 1px dotted gray;
            border-bottom: 1px dotted gray;
        }
        
        section td {
            text-align: left;
            font-weight: 100;
            border-top: 1px solid #d9ec92;
            border-bottom: 1px solid #d9ec92;
        }
        /*----------------------------------------------------
    .demo01
----------------------------------------------------*/
        
        .demo01 {
            margin: 10px auto 0;
        }
        
        #sec01 {
            height: 500px;
            overflow: auto;
        }
        
        .demo01 th {
            width: 25%;
            text-align: center;
        }
        
        @media only screen and (max-width:480px) {
            #sec01 {
                height: 400px;
            }
            .demo01 {
                margin: 10px auto 0;
                word-wrap: break-word;
            }
            .demo01 th,
            .demo01 td {
                width: 96%;
                display: block;
                border-top: none;
                margin: 0 auto;
            }
            .demo01 tr:first-child th {
                border-top: 1px solid #ddd;
            }
        }
        /*      flex　事前作成資料ページリスト、詳細*/
        
        .flex {
            display: -webkit-flex;
            display: flex;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-align-items: center;
            align-items: center;
            height: 100%;
            width: 100%;
            padding-top: 50px;
        }
        
        #flexdiv {
            width: 600px;
            height: 500px;
            margin: 0px;
            padding-top: 50px;
            margin: 0 auto;
            overflow: auto;
        }
        
        .flex-nav a {
            margin: 10px;
            border-radius: 15px;
            background: #285294;
            color: #fff;
            display: block;
            padding: 8px;
            text-decoration: none;
            width: 15px;
            height: 15px;
        }
        
        .flex-nav .logo {
            background: #4584b1;
        }
        
        .flex-nav {
            display: flex;
        }
        /*      事前資料リストのテーブル*/
        
        .prebuild_table {
            text-align: left;
        }
        
        .prebuild_table th,
        .prebuild_table td {
            padding: 10px;
        }
        
        .prebuild_table tr td:nth-of-type(2) {
            font-size: 12px;
        }
        
        .prebuild_table tr td:nth-of-type(2):hover {
            cursor: pointer;
            opacity: 0.5;
        }
        
        #pb01 {
            display: none;
            width: 20%;
            font-weight: bold;
        }
        
        #pb02 {
            display: none;
            width: 80%;
            font-weight: bold;
        }
        
        #pb02:hover {
            cursor: pointer;
            opacity: 0.5;
        }
        /*      事前資料詳細のテーブル*/
        
        .Q {
            width: 100%;
            height: 100%;
        }
        
        .Qtable {
            width: 600px;
            margin-bottom: 30px;
        }
        
        .Qtable td {
            padding: 5px;
        }
        
        .table_title {
            font-size: 30px;
            border-left: 10px solid #E54028;
            color: ##333300;
        }
        
        .question {
            width: 95%;
            padding: 2px;
        }
        
        .Coices_text {
            width: 95%;
            padding: 2px;
        }
        
        pb01_detail {
            width: 10%;
        }
        
        .pb02_detail {
            width: 90%;
        }
        /*      事前作成済み、選択式回答の結果表示ページ用*/
        
        #pb_flexdiv {
            width: 600px;
            height: 90%;
            margin: 0 auto;
        }
        
        .pb_result {
            width: 100%;
            line-height: 100%;
        }
        
        .pb_question {
            text-align: left;
            border-left: 10px solid #00A1CB;
            padding-left: 20px;
            color: #333300;
        }
        
        .pb_result_choice {
            width: 600px;
        }
        
        .pb_result_choice:first-child {
            width: 10px;
            font-weight: bold;
            font-size: 15px;
            color: #005e8e;
        }
        
        .pb_result_choice td:nth-of-type(2) {
            text-align: left;
            font-weight: 300;
            background: #98dafd;
        }
        
        .pb_result_choice tr:nth-child(even) td:nth-of-type(2) {
            background: #f8f8f8;
        }
        /*      事前作成ずみ設問読み込みページ　読み込みボタン*/
        
        .fileload_buttom {}
        /*      戻るボタン*/
        
        .back {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 1px solid #584d4d;
            padding: 5px;
            vertical-align: middle;
            border-radius: 3px;
            color: #584d4d;
        }
        
        .back {
            opacity: 0.5;
        }
        
        .c3 text {
            font-size: 20px;
            fill: #4c4c4c;
        }
        
        .c3-chart-arc text {
            fill: white;
        }
    </style>
</owner>