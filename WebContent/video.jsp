<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<!-- 
1:检测插件具体情况

2:检测视频、音频设备是否安装正常


 -->
<head>
<title>视频见证</title>
<style type="text/css">
.w{ width:100%; clear:both; overflow:hidden;}
.c{ width:25%; float:left;border:1px solid green;height:200px;}
.d{ width:25%; margin-left:25%;border:1px solid orange;height:200px;margin-top: 200px}
.e{ width:25%; margin-left:50%;border:1px solid orange;height:200px;margin-top: -202px}
#recordvideo{width: 10% ;margin-left:4%;height:50px;margin-top: 20px}
#takephoto{width: 10% ;margin-left:4%;height:50px;margin-top: 20px}
#takephoto{width: 10% ;margin-left:4%;height:50px;margin-top: 20px}
#riskexam{width: 10% ;margin-left:4%;height:50px;margin-top: 20px}
#time{width: 10% ;margin-left:4%;height:50px;margin-top: 20px}
#playvideo{width: 10% ;margin-left:4%;height:50px;margin-top: 20px}
</style>
<script src="./javascript/jquery.min.js"></script>
<script src="./javascript/anychatsdk.js"></script>
<!-- <script src="./javascript/advanceset.js"></script> -->
<script src="./javascript/anychatevent.js"></script>

</head>
<body>
<OBJECT id="bjcaCameraOcx" name="bjcaCameraOcx" classid="clsid:3C97582F-DE8A-4C2E-8B97-22D14032BD40" width = "600" height = "400"></OBJECT>
	<div class="w" id="AnyChatLocalVideoDiv">
	    <div class="c" id="c"></div>
	    <div class="d" id="d"></div>
	    <div class="e" id="e"></div>
	   
	              控制显示用户的摄像头:<select id="selectone" onchange="chooseservice(1)"></select>
		控制显示客服的摄像头:<select id="selecttwo" onchange="chooseservice(2)"></select><br>
	    <button id="recordvideo">开始录制</button>
	    <button id="takephoto">开始拍照</button>
	    <button id="riskexam">风险测评</button><br>
	    <button id="time">计时器</button>
	    <button id="playvideo">视频播放</button>
	    <button id="photo" onclick="openCamera1()">高拍仪</button>
	    <button id="take" onclick="captureImage()">拍照</button>
	    <input type="hidden" id="select1"  value="">
	    <input type="hidden" id="select2"  value="">
	    
	    <a href="video.flv">234567</a>
	</div>
	<div class="video">
		<table><tr>
			<td valign="top" align="center">
				
				<input type="text" style="width:200px;height:25px;background-color:#CEE1C4;border-width:1px; border-style:none;border-color:white;" id="captureresult" ><br/><br/>
			</td>
		</tr></table>
	</div>
	<div  id="image_result1" title="此处显示拍照图片" style="width:300px;height:200px">
	
	</div>
	<div  id="image_result2" title="此处显示拍照图片" style="width:300px;height:200px">
		           </div>
</body>
<script type="text/javascript">
	var EMPID;
	var CUSTOMERID;
	var CAMERA_COUNT;
	var pictureUrl;
	var videoUrl;
	//提示用户是否对插件进行检测
	$(document).ready(function() { 
		/*1:弹出对话框对其进行相应的提示，点击确定后调用另一方法对插件是否安装情况进行校验*/
		checksdk();
		login();
		setTimeout(function(){
			getDevicsCount();
		},1000)
	}); 
	
	
	function checksdk(){
		var NEED_ANYCHAT_APILEVEL = '0';
		var CODE = BRAC_InitSDK(NEED_ANYCHAT_APILEVEL);
		if(CODE==GV_ERR_SUCCESS){
			return;
		}else if(CODE==GV_ERR_PLUGINNOINSTALL){
			/*插件未进行安装*/
		}else{
			/*插件版本太低，请进行升级*/
		}
	}
	
	function login(){
		BRAC_Connect("127.0.0.1", 8906);
		BRAC_Login("000000", "", 0);
		BRAC_EnterRoom(20000, "", 0);
	}
	
	function getDevicsCount(){
		CAMERA_COUNT = BRAC_EnumDevices(1);
		var customerDevice = GetID('selectone');
		var customerServiceDevice = GetID('selecttwo');
		for(var i=0;i<CAMERA_COUNT.length;i++){
			var optcustomer = new Option(CAMERA_COUNT[i],i);
			var optcustomerservice = new Option(CAMERA_COUNT[i],i);
		    customerDevice.add(optcustomer);
		    customerServiceDevice.add(optcustomerservice);
		}
		BRAC_SetVideoPosEx(mSelfUserId, GetID("c"), "AnyChatLocalVideoDiv"+0,0);// 
		BRAC_UserCameraControlEx(mSelfUserId,1,0,0, "");
		BRAC_UserSpeakControl(mSelfUserId, 1);
		
		BRAC_SetVideoPosEx(mSelfUserId, GetID("d"), "AnyChatLocalVideoDiv"+1,1);// 
		BRAC_UserCameraControlEx(mSelfUserId,1,1,0, "");
		BRAC_UserSpeakControl(mSelfUserId, 1);
		$("#selectone option[value='0']").attr("selected",true);
		$("#selecttwo option[value='1']").attr("selected",true);
		$("#select1").attr("value",0);
		$("#select2").attr("value",1);
	}
	
	function chooseservice(id){
		if(id==1){
			/*将要被选中的设备*/
			var value1 = $("#selectone").val();
			var text = $("#selectone").find("option:selected").text();
			/*获取下拉框2已经被选中的OPTION*/
			var obj = document.getElementById("selecttwo");
	        var value2 = obj.options[obj.selectedIndex].value;
	        if(value1==value2){
	        	alert("该摄像头已被占用！")
	        	$("#selectone option[value='"+$("#select1").val()+"']").attr("selected",true);
	        }else{
		        $("#c").find("object").remove();
		        BRAC_SetVideoPosEx(mSelfUserId, GetID("c"), "AnyChatLocalVideoDiv"+value1,value1);
		        BRAC_UserCameraControlEx(mSelfUserId,1,value1,0, "");
				BRAC_UserSpeakControl(mSelfUserId, 1);
				$("#select1").attr("value",value1);
		       /*  BRAC_SelectVideoCapture(1,text); */
	        } 
		}else if(id==2){
			/*将要被选中的设备*/
			var value2 = $("#selecttwo").val();
			/*获取下拉框1已经被选中的OPTION*/
			var obj = document.getElementById("selectone");
	        var value1 = obj.options[obj.selectedIndex].value;
	        if(value2==value1){
	        	alert("该摄像头已被占用！")
	        	$("#selecttwo option[value='"+$("#select2").val()+"']").attr("selected",true);
	        }else{
		        $("#d").find("object").remove();
		        BRAC_SetVideoPosEx(mSelfUserId, GetID("d"), "AnyChatLocalVideoDiv"+value2,value2);
		        BRAC_UserCameraControlEx(mSelfUserId,1,value2,0, "");
				BRAC_UserSpeakControl(mSelfUserId, 1);
				$("#select2").attr("value",value2);
	        } 
		}
	}
	
	function GetID(id) {
		if (document.getElementById) {
			return document.getElementById(id);
		} else if (window[id]) {
			return window[id];
		}
		return null;
	}
	
    //开始录制事件
    function startCount() {
		var HH = 0;
	    var mm = 0;
	    var ss = 0;
	    var str = "";
        timer = setInterval(function(){
        	str = "";
        	if(++ss==60){
        		if(++mm==60){
        			HH++;
        			mm=0;
        		}
        		ss=0;
        	}
        	str+=HH<10?"0"+HH:HH;
        	str+=":";
        	str+=mm<10?"0"+mm:mm;
        	str+=":";
        	str+=ss<10?"0"+ss:ss;
        	document.getElementById("time").innerHTML = str;
        },1000);
    }
    
    //停止录制事件
    function stopCount() {
        clearInterval(timer);
    }
    
  //window.location.href = 'SignResult.html';
	var m_failedPhoto = 0;
	var m_successPhoto = 0;

	function captureImage()
	{
		
		//openCamera1();
        if (bjcaCameraOcx.GetStatus() != 0)
	    {
            document.getElementById("captureresult").value = "高拍仪未连接, 请点击‘拍照完成’后重新插入高拍仪再打开此页面";
		    m_failedPhoto++;
		    return;
	    }

	    var csImage = bjcaCameraOcx.CapImg2Mem();
	    if(csImage.Length == 0)
	    {
            document.getElementById("captureresult").value = "CapImg2Disk fail";
		    m_failedPhoto++;
	    }
	    else{
		    m_successPhoto++;
	    }
		//var ids="image_result1"+"_s";
		//document.getElementById("image_result1").innerHTML = "<img id="+ids+" src=\"data:image/jpeg;base64,"+csImage+"\" //width=\"200\" height=\"150\"  onmouseover=\"over("+ids+")\" onmouseout='out()' \>";
		if(m_successPhoto%2 == 1)
		     document.getElementById("image_result1").innerHTML = "<img src=\"data:image/jpeg;base64,"+csImage+"\" width=\"300\" height=\"200\">";  
	    else
		     document.getElementById("image_result2").innerHTML = "<img src=\"data:image/jpeg;base64,"+csImage+"\" width=\"300\" height=\"200\">";  
	    var sMsg = "拍照成功：";
	    sMsg += m_successPhoto;
	    sMsg += "张;";
	    sMsg += "拍照失败：";
        sMsg += m_failedPhoto;
	    sMsg += "张";
        document.getElementById("captureresult").value = sMsg; 
	}
	 
	function openCamera1()
	{
		var id = 1;
		var lRet = bjcaCameraOcx.Init(id);
		if (lRet != 0)
        {
            alert("init fail");
            return;
        }
        lRet = bjcaCameraOcx.SetCaptureSize(800, 600);
        if (lRet != 0)
        {
            alert("SetCaptureSize fail");
            return;
        }
        lRet = bjcaCameraOcx.Start();
        if (lRet != 0)
        {
            alert("Start fail");
            return;
        }
        bjcaCameraOcx.SetImgDPI(200);
        bjcaCameraOcx.SetImgType(2, 20);
		var ret = bjcaCameraOcx.SetCrop(1);
		alert(ret);
	}
	
	/* function openCamera2()
	{
		var id = 2;
		var lRet = bjcaCameraOcx.Init(id);
		if (lRet != 0)
        {
            alert("init fail");
            return;
        }
        lRet = bjcaCameraOcx.SetCaptureSize(1600, 1200);
        if (lRet != 0)
        {
            alert("SetCaptureSize fail");
            return;
        }
        lRet = bjcaCameraOcx.Start();
        if (lRet != 0)
        {
            alert("Start fail");
            return;
        }
        bjcaCameraOcx.SetImgDPI(200);
        bjcaCameraOcx.SetImgType(2, 100);
	}

	function stopCamera()
	{
        var lRet = bjcaCameraOcx.Stop();
        if (bjcaCameraOcx.GetStatus() == 0)
            bjcaCameraOcx.Stop();
        else
        {
            document.getElementById("captureresult").value = "停止拍照失败";
            return;
        }
        bjcaCameraOcx.Release();	
	}
    
	function open(){
		window.open ("test.html", "", "height=400, width=400"); 
		openCamera1()
		setTimeout(captureImage, 5000);
	}  */
</script>
<script src="./javascript/login.js"></script>
</html>