package com.b2max.common.data
{

	[Bindable]
	public class ConstData
	{
		public static const GOOGLESTTKEY0						:String = "AIzaSyDVAp5iJi8ys3KHHF53yPOC2t7U4nYCNqo";	// code5382@gmail.com
		public static const GOOGLESTTKEY1						:String = "AIzaSyBSzYZbkSs3ptphyAzNSlSskzlKoi3LnR4";	// code5384@gmail.com
		public static const GOOGLESTTKEY2						:String = "AIzaSyAqMdQ1VKVqP__JWN6_PzzYGJt7mTuJCgw";	// code5385@gmail.com
		public static const GOOGLESTTKEY3						:String = "AIzaSyAeMCIEvpOPq5ispNdTZX5ieYkvlc3q_UU";	// code5387@gmail.com
		public static const GOOGLESTTKEY4						:String = "AIzaSyCnl6MRydhw_5fLXIdASxkLJzcJh5iX0M4";	// 출처모르는 Key
		public static const GOOGLESTTKEYS						:Array = [GOOGLESTTKEY0, GOOGLESTTKEY1, GOOGLESTTKEY2, GOOGLESTTKEY3, GOOGLESTTKEY4]; 
		
		public static const MS_TRANS_KEY0			:Object = {id: "code5381", key: "tlXKfs+KWwTS/iNta39ZUM0RH1x3L8YyBM7i6wZjsXo="};	// code5381@hotmail.com
		public static const MS_TRANS_KEY1			:Object = {id: "code5382", key: "IPWCTm6xfWYm/tpvlhkXoqo3zbMQ8QSXyPZn/Ie/XY0="};	// code5382@hotmail.com
		public static const MS_TRANS_KEY2			:Object = {id: "code5383", key: "qNVDuaWcCdjRmcOhVbCoaNluTwWuvKn87DNpyVBumUc="};	// code5383@hotmail.com
		public static const MS_TRANS_KEY3			:Object = {id: "code5384", key: "Jm2HJgeS97X9i8+FKSulsbV7zJbtSlHVeMfy9gGohKQ="};	// code5384@hotmail.com
		public static const MS_TRANS_KEY4			:Object = {id: "code5385", key: "OyZzhYpfmxaMxxWMJJWH9oYDkbEcRdheUowUUxm85ms="};	// code5385@hotmail.com
		public static const MS_TRANS_KEYS			:Array = [MS_TRANS_KEY0, MS_TRANS_KEY1, MS_TRANS_KEY2, MS_TRANS_KEY3, MS_TRANS_KEY4];
		
		public static const DESIGN_UI_01:String = "designUI01";
		public static const DESIGN_UI_02:String = "designUI02";
		
		// GlobalData.MODE 상수정의
		public static const USER_STATE_NORMAL:int = 0;
		public static const USER_STATE_OBSERVER:int = 1;
		
		// 방장/방원 상수 정의 
		public static const USER_LEVEL_SUPER:int = 0;
		public static const USER_LEVEL_NORMAL:int = 1;
		
		// 웹호출 Auth state 상수 정의
		public static const USER_LMS_TUTOR:int = 0;			// 선생(방장)
		public static const USER_LMS_STUDENT:int = 1;		// 학생(방원)
		public static const USER_LMS_OBSERVER:int = 2;		// 옵저버
		
		public static const AUTH_NORMAL:int = 0;			// 기존방식
		public static const AUTH_API:int = 1;				// API연동
		
		public static const ENTERROOM_TYPE_JOIN:String="enterroom_type_join";
		public static const ENTERROOM_TYPE_CREATEROOM:String="enterroom_type_createroom";
		public static const ENTERROOM_TYPE_OBSERVER:String="enterroom_type_observer";
		
		public static const P1_CONF:String = "p1_conf";				// 회의방 > 문서회의(비디오 무)
		public static const P1_EDU:String = "p1_edu";				// 교육방 > 문서강의(비디오 무)
		public static const P2_CONF:String = "p2_conf";				// 회의방 > 문서회의, 영상회의, 프리젠테이션
		public static const P3_DEBATE:String = "p3_debate";			// 토론방
		public static const P4_COUN:String = "p4_coun";				// 상담방
		public static const P5_EDU:String = "p5_edu";				// 교육방
		public static const P6_CONF:String = "p6_conf";				// 회의방 > 사내방송
		public static const P6_EDU:String = "p6_edu";				// 교육방 > 방송강의
		public static const P7_REMOTE:String = "p7_remote";			// 원격공유/제어
		
		public static const M0:Array = [ P1_CONF ];
		public static const M1:Array = [ P1_EDU ];
		public static const M2:Array = [ P2_CONF ];
		public static const M3:Array = [ P3_DEBATE ];
		public static const M4:Array = [ P4_COUN ];
		public static const M5:Array = [ P5_EDU ];
		public static const M6:Array = [ P6_CONF ];
		public static const M7:Array = [ P6_EDU ];
		public static const M8:Array = [ P1_CONF, P3_DEBATE ];
		public static const M9:Array = [ P2_CONF, P3_DEBATE ];
		public static const M10:Array = [ P4_COUN, P5_EDU ];
		
		
		
		public static const ROOM_TYPE_CONF:String = "room_type_conf";
		public static const ROOM_TYPE_EDU:String = "room_type_edu";
		public static const ROOM_TYPE_DEBATE:String = "room_type_debate";
		public static const ROOM_TYPE_COUNSEL:String = "room_type_counsel";
		public static const ROOM_TYPE_BROAD:String = "room_type_broad";
		public static const ROOM_TYPE_REMOTE:String = "room_type_remote";
		public static const ROOM_TYPE_CHAT:String = "room_type_chat";
		
		// PRODUCT PACKAGE MODE
		public static const ROOM_TYPE_P1_CONF:String = "room_type_p1_conf";
		public static const ROOM_TYPE_P1_EDU:String = "room_type_p1_edu";
		public static const ROOM_TYPE_P2_CONF:String = "room_type_p2_conf";
		public static const ROOM_TYPE_P6_CONF:String = "room_type_p6_conf";
		public static const ROOM_TYPE_P6_EDU:String = "room_type_p6_edu";
		public static const ROOM_TYPE_P7_REMOTE:String = "room_type_p7_remote";
		
		// 신규 디자인 버전 적용
		public static const MODE_MOVIE_DOC:String = "mode_movie_doc";		// layoutName = "영상문서"				layoutSetName = "영상문서회의"
		public static const MODE_MOVIE_PT:String = "mode_movie_pt";			// layoutName = "영상프리젠테이션"		layoutSetName = "영상프리젠테이션"
		public static const MODE_MOVIE:String = "mode_movie";				// layoutName = "영상"					layoutSetName = "영상회의"
		public static const MODE_VOICE_DOC:String = "mode_voice_doc";		// layoutName = "음성문서"				layoutSetName = "음성문서회의"
		public static const MODE_VOICE_PT:String = "mode_voice_pt";			// layoutName = "음성프리젠테이션"		layoutSetName = "음성프리젠테이션"
		public static const MODE_VOICE:String = "mode_voice";				// layoutName = "음성"					layoutSetName = "음성회의"
		public static const MODE_CHAT_DOC:String = "mode_chat_doc";			// layoutName = "채팅문서"				layoutSetName = "채팅문서회의"
		public static const MODE_CHAT:String = "mode_chat";					// layoutName = ""						layoutSetName = ""
		public static const MODE_BROAD:String = "mode_broad";				// layoutName = ""						layoutSetName = ""
		public static const MODE_VOICE_REMOTE:String = "mode_voice_remote";	// layoutName = "음성원격제어"
		public static const MODE_MOVIE_REMOTE:String = "mode_movie_remote";	// layoutName = "영상원격제어"
		public static const MODE_CHAT_REMOTE:String = "mode_chat_remote";	// layoutName = "채팅원격제어"
		
		
		
		
		public static const MODE_CONF_DOC:String = "mode_conf_doc";
		public static const MODE_CONF_LITE_DOC:String = "mode_conf_lite_doc";
		public static const MODE_CONF_MOV:String = "mode_conf_mov";
		public static const MODE_CONF_SEMI:String = "mode_conf_semi";
		public static const MODE_CONF_PT:String = "mode_conf_pt";
		public static const MODE_CONF_BROD:String = "mode_conf_brod";
		public static const MODE_CONF_EDU:String = "mode_conf_edu";
		
		public static const MODE_EDU_DOC:String = "mode_edu_doc";
		public static const MODE_EDU_LITE_DOC:String = "mode_edu_lite_doc";
		public static const MODE_EDU_MOV:String = "mode_edu_mov";
		public static const MODE_EDU_SEMI:String = "mode_edu_semi";
		public static const MODE_EDU_PT:String = "mode_edu_pt";
		public static const MODE_EDU_BROD:String = "mode_edu_brod";
		
		public static const MODE_DEBATE_MOV:String = "mode_debate_mov";
		public static const MODE_DEBATE_DOC:String = "mode_debate_doc";
		
		public static const MODE_DEBATE_FREE_MOV:String = "mode_debate_free_mov";
		public static const MODE_DEBATE_FREE_DOC:String = "mode_debate_free_doc";
		
		public static const MODE_COUNSEL_MOV:String = "mode_counsel_mov";
		public static const MODE_COUNSEL_DOC:String = "mode_counsel_doc";
		
		public static const MODE_USER:String = "mode_user";
		
		public static const DEBATE_TYPE_FREE:int = 0;		// 자유토론
		public static const DEBATE_TYPE_LD:int = 1;			// 링컨-더글러스식 토론
		public static const DEBATE_TYPE_COUNCIL:int = 2;	// 의회식 토론
		public static const DEBATE_TYPE_CEDA:int = 3;		// CEDA식 토론
		public static const DEBATE_TYPE_KARL:int = 4;		// 칼포퍼식 토론
		
		public static const DEBATE_MODE_MC_IN:int = 0;
		public static const DEBATE_MODE_MC_OUT:int = 1;
		
		public static const DEFAULT_TYPE_USER:int = -1;				// 디폴트
		public static const DEBATE_TYPE_USER_MC:int = 0;			// 사회자
		public static const DEBATE_TYPE_USER_SECONDER:int = 1;		// 찬성자
		public static const DEBATE_TYPE_USER_DISSENTER:int = 2;		// 반대자
		public static const DEBATE_TYPE_USER_VISITOR:int = 3;		// 참관자
		
		public static const DEBATE_STATE_ARGUMENT:int = 0;			// 입론
		public static const DEBATE_STATE_QUESTION:int = 1;			// 질의	
		public static const DEBATE_STATE_REVERSE:int = 2;			// 반론
		public static const DEBATE_STATE_RESULT:int = 3;			// 결론
		
		public static const DEBATE_PROGRESS_ENABLE:int = 0;			// 디폴트
		public static const DEBATE_PROGRESS_ACTIVE:int = 1;			// 활성
		public static const DEBATE_PROGRESS_DISABLE:int = 2;		// 비활성
		
		public static const DEBATE_VOTE_YESNO:int = 0;			// 찬반투표
		public static const DEBATE_VOTE_SURVEY:int = 1;			// 설문투표
		
		public static const VOTE_YESNO_NO:int = 0;			// 반대
		public static const VOTE_YESNO_YES:int = 1;			// 찬성
		
		public static const DEBATE_SPEAK_REQUEST_INTERVAL:int = 15000;	// 디폴트 요청 발언권 시간
		
		public static const KNOW_TYPE_MOTION:String = "knowTypeMotion";
		public static const KNOW_TYPE_VOICE:String = "knowTypeVoice";
		
		public static const VIDEO_USER_MAX:int = 4;
		
		public static const DEFAULT_MODE_INDEX:int = 0;
		
		public static const FILE_EXTENSION_ALL:Array = ["*"];
		//public static const FILE_EXTENSION_DOC:Array = ["odt", "sxw", "rtf", "doc", "docx", "wpd", "txt", "html", "ods", "sxc", "xls", "xlsx", "csv", "tsv", "odp", "sxi", "ppt", "pptx", "odg", "pdf"];
		// .txt파일 주석처리함
		public static const FILE_EXTENSION_DOC:Array = ["odt", "sxw", "rtf", "doc", "docx", "wpd", "html", "ods", "sxc", "xls", "xlsx", "csv", "tsv", "odp", "sxi", "ppt", "pptx", "odg", "pdf", "txt"];
		public static const FILE_EXTENSION_IMG:Array = ["jpg", "jpeg", "gif", "png"];
		
		
		
		
		
		public static const MODE_WEB:String = "modeWeb";
		public static const MODE_APP:String = "modeApp";
		public static const MODE_MOBILE:String = "modeMobile";
		
		public static const MODE_CHAT_NORMAL:String = "modeChatNormal";
		public static const MODE_CHAT_VIDEO:String = "modeChatVideo";
		public static const MODE_CHAT_COUNSEL:String = "modeChatCounsel";
		
		public static const MODE_MEDIA_CHAT:String = "modeMediaChat";
		public static const MODE_MEDIA_CONF:String = "modeMediaConf";
		
		public static const MOBILE_STATE_APP_0:String = "APP_0";
		public static const MOBILE_STATE_APP_1:String = "APP_1";
		public static const MOBILE_STATE_APP_2:String = "APP_2";
		public static const MOBILE_STATE_CHAT_0:String = "CHAT_0";
		public static const MOBILE_STATE_CHAT_1:String = "CHAT_1";
		public static const MOBILE_STATE_CHAT_2:String = "CHAT_2";
		
		public static const M_CLOSE:String = "menu_close";
		
		public static const M_MG:String = "menu_mg";
		public static const M_MAIL:String = "menu_mail";
		public static const M_GW:String = "menu_gw";
		
//		public static const M_FILE:String = "menu_file";
//		public static const M_CHECK:String = "menu_check";
//		public static const M_MASTER:String = "menu_master";
//		public static const M_USER:String = "menu_user";
//		public static const M_ATTEND:String = "menu_attend";
//		public static const M_WORK:String = "menu_work";
//		public static const M_BIZ:String = "menu_biz";
//		public static const M_FORM:String = "menu_form";
//		public static const M_CONF:String = "menu_conf";
		
		public static const MM_CHAT:String = "menu_msg_chat";
		public static const MM_MIC:String = "menu_msg_mic";
		public static const MM_CAM:String = "menu_msg_cam";
		public static const MM_DOC:String = "menu_msg_doc";
		public static const MM_TOTAL:String = "menu_msg_total";
		public static const MM_SHARE_PART:String = "menu_msg_share_part";
		public static const MM_SHARE_FULL:String = "menu_msg_share_full";
		public static const MM_REMOTE_FULL:String = "menu_msg_remote_full";
		public static const MM_SETUP:String = "menu_msg_setup";
		
		public static const MC_TEXT:String = "menu_chat_text";
		public static const MC_MIC:String = "menu_chat_mic";
		public static const MC_CAM:String = "menu_chat_cam";
		public static const MC_DOC:String = "menu_chat_doc";
		public static const MC_TOTAL:String = "menu_chat_total";
		public static const MC_SHARE_PART:String = "menu_chat_share_part";
		public static const MC_SHARE_FULL:String = "menu_chat_share_full";
		public static const MC_REMOTE_FULL:String = "menu_chat_remote_full";
		public static const MC_MSG:String = "menu_chat_msg";
		public static const MC_FILE:String = "menu_chat_file";
		public static const MC_CAMERA:String = "menu_chat_camera";
		
		public static const color_menu_close:uint = 0x838383;
		public static const color_menu_chat_mic:uint = 0x75A43C;
		public static const color_menu_chat_cam:uint = 0x44A8B7;
		public static const color_menu_chat_doc:uint = 0xBFA42F;
		public static const color_menu_chat_total:uint = 0x9877BC;
		public static const color_menu_chat_share_part:uint = 0xD47837;
		public static const color_menu_chat_share_full:uint = 0x7882C9;
		public static const color_menu_chat_remote_full:uint = 0xC97068;
		
		public static const MF_CAM:String = "menu_conf_cam";
		public static const MF_CHAT:String = "menu_conf_chat";
		public static const MF_DOC:String = "menu_conf_doc";
		public static const MF_USERS:String = "menu_conf_users";
		
		public static const CM_MIC:String = "control_media_mic";
		public static const CM_SPEAKER:String = "control_media_speaker";
		public static const CM_CAMERA:String = "control_media_camera";
		public static const CD_REQUEST:String = "control_debate_request";
		public static const CM_CAM_ONOFF:String = "control_media_cam_onoff";
		
		public static const color_room_type_conf:uint = 0x71A235;
		public static const color_room_type_edu:uint = 0xC1A42F;
		public static const color_room_type_debate:uint = 0x8594ED;
		public static const color_room_type_counsel:uint = 0x48C3D5;
		
		public static const color_menu_conf_cam:uint = 0x71A235;
		public static const color_menu_conf_chat:uint = 0xC1A42F;
		public static const color_menu_conf_doc:uint = 0x44A6B6;
		public static const color_menu_conf_users:uint = 0xD47837;
		
		public static const color_lobby_menu:uint = 0x838383;
		
		public static const NONE_CHECKED:int = 0;
		public static const OK_CHECKED:int = 1;
		public static const PART_CHECKED:int = 2;
		
		public static const LABEL_START:String = "start";
		public static const LABEL_PAUSE:String = "pause";
		public static const LABEL_STOP:String = "stop";
		public static const LABEL_NEXT:String = "next";
		public static const LABEL_SKIP:String = "skip";
		public static const LABEL_END:String = "end";
		public static const LABEL_PROGRESS:String = "progress";
	}
}