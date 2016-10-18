// 登录 

function loginAnychat(){
	ERRORCODE = BRAC_InitSDK(NEED_ANYCHAT_APILEVEL);
	BRAC_Connect("127.0.0.1", 8906);
	BRAC_Login("005", "", 0);
	BRAC_EnterRoom(10, "", 0);
} 

function startDevice(){
	CAMERA_COUNT=BRAC_EnumDevices(1);
	BRAC_SetVideoPosEx(mSelfUserId, GetID("serverPeople"), "AnyChatLocalVideoDiv"+CAMERA_COUNT[0],0);// 
	BRAC_UserCameraControlEx(mSelfUserId,1,0,0, "");
	BRAC_UserSpeakControl(mSelfUserId, 1);
//	BRAC_SetVideoPos(-46, GetID("customerPeople"), "ANYCHAT_VIDEO_REMOTE");
}

function GetID(id) {
	if (document.getElementById) {
		return document.getElementById(id);
	} else if (window[id]) {
		return window[id];
	}
	return null;
}