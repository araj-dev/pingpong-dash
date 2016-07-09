<owner>
<div id="main">
<div if={ vis == 1}>
<p>Profile</p>
<p onclick={toSelect} class="link">Start PingPong</p>
<p class="link">ログアウト</p>


</div>

<div if={ vis == 2}>
<p>{roomname}</p>
<form name="question">
選択肢の数を記入<input type="text" class="inputText" maxlength="1" name="selectNum" pattern="^[0-9A-Za-z]+$">
<p onclick={selectNumber} class="link">アンケート</p>
</form>
<p onclick={toResult} class="link">テキスト送信</p>


</div>

<div if={ vis == 3}>
<div id="result_canvas">
<canvas id="bar" class="canvas"></canvas></div>
<p onclick={backSelect} class="link">回答を締め切る</p>
</div>
<div if={ vis == 4}>
<div id="result_text"></div>
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
            Kaitou_Check(data);
            if( data.type == 'select_answer'){
                chart(Kaitou_Data);
                            
            }
            if(data.type == 'text_answer'){
                console.log(data);
                document.getElementById("result_text").appendChild(data.Answer);
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
                type:'text',
            };     
            self.socket.emit('OtoG',data);
            self.vis = 4;
            self.update();
        }

        selectNumber = function(){
            Kaitou_Data.SN = document.question.selectNum.value;
            var data = {
                type:'yontaku',
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
        backSelect = function(){
            if( Kaitou_Data.SN == 0){
                self.vis = 2;
            }else if(Kaitou_Data.SN > 0){
                Date_Zero(Kaitou_Data);
                chart(Kaitou_Data);
                self.vis = 2;
            }
            
            
            
        }
  //----------------------------------------------------function 
        function Date_Zero(obj){
            obj.X.length = 0;
            obj.Y.length = 0;
                //for( var i = 0;i<obj.SN;i++){
                    
                //obj.Y[i] = 0; 
            //}
        }
        function Kaitou_Check(data2){
                
                if ( data2.kaitou){
                    Kaitou_Data.Y[data2.kaitou-1] = Kaitou_Data.Y[data2.kaitou-1] + 1;
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
    #result_canvas{
    border:1px solid green;
    height:250px;
    }
    #result_text{
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
      



  </style>









</owner>
