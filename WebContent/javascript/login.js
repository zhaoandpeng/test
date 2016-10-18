/*以下参数请勿随意改动
 * ANYCHAT参数设置
 * */


var mDefaultServerAddr = "127.0.0.1:8080/Test";			// 默认服务器地址

var mDefaultServerPort = 8906;					// 默认服务器端口号

var mSelfUserId; 							// 本地用户ID

var mTargetUserId = -1;							// 目标用户ID（请求了对方的音视频）

var isRecord = false;

var timer;

var videoUrl;

//录制视频事件0x1b37;
GetID("recordvideo").onclick = function () {
	var dwFlags = BRAC_RECORD_FLAGS_LOCALCB + 
				  BRAC_RECORD_FLAGS_VIDEO + 
				  BRAC_RECORD_FLAGS_AUDIO + 
				  BRAC_RECORD_FLAGS_SERVER + 
				  BRAC_RECORD_FLAGS_MIXAUDIO+
				  BRAC_RECORD_FLAGS_MIXVIDEO+
				  BRAC_RECORD_FLAGS_ABREAST+
				  BRAC_RECORD_FLAGS_STEREO+
				  BRAC_RECORD_FLAGS_STREAM+
				  BRAC_RECORD_FLAGS_USERFILENAME;
	if(!isRecord){
		isRecord = true;
		GetID("recordvideo").innerHTML = "结束录制";
		startCount();
		BRAC_StreamRecordCtrlEx(mSelfUserId, 1, dwFlags, 1, '{"filename":"eeeee"}');
	}else{
		isRecord = false;
		GetID("recordvideo").innerHTML = "开始录制";
		stopCount()
		BRAC_StreamRecordCtrlEx(mSelfUserId, 0, dwFlags, 1, '{"filename":"eeeee"}');
		
	}
	
}

//抓拍照片
GetID("takephoto").onclick=function(){
	BRAC_SnapShot(mSelfUserId,"","")
	alert(pictureUrl)
}

//播放视频
GetID("playvideo").onclick=function(){
	var videou = mDefaultServerAddr+'/'+videoUrl;
	var html = 
		'<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="320" height="200"><param name="movie" value="play/pl.swf" /><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="flashvars" value="file=http://'+videou+'&image=/play/preview.jpg" /><embed type="application/x-shockwave-flash" id="player2" name="player2" src="play/pl.swf" width="320" height="200" allowscriptaccess="always" allowfullscreen="true" flashvars="file=http://'+videou+'&image=play/preview.jpg" /></object>'
		;
		$("#e").html(html);
						
}

//获取页面ID
function GetID(id) {
	if (document.getElementById) {
		return document.getElementById(id);
	} else if (window[id]) {
		return window[id];
	}
	return null;
}



