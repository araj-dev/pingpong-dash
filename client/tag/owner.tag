<owner>
<div id="main">
<div if={ vis == 1}>
<p>Profile</p>
<p onclick={toSelect} class="link">Start PingPong</p>
<p class="link">ログアウト</p>
</div>

<div if={ vis == 2}>
<p>ルームコード</p>
<p onclick={toResult} class="link">４つの中から選ぶ</p>
</div>

<div if={ vis == 3}>
<div id="result">結果表示画面</div>
<p onclick={toSelect} class="link">回答を締め切る</p>
</div>

</div>



<script>
var self = this;
this.vis = 1;

toSelect = function(){
this.vis = 2;
}

toResult = function(){
this.vis = 3;
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



  </style>









</owner>