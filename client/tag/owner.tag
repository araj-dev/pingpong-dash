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

    var Kaitou_Data = {
        one:0,
        two:0,
        three:0,
        four:0
    }
    
    this.on('mount',function(){
        
        self.socket.on('success',function(roomcode){
            self.roomname = roomcode;
            console.log(self.roomname);
            self.update();
        });
        
        self.socket.on('GtoO',function(data){
            console.log(Kaitou_Data);
            Kaitou_Check(data);
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
        backSelect = function(){
            self.vis = 2;
            Date_Reset();
            chart(Kaitou_Data);


        }
  //----------------------------------------------------function     
         function Date_Reset(){
                Kaitou_Data.one = 0;
                Kaitou_Data.two = 0;
                Kaitou_Data.three = 0;
                Kaitou_Data.four = 0;


        }     



        function Kaitou_Check(data){
            if( data.kaitou == 1){
                Kaitou_Data.one = Kaitou_Data.one + 1;
            }
            if( data.kaitou == 2){
                Kaitou_Data.two = Kaitou_Data.two + 1;
            }
            if( data.kaitou == 3){
                Kaitou_Data.three = Kaitou_Data.three + 1;
            }
            if( data.kaitou == 4){
                Kaitou_Data.four = Kaitou_Data.four + 1;
            }
        }
        function chart(data){
                var barChartData = {
                  labels : ["1","2","3","4"],
                  datasets : [
                    {
                      fillColor : "rgba(220,220,220,0.5)",
                      strokeColor : "rgba(220,220,220,1)",
                      data : [Kaitou_Data.one,Kaitou_Data.two,Kaitou_Data.three,Kaitou_Data.four]
                    }

                  ]
                }
                var option = {
                      //縦軸の目盛りの上書き許可。これ設定しないとscale関連の設定が有効にならないので注意。
                      scaleOverride : true,

                      //以下設定で、縦軸のレンジは、最小値0から5区切りで35(0+5*7)までになる。
                      //縦軸の区切りの数
                      scaleSteps : 7,
                      //縦軸の目盛り区切りの間隔
                      scaleStepWidth : 5,
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
      .canvas{
          height:250px;
          width:500px;
      }



  </style>









</owner>
