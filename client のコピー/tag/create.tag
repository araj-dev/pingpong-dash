<create>
<div class="main">
       <div>
            <h1>設問</h1>
             <nav>
               <ul class="main-nav">
               <li><a onclick={add_question_num}>+</a></li>
               <li><a onclick={subtract_question_num}>-</a></li>
               <li each={question_num}><a onclick={changeQ} id="getnum"+{num}>{num}</a></li>
              </ul>
              </nav>
                <div class="Q" each={question_num}>
                 <table class="Qtable" >
                     <tr>
                         <td colspan="2" class="table_title">設問文{num}</td>
                     </tr>
                     <tr>
                         <td colspan="2"><textarea type="text" class="question" name="question" rows="5" cols="30"></textarea>    
                     </tr>
                     <tr>
                     <td colspan="2" id="C_T">
                     <span class="button-dropdown" data-buttons="dropdown">
                     <a class="button button-rounded button-flat-primary pointer">選択肢     ⬇︎</a>
                     <ul class="button-dropdown-menu-below" style="display: none;" id="choiceNumber_ul">
                     <li onclick={Decision_num}><a href="#">２つ</a></li>
                     <li onclick={Decision_num}><a href="#">３つ</a></li>
                     <li onclick={Decision_num}><a href="#">４つ</a></li>
                     <li onclick={Decision_num}><a href="#">５つ</a></li>
                     <li onclick={Decision_num}><a href="#">６つ</a></li>
                     </ul>
                       </span>
                       <span class="button-dropdown" data-buttons="dropdown">
                        <a onclick={Decision_text} class="button button-rounded button-flat-action pointer"> テキスト </a>
                        </span>
                        </td>
                    </tr>
                    <tr>
                        <td id="format">回答形式</td>
                        <td class="Decision"></td>
                    </tr>
<!--
                    <tr class="Choice">
                         <td class="Choices_num">選択肢{num}</td>
                         <td><input type="text" class="Choices_text"></td>
                     </tr>
-->
                     
                 </table>
              </div>
  
                
        </div>
        <p onclick={shot}>保存</p>
    </div>
    
    <script>
        var self = this;
        self.question_num = [{num:1}];
        var element = [];//設問の数Qtable用配列
        var Num = 1;//設問番号取得変数
        var Data = [];//設問文データ
        
        add_question_num = function(){
            if(self.question_num.length == 9){
                return false;
            }
            self.question_num.push({num:self.question_num.length+1});
            self.update();
            
            
//                for ( var i = 0;i < self.question_num.length;i++){
//                    $('.Q table').attr('class','Qtable'+(i+1));
//                    $('.Qtable'+(i+1)).attr('if','{Q=='+(i + 1)+'}');
//                }
            $('.Qtable').each(function(i){
                    $(this).attr('id','table'+(i+1));
                    
                });
                $('.table_title').each(function(i){
                    $(this).attr('id','title'+(i+1));
                    
                });
            $('.question').each(function(i){
                    $(this).attr('id','question'+(i+1));
                    
                });
            $('.Decision').each(function(i){
                    $(this).attr('id','element'+(i+1));
                    
                });
        }
        subtract_question_num = function(){
            if(self.question_num.length == 1){
              return false;
            }
            self.question_num.pop();
            
            if(Num == self.question_num.length+1){
                for( var i = 0;i < self.question_num.length;i++){
                element[i].style.display = "none";
                    if(self.question_num.length){
                        element[self.question_num.length-1].style.display = "block";
                    }
                }  
            }
            if(Num > self.question_num.length+1){
                for( var i = 0;i < self.question_num.length;i++){
                element[i].style.display = "none";
                    if(self.question_num.length){
                        element[self.question_num.length-1].style.display = "block";
                    }
                }  
            }
            
            
        }
        changeQ = function(e){
            Num = e.item.num;
            element = document.getElementsByClassName("Q");
            for( var i = 0;i < element.length;i++){
                element[i].style.display = "none";
                if(Num){
                    element[Num-1].style.display = "block";
                }
            }
            self.update();
            
            
        }
        
        
        
        Decision_num = function(e){
            var title = $(".table_title:visible").show();
            var title_num = title[0].innerHTML.slice(-1); 
            
            if( title_num){
                $("#element"+title_num).text("");
                $("#element"+title_num).text("選択肢");
            }
                var Text = e.target.innerText;
            console.log(Text);
                var Num;
            var Tag = "";
                if( Text == "２つ") Num = 2;
                if( Text == "３つ") Num = 3;
                if( Text == "４つ") Num = 4;
                if( Text == "５つ") Num = 5;
                if( Text == "６つ") Num = 6;
            for( var i = 0; i< Num;i++){
                Tag += '<tr class="Choice'+title_num+'" id="Choice'+(i+1)+'"><td class="Choices_num">選択肢'+(i+1)+'</td><td><input type="text" class="Choices_text" id="Choices_text'+(i+1)+'"></td></tr>'
            }
            $(".Choice"+title_num).remove();
            $("#table"+title_num).append(Tag);
            
            
        }
        Decision_text = function(){
            var title = $(".table_title:visible").show();
            var title_num = title[0].innerHTML.slice(-1); 
            $(".Choice"+title_num).remove();
            if( title_num){
                $("#element"+title_num).text("");
                $("#element"+title_num).text("テキスト");
            }
        }
        
        //テキスト回答をファイルでダウンロード
        shot = function(){
            var Num = self.question_num.length;
            var datasmall = [];
            for (var i = 0;i < Num;i++){
                var Q = $("#question"+(i+1)).val();
                var F = $("#element"+(i+1)).html();
                var CN = $(".Choice"+(i+1)).length;
                var CC =[];
                for( var j = 0;j < CN;j++){
                    var Contets = $(".Choice"+(i+1)+" #Choices_text"+(j+1)).val();
                    CC.push(Contets);
                }
                datasmall = [Q,F,CN,CC]; 
                    //"問題文："+Q+",回答形式："+F+",選択肢数："+CN+",";
                Data += datasmall+"\n";
            }
            console.log(Data);
            var text = Data;
            var blob = new Blob([text], { "type" : "text/csv" });    
            var link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'TextAnswer.csv';
            link.click();
            Data = [];
        }
    
    
    </script>
    <style scoped>
    .main {
      display: -webkit-flex;
      display: flex;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-align-items: center;
      align-items: center;
      height:100%;
        width:100%;
    }

    .main div {
        width:600px;
        height:500px;
      margin: 0px;
      padding: 0;

    }
        .main-nav a {
            margin: 10px;
          border-radius: 15px;
          background: #285294;
          color: #fff;
          display: block;
          padding: 8px;
          text-decoration: none;
            width:15px;
            height:15px;
        }
        .main-nav .logo {
          background: #4584b1;
        }
        .main-nav {
          display: flex;
        }
        .Q{
            border-top:1px solid #4584b1;
            position:relative;
            
        }
        .Qtable{
            margin:0 auto;
            width:80%;
            position:absolute;
            top:0px;
            left:60px;
            
        }
        .Qtable td{
            padding:10px;
        }
        .table_title{
            font-size:30px;
            text-align: left;
        }
        .question{
            width:100%;   
        }
        #C_T{
            text-align: center;
        }
        #format{
            text-align: left;
          
        }
        #Decision{
        }
        .Choices_num{
          color: black;
            text-align: left;
        }
        .Choices_text{
            
        }
    
    </style>
</create>