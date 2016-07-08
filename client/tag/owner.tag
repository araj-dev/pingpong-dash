<owner>
<div id="main">
<div if={ vis == 1}>
<p>Profile</p>
<p onclick={toSelect} class="link">Start PingPong</p>
<p class="link">ログアウト</p>


</div>

<div if={ vis == 2}>
<p>{roomname}</p>
<p onclick={toResult} class="link">４つの中から選ぶ</p>

<form name="question">
<input type="text" class="inputText" maxlength="1" name="selectNum" pattern="^[0-9A-Za-z]+$">
<p onclick={selectNumber} class="link">４つの中から選ぶ</p>
</form>

</div>

<div if={ vis == 3}>
<div id="result"><canvas id="bar" class="canvas"></canvas></div>
<p onclick={backSelect} class="link">回答を締め切る</p>
</div>

</div>



<script>
    var self = this;
    self.socket = io.connect();
    this.vis = 1;
    var X= [];
    var Y = [];

    var Kaitou_Data = {
        X:X,
        Y:Y,
        guest:0,
        SN:0
    }
    
    this.on('mount',function(){
        
        self.socket.on('success',function(roomcode){
            self.roomname = roomcode;
            console.log(self.roomname);
            self.update();
        });
            self.socket.on('count',function(data){
                console.log(data);
                console.log(Kaitou_Data.guest);
                
            Kaitou_Data.guest = Kaitou_Data.guest + data;
                console.log(Kaitou_Data.guest);
        });

        
        
        self.socket.on('GtoO',function(data){
            console.log(Kaitou_Data);
            Kaitou_Check(Kaitou_Data,data);
            if( data.type == 'yontaku_kaitou'){
                chart(Kaitou_Data);
                            
            }
        });
        
    });

  
//-----------------------------------------------------onClick
        toSelect = function(){
          self.socket.emit('makeRoom');
          self.vis = 2;
        }

        toResult = function(){
            var data = {
                type:'yontaku',
            };     
            self.socket.emit('OtoG',data);
            self.vis = 3;
            self.update();
        }
        selectNumber = function(){
            Kaitou_Data.SN = document.question.selectNum.value;
            var data = {
                type:'yontaku',
                SN:Kaitou_Data.SN
            };     
            console.log(Kaitou_Data);
            self.socket.emit('OtoG',data);
            document.question.selectNum.value ="";
            self.vis = 3;
            self.update();
        }
        backSelect = function(){
            self.vis = 2;
            Date_Reset(Kaitou_Data);
            chart(Kaitou_Data);
        }
  //----------------------------------------------------function 
        function Date_Reset(obj){
                for( var i = 0;i<obj.SN;i++){
                obj.Y[i] = 0; 
            }
        }
        function Kaitou_Check(data,data2){
                for( var i = 0;i<data.SN;i++){
                data.X[i] = i + 1;
                data.Y[i] = 0; 
            }
            if ( data2.kaitou){
                data.Y[data2.kaitou-1] = data.Y[data2.kaitou-1] + 1;
            }
        }
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
                      //縦軸の目盛りの上書き許可。これ設定しないとscale関連の設定が有効にならないので注意。
                      scaleOverride : true,

//                      以下設定で、縦軸のレンジは、最小値0から5区切りで35(0+5*7)までになる。
//                    　scaleLabel:"<%=Kaitou_Data.guest%>",
//                      
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
      width:
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
          ime-mode: inactive;
      }
      .canvas{
          height:250px;
          width:500px;
          
      }
      



  </style>









</owner>
