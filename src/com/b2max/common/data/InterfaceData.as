////////////////////////////////////////////////////////////////////////////////
//
// B2MAX Incorporated
// Copyright 2013 B2MAX Incorporated
// All Rights Reserved.
//  
// NOTICE: B2MAX NEVER permits you to use, modify, and distribute this file.
//
////////////////////////////////////////////////////////////////////////////////
package com.b2max.common.data
{
	import com.b2max.common.ui.vo.LayoutVO;
	import com.b2max.common.utils.ValidateUtil;
	import com.b2max.common.vo.DataInfoVO;
	import com.b2max.common.vo.DebateItemVO;
	import com.b2max.common.vo.LabelVO;
	import com.b2max.common.vo.MenuPropVO;
	import com.b2max.common.vo.MenuVO;
	import com.b2max.common.vo.UserVO;
	
	import mx.collections.ArrayList;
	import mx.utils.ObjectUtil;

	
	[Bindable]
	public class InterfaceData
	{
		public static var userID:String;
		public static var userName:String;
		public static var roomID:String;
		public static var roomName:String;
		public static var roomType:String;
		public static var roomInfoType:int = -1;
		
		public static const P1_CONF:String = "p1_conf";				// 회의방 > 문서회의(비디오 무)
		public static const P1_EDU:String = "p1_edu";				// 교육방 > 문서강의(비디오 무)
		public static const P2_CONF:String = "p2_conf";				// 회의방 > 문서회의, 영상회의, 프리젠테이션
		public static const P3_DEBATE:String = "p3_debate";			// 토론방
		public static const P4_COUN:String = "p4_coun";				// 상담방
		public static const P5_EDU:String = "p5_edu";				// 교육방
		public static const P6_CONF:String = "p6_conf";				// 회의방 > 사내방송
		public static const P6_EDU:String = "p6_edu";				// 교육방 > 방송강의
		public static const P7_REMOTE:String = "p7_remote";			// 원격공유/제어
		
		public static var isPackageMode:Boolean;
		public static var productPackageSet:Array = [];
		
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
		
		public static var productPackageList:ArrayList = new ArrayList( [
			ConstData.M0, ConstData.M1, ConstData.M2, ConstData.M3, ConstData.M4, ConstData.M5, ConstData.M6, ConstData.M7, ConstData.M8, ConstData.M9, ConstData.M10
		] );
		
		public static const ROOM_TYPE_CLOSE:DataInfoVO = new DataInfoVO( ConstData.M_CLOSE, "" );
		
		public static const ROOM_TYPE_CONF:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_CONF, GlobalData.labelVO.room_type_conf );
		public static const ROOM_TYPE_EDU:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_EDU, GlobalData.labelVO.room_type_edu );
		public static const ROOM_TYPE_DEBATE:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_DEBATE, GlobalData.labelVO.room_type_debate );
		public static const ROOM_TYPE_COUNSEL:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_COUNSEL, GlobalData.labelVO.room_type_counsel );
		public static const ROOM_TYPE_BROAD:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_BROAD, GlobalData.labelVO.room_type_broad );
		public static const ROOM_TYPE_REMOTE:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_REMOTE, GlobalData.labelVO.room_type_remote );
		public static const ROOM_TYPE_CHAT:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_CHAT, GlobalData.labelVO.room_type_chat );
		
		// PRODUCT PACKAGE MODE
		public static const ROOM_TYPE_P1_CONF:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_P1_CONF, GlobalData.labelVO.room_type_conf );
		public static const ROOM_TYPE_P1_EDU:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_P1_EDU, GlobalData.labelVO.room_type_edu );
		public static const ROOM_TYPE_P2_CONF:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_P2_CONF, GlobalData.labelVO.room_type_conf );
		public static const ROOM_TYPE_P6_CONF:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_P6_CONF, GlobalData.labelVO.room_type_conf );
		public static const ROOM_TYPE_P6_EDU:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_P6_EDU, GlobalData.labelVO.room_type_edu );
		public static const ROOM_TYPE_P7_REMOTE:DataInfoVO = new DataInfoVO( ConstData.ROOM_TYPE_P7_REMOTE, GlobalData.labelVO.room_type_remote );
		
		/**
		 * 구버전 방생성 Default 목록
		 */
		public static var roomTypeList:ArrayList = new ArrayList( [
			ROOM_TYPE_CONF, 
			ROOM_TYPE_EDU,
			ROOM_TYPE_DEBATE,
			ROOM_TYPE_COUNSEL
		] );
		
		/**
		 * 시버전 방생성 Default 목록 버턴 컬러
		 */ 
		public static var roomTypeWebColors:Array = [
			0x5BB9DF, 0x5B9FDE, 0x65CFB8, 0xF8A360, 0x78A23C, 0x9878BB, 0xE8CB57
		];
		
		/**
		 * 신버전 방생성 Default 목록
		 */ 
		public static var roomTypeWebList:ArrayList = new ArrayList( [
			ROOM_TYPE_CONF, 
			ROOM_TYPE_EDU,
			ROOM_TYPE_DEBATE,
			ROOM_TYPE_COUNSEL,
			ROOM_TYPE_BROAD,
			ROOM_TYPE_REMOTE,
			ROOM_TYPE_CHAT
		] );
		
		/**
		 * 모바일 방생성 Default 목록
		 */ 
		public static var roomTypeMobileList:ArrayList = new ArrayList( [
			ROOM_TYPE_CONF, 
			ROOM_TYPE_EDU,
			ROOM_TYPE_DEBATE,
			ROOM_TYPE_COUNSEL,
			ROOM_TYPE_CLOSE
		] );
		
		// 신규 디자인 버전 적용
		public static const LAYOUT_MOVIE_DOC:LayoutVO = new LayoutVO( ConstData.MODE_MOVIE_DOC, GlobalData.labelVO.mode_movie_doc );
		public static const LAYOUT_MOVIE_PT:LayoutVO = new LayoutVO( ConstData.MODE_MOVIE_PT, GlobalData.labelVO.mode_movie_pt );
		public static const LAYOUT_MOVIE:LayoutVO = new LayoutVO( ConstData.MODE_MOVIE, GlobalData.labelVO.mode_movie );
		public static const LAYOUT_VOICE_DOC:LayoutVO = new LayoutVO( ConstData.MODE_VOICE_DOC, GlobalData.labelVO.mode_voice_doc );
		public static const LAYOUT_VOICE_PT:LayoutVO = new LayoutVO( ConstData.MODE_VOICE_PT, GlobalData.labelVO.mode_voice_pt );
		public static const LAYOUT_VOICE:LayoutVO = new LayoutVO( ConstData.MODE_VOICE, GlobalData.labelVO.mode_voice );
		public static const LAYOUT_CHAT_DOC:LayoutVO = new LayoutVO( ConstData.MODE_CHAT_DOC, GlobalData.labelVO.mode_chat_doc );
		public static const LAYOUT_CHAT:LayoutVO = new LayoutVO( ConstData.MODE_CHAT, GlobalData.labelVO.mode_chat );
		public static const LAYOUT_BROAD:LayoutVO = new LayoutVO( ConstData.MODE_BROAD, GlobalData.labelVO.mode_broad );
		public static const LAYOUT_VOICE_REMOTE:LayoutVO = new LayoutVO( ConstData.MODE_VOICE_REMOTE, GlobalData.labelVO.mode_voice );
		public static const LAYOUT_MOVIE_REMOTE:LayoutVO = new LayoutVO( ConstData.MODE_MOVIE_REMOTE, GlobalData.labelVO.mode_movie );
		public static const LAYOUT_CHAT_REMOTE:LayoutVO = new LayoutVO( ConstData.MODE_CHAT_REMOTE, GlobalData.labelVO.mode_chat );
		
		
		// 구버전 적용
		public static const LAYOUT_CONF_DOC:LayoutVO = new LayoutVO( ConstData.MODE_CONF_DOC, GlobalData.labelVO.mode_conf_doc );
		public static const LAYOUT_CONF_LITE_DOC:LayoutVO = new LayoutVO( ConstData.MODE_CONF_LITE_DOC, GlobalData.labelVO.mode_conf_lite_doc );
		public static const LAYOUT_CONF_MOV:LayoutVO = new LayoutVO( ConstData.MODE_CONF_MOV, GlobalData.labelVO.mode_conf_mov );
		public static const LAYOUT_CONF_PT:LayoutVO = new LayoutVO( ConstData.MODE_CONF_PT, GlobalData.labelVO.mode_conf_pt );
		public static const LAYOUT_CONF_BROD:LayoutVO = new LayoutVO( ConstData.MODE_CONF_BROD, GlobalData.labelVO.mode_conf_brod );
		public static const LAYOUT_CONF_EDU:LayoutVO = new LayoutVO( ConstData.MODE_CONF_EDU, GlobalData.labelVO.mode_conf_edu );
		
		public static const LAYOUT_EDU_DOC:LayoutVO = new LayoutVO( ConstData.MODE_EDU_DOC, GlobalData.labelVO.mode_edu_doc );
		public static const LAYOUT_EDU_LITE_DOC:LayoutVO = new LayoutVO( ConstData.MODE_EDU_LITE_DOC, GlobalData.labelVO.mode_edu_lite_doc );
		public static const LAYOUT_EDU_MOV:LayoutVO = new LayoutVO( ConstData.MODE_EDU_MOV, GlobalData.labelVO.mode_edu_mov );
		public static const LAYOUT_EDU_PT:LayoutVO = new LayoutVO( ConstData.MODE_EDU_PT, GlobalData.labelVO.mode_edu_pt );
		public static const LAYOUT_EDU_BROD:LayoutVO = new LayoutVO( ConstData.MODE_EDU_BROD, GlobalData.labelVO.mode_edu_brod );
		
		public static const LAYOUT_DEBATE_MOV:LayoutVO = new LayoutVO( ConstData.MODE_DEBATE_MOV, GlobalData.labelVO.mode_debate_mov );
		public static const LAYOUT_DEBATE_DOC:LayoutVO = new LayoutVO( ConstData.MODE_DEBATE_DOC, GlobalData.labelVO.mode_debate_doc );
		
		public static const LAYOUT_DEBATE_FREE_MOV:LayoutVO = new LayoutVO( ConstData.MODE_DEBATE_FREE_MOV, GlobalData.labelVO.mode_debate_mov );
		public static const LAYOUT_DEBATE_FREE_DOC:LayoutVO = new LayoutVO( ConstData.MODE_DEBATE_FREE_DOC, GlobalData.labelVO.mode_debate_doc );
		
		public static const LAYOUT_COUNSEL_MOV:LayoutVO = new LayoutVO( ConstData.MODE_COUNSEL_MOV, GlobalData.labelVO.mode_counsel_mov );
		public static const LAYOUT_COUNSEL_DOC:LayoutVO = new LayoutVO( ConstData.MODE_COUNSEL_DOC, GlobalData.labelVO.mode_counsel_doc );
		
		public static const LAYOUT_USER:LayoutVO = new LayoutVO( ConstData.MODE_USER, GlobalData.labelVO.mode_user );

		
		
		
		
		public static function setLayoutName():void
		{
			trace( "::::::::: GlobalData.designUI : " + GlobalData.designUI );
			var layoutList:ArrayList = GlobalData.designUI == ConstData.DESIGN_UI_01 ? getLayoutList01() : getLayoutList02();
			trace( "::::::::: layoutList : " + ObjectUtil.toString(layoutList) );
			for each ( var layoutVO:LayoutVO in layoutList.source )
			{
				trace( ":: layoutVO.layoutMode : " + layoutVO.layoutMode );
				layoutVO.layoutName = GlobalData.labelVO[layoutVO.layoutMode];
				trace( ":: setLayoutName : " + layoutVO.layoutName );
			}
		}
		
		/**
		 *  구버전 레이아웃 정보 반환
		 */ 
		public static function getLayoutList01():ArrayList
		{
			var layoutList:ArrayList = null;
			//trace( ":: roomType : " + roomType + "    roomInfoType : " + roomInfoType );
			switch ( roomType )
			{
				case ConstData.ROOM_TYPE_CONF :
					layoutList = layoutConfList;
					break;
				case ConstData.ROOM_TYPE_EDU :
					layoutList = layoutEduList;
					break;
				case ConstData.ROOM_TYPE_DEBATE :
					if ( roomInfoType == ConstData.DEBATE_TYPE_FREE )
						layoutList = layoutDebateFreeList;
					else
						layoutList = layoutDebateList;
					break;
				case ConstData.ROOM_TYPE_COUNSEL :
					layoutList = layoutCounselList;
					break;
				
				// PRODUCT PACKAGE
				case ConstData.ROOM_TYPE_P1_CONF :
					layoutList = layoutP1ConfList;
					break;
				case ConstData.ROOM_TYPE_P1_EDU :
					layoutList = layoutP1EduList;
					break;
				case ConstData.ROOM_TYPE_P2_CONF :
					layoutList = layoutP2ConfList;
					break;
				case ConstData.ROOM_TYPE_P6_CONF :
					layoutList = layoutP6ConfList;
					break;
				case ConstData.ROOM_TYPE_P6_EDU :
					layoutList = layoutP6EduList;
					break;
				case ConstData.ROOM_TYPE_P7_REMOTE :
					
				default :
					layoutList = new ArrayList();
			}
			
			return layoutList;
		}
		
		/**
		 *  신버전 레이아웃 정보 반환
		 */ 
		public static function getLayoutList02():ArrayList
		{
			var layoutModeList:ArrayList = null;
			var layoutList:ArrayList = null;
			trace( ":: roomType : " + roomType + "    roomInfoType : " + roomInfoType );
			switch ( roomType )
			{
				case ConstData.ROOM_TYPE_DEBATE :
					if ( roomInfoType == ConstData.DEBATE_TYPE_FREE )
						layoutList = InterfaceData.layoutDebateFreeList;
					else
						layoutList = InterfaceData.layoutDebateList;
					break;
				case ConstData.ROOM_TYPE_BROAD : 
					layoutList = InterfaceData.layoutBroadList;
					break;
				case ConstData.ROOM_TYPE_REMOTE : 
					layoutList = InterfaceData.layoutRemoteList;
					break;
				case ConstData.ROOM_TYPE_CHAT : 
					layoutList = InterfaceData.layoutChatList;
					break;
				default :
					layoutList = InterfaceData.layoutList;
			}
			
			layoutModeList = getLayoutModeList( layoutList, roomType );
			
			return layoutModeList;
		}
		
		/**
		 *  레이아웃 모드 이름 재조합하여 레이아웃 목록 반환
		 */ 
		public static function getLayoutModeList( layoutList:ArrayList, roomType:String ):ArrayList
		{
			for each ( var layoutVO:LayoutVO in layoutList.source )
			{
				if ( layoutVO.layoutMode == ConstData.MODE_MOVIE_PT || 
					 layoutVO.layoutMode == ConstData.MODE_VOICE_PT ||
					 layoutVO.layoutMode == ConstData.MODE_BROAD ) 
				{
					layoutVO.layoutSetName = layoutVO.layoutName;
					continue;
				}
				
				// layout리스트 문구조합. 예) 영상문서 + 회의 or 영상문서 + 토론
				if(roomType)
					layoutVO.layoutSetName = layoutVO.layoutName + GlobalData.labelVO[roomType];
			}
			
			return layoutList;
		}
		
		public static function getRoomMainType( roomType:String ):String
		{
			var roomMainType:String = roomType;
			switch ( roomType )
			{
				case ConstData.ROOM_TYPE_P1_CONF :
				case ConstData.ROOM_TYPE_P2_CONF :
				case ConstData.ROOM_TYPE_P6_CONF :
					roomMainType = ConstData.ROOM_TYPE_CONF;
					break;
				case ConstData.ROOM_TYPE_P1_EDU :
				case ConstData.ROOM_TYPE_P6_EDU :
					roomMainType = ConstData.ROOM_TYPE_EDU;
					break;
			}
			
			return roomMainType;
		}

		public static var layoutList:ArrayList = new ArrayList( [
			LAYOUT_MOVIE_DOC, 
			LAYOUT_MOVIE_PT, 
			LAYOUT_MOVIE,
			LAYOUT_VOICE_DOC,
			LAYOUT_VOICE_PT,
			LAYOUT_VOICE,
			LAYOUT_CHAT_DOC
		] );
		
		public static var layoutChatList:ArrayList = new ArrayList( [
			LAYOUT_CHAT_DOC,
			LAYOUT_MOVIE_DOC, 
			LAYOUT_MOVIE_PT, 
			LAYOUT_MOVIE,
			LAYOUT_VOICE_DOC,
			LAYOUT_VOICE_PT,
			LAYOUT_VOICE
		] );
		
		public static var layoutBroadList:ArrayList = new ArrayList( [
			LAYOUT_BROAD, 
			LAYOUT_VOICE_PT, 
			LAYOUT_MOVIE_PT
		] );
		
		public static var layoutRemoteList:ArrayList = new ArrayList( [
			LAYOUT_VOICE_REMOTE, 
			LAYOUT_MOVIE_REMOTE, 
			LAYOUT_CHAT_REMOTE
		] );
		
		public static var layoutDebateList:ArrayList = new ArrayList( [
			LAYOUT_DEBATE_MOV, 
			LAYOUT_DEBATE_DOC
		] );
		
		public static var layoutDebateFreeList:ArrayList = new ArrayList( [
			LAYOUT_DEBATE_FREE_MOV, 
			LAYOUT_DEBATE_FREE_DOC
		] );
		
		public static var layoutConfList:ArrayList = new ArrayList( [
			LAYOUT_CONF_DOC, 
			LAYOUT_CONF_LITE_DOC, 
			LAYOUT_CONF_MOV,
			LAYOUT_CONF_PT,
			LAYOUT_CONF_BROD,
			LAYOUT_CONF_EDU
		] );
		
		public static var layoutEduList:ArrayList = new ArrayList( [
			LAYOUT_EDU_DOC, 
			LAYOUT_EDU_LITE_DOC, 
			LAYOUT_EDU_MOV,
			LAYOUT_EDU_PT,
			LAYOUT_EDU_BROD
		] );
		
		public static var layoutCounselList:ArrayList = new ArrayList( [
			LAYOUT_COUNSEL_MOV, 
			LAYOUT_COUNSEL_DOC
		] );
		
		
		
		// PRODUCT PACKAGE MODE
		public static var layoutP1ConfList:ArrayList = new ArrayList( [
			LAYOUT_CONF_LITE_DOC
		] );
		public static var layoutP1EduList:ArrayList = new ArrayList( [
			LAYOUT_EDU_LITE_DOC
		] );
		public static var layoutP2ConfList:ArrayList = new ArrayList( [
			LAYOUT_CONF_DOC, 
			LAYOUT_CONF_MOV,
			LAYOUT_CONF_PT
		] );
		public static var layoutP6ConfList:ArrayList = new ArrayList( [
			LAYOUT_CONF_BROD
		] );
		public static var layoutP6EduList:ArrayList = new ArrayList( [
			LAYOUT_EDU_BROD
		] );
		
		
		
		
		public static const DEBATE_TYPE_FREE:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_FREE, GlobalData.labelVO.debate_type_free );
		public static const DEBATE_TYPE_LD:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_LD, GlobalData.labelVO.debate_type_ld );
		public static const DEBATE_TYPE_COUNCIL:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_COUNCIL, GlobalData.labelVO.debate_type_council );
		public static const DEBATE_TYPE_CEDA:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_CEDA, GlobalData.labelVO.debate_type_ceda );
		public static const DEBATE_TYPE_KARL:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_KARL, GlobalData.labelVO.debate_type_karl );
		
		public static var debateTypeList:ArrayList = new ArrayList( [
			DEBATE_TYPE_FREE, 
			DEBATE_TYPE_LD,
			DEBATE_TYPE_COUNCIL,
			DEBATE_TYPE_CEDA,
			DEBATE_TYPE_KARL
		] );
		
		public static const DEBATE_MODE_MC_IN:DataInfoVO = new DataInfoVO( ConstData.DEBATE_MODE_MC_IN, GlobalData.labelVO.label_mc_in );
		public static const DEBATE_MODE_MC_OUT:DataInfoVO = new DataInfoVO( ConstData.DEBATE_MODE_MC_OUT, GlobalData.labelVO.label_mc_out );
		
		public static var selectModeMCList:ArrayList = new ArrayList( [
			DEBATE_MODE_MC_IN, 
			DEBATE_MODE_MC_OUT
		] );
		
		public static const DEBATE_TYPE_USER_MC:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_USER_MC, GlobalData.labelVO.label_mc );
		public static const DEBATE_TYPE_USER_SECONDER:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_USER_SECONDER, GlobalData.labelVO.label_seconder );
		public static const DEBATE_TYPE_USER_DISSENTER:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_USER_DISSENTER, GlobalData.labelVO.label_dissenter );
		public static const DEBATE_TYPE_USER_VISITOR:DataInfoVO = new DataInfoVO( ConstData.DEBATE_TYPE_USER_VISITOR, GlobalData.labelVO.label_visitor );
		
		public static var debateUserTypeList:ArrayList = new ArrayList( [
			DEBATE_TYPE_USER_MC, 
			DEBATE_TYPE_USER_SECONDER,
			DEBATE_TYPE_USER_DISSENTER,
			DEBATE_TYPE_USER_VISITOR
		] );
		
		public static var selectUserTypeList:ArrayList = new ArrayList( [
			DEBATE_TYPE_USER_MC, 
			DEBATE_TYPE_USER_SECONDER,
			DEBATE_TYPE_USER_DISSENTER
		] );
		
		public static var debateSpeakerList:ArrayList = new ArrayList( [
			DEBATE_TYPE_USER_SECONDER,
			DEBATE_TYPE_USER_DISSENTER
		] );
		
		public static const DEBATE_STATE_ARGUMENT:DataInfoVO = new DataInfoVO( ConstData.DEBATE_STATE_ARGUMENT, GlobalData.labelVO.debate_state_argument );			// 입론
		public static const DEBATE_STATE_QUESTION:DataInfoVO = new DataInfoVO( ConstData.DEBATE_STATE_QUESTION, GlobalData.labelVO.debate_state_question );			// 질의	
		public static const DEBATE_STATE_REVERSE:DataInfoVO = new DataInfoVO( ConstData.DEBATE_STATE_REVERSE, GlobalData.labelVO.debate_state_reverse );			// 반론
		public static const DEBATE_STATE_RESULT:DataInfoVO = new DataInfoVO( ConstData.DEBATE_STATE_RESULT, GlobalData.labelVO.debate_state_result );			// 결론
		
		public static var debateStateList:ArrayList = new ArrayList( [
			DEBATE_STATE_ARGUMENT, 
			DEBATE_STATE_QUESTION,
			DEBATE_STATE_REVERSE,
			DEBATE_STATE_RESULT
		] );
		
		// 테스트용 토론타입 - 링컨,더글러스식
//		public static var debateTypeLDList:ArrayList = new ArrayList( [
//			new DebateItemVO( 1, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_SECONDER, 10, 10 ),
//			new DebateItemVO( 2, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_DISSENTER, 0, 15 ),
//			new DebateItemVO( 3, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_DISSENTER, 0, 12 ),
//			new DebateItemVO( 4, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_SECONDER, 0, 18 ),
//			new DebateItemVO( 5, ConstData.DEBATE_STATE_REVERSE, ConstData.DEBATE_TYPE_USER_SECONDER, 0, 10 ),
//			new DebateItemVO( 6, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_DISSENTER, 0, 16 ),
//			new DebateItemVO( 7, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_SECONDER, 0, 15 ),
//		] );
		
		public static var debateTypeLDList:ArrayList = new ArrayList( [
			new DebateItemVO( 1, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_SECONDER, 6, 0 ),
			new DebateItemVO( 2, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
			new DebateItemVO( 3, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_DISSENTER, 7, 0 ),
			new DebateItemVO( 4, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 5, ConstData.DEBATE_STATE_REVERSE, ConstData.DEBATE_TYPE_USER_SECONDER, 4, 0 ),
			new DebateItemVO( 6, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
			new DebateItemVO( 7, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
		] );
		
		public static var debateTypeCouncilList:ArrayList = new ArrayList( [
			new DebateItemVO( 1, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_SECONDER, 7, 0 ),
			new DebateItemVO( 2, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_DISSENTER, 8, 0 ),
			new DebateItemVO( 3, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_DISSENTER, 8, 0 ),
			new DebateItemVO( 4, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_SECONDER, 8, 0 ),
			new DebateItemVO( 5, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 6, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
		] );
		
		public static var debateTypeCEDAList:ArrayList = new ArrayList( [
			new DebateItemVO( 1, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_SECONDER, 5, 0 ),
			new DebateItemVO( 2, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
			new DebateItemVO( 3, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_DISSENTER, 5, 0 ),
			new DebateItemVO( 4, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 5, ConstData.DEBATE_STATE_REVERSE, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 6, ConstData.DEBATE_STATE_REVERSE, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
			new DebateItemVO( 7, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 8, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
		] );
		
		public static var debateTypeKarlList:ArrayList = new ArrayList( [
			new DebateItemVO( 1, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_SECONDER, 6, 0 ),
			new DebateItemVO( 2, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
			new DebateItemVO( 3, ConstData.DEBATE_STATE_ARGUMENT, ConstData.DEBATE_TYPE_USER_DISSENTER, 6, 0 ),
			new DebateItemVO( 4, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 5, ConstData.DEBATE_STATE_REVERSE, ConstData.DEBATE_TYPE_USER_SECONDER, 5, 0 ),
			new DebateItemVO( 6, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
			new DebateItemVO( 7, ConstData.DEBATE_STATE_REVERSE, ConstData.DEBATE_TYPE_USER_DISSENTER, 5, 0 ),
			new DebateItemVO( 8, ConstData.DEBATE_STATE_QUESTION, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 9, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_SECONDER, 3, 0 ),
			new DebateItemVO( 10, ConstData.DEBATE_STATE_RESULT, ConstData.DEBATE_TYPE_USER_DISSENTER, 3, 0 ),
		] );		
		
		public static function getDebateTypeList( debateType:int ):ArrayList
		{
			var debateTypeList:ArrayList = null;
			//trace( ":: debateType : " + debateType );
			switch ( debateType )
			{
				case ConstData.DEBATE_TYPE_FREE : 
					debateTypeList = new ArrayList();
					break;
				case ConstData.DEBATE_TYPE_LD : 
					debateTypeList = InterfaceData.debateTypeLDList;
					break;
				case ConstData.DEBATE_TYPE_COUNCIL : 
					debateTypeList = InterfaceData.debateTypeCouncilList;
					break;
				case ConstData.DEBATE_TYPE_CEDA : 
					debateTypeList = InterfaceData.debateTypeCEDAList;
					break;
				case ConstData.DEBATE_TYPE_KARL : 
					debateTypeList = InterfaceData.debateTypeKarlList;
					break;
			}
			
			return debateTypeList;
		}
		
		public static function getDebateTypeName( debateType:int ):String
		{
			var debateTypeName:String = "";
			var info:int = -1;
			for each ( var dataInfoVO:DataInfoVO in debateTypeList.source )
			{
				info = dataInfoVO.info as int;
				if ( info == debateType )
				{
					debateTypeName = dataInfoVO.infoName;
					break;
				}
			}
			
			return debateTypeName;
		}
		
		public static function getDebateStateName( debateState:int ):String
		{
			var debateStateName:String = "";
			switch ( debateState )
			{
				case ConstData.DEBATE_STATE_ARGUMENT :
					debateStateName = GlobalData.labelVO.debate_state_argument;
					break;
				case ConstData.DEBATE_STATE_QUESTION :
					debateStateName = GlobalData.labelVO.debate_state_question;
					break;
				case ConstData.DEBATE_STATE_REVERSE :
					debateStateName = GlobalData.labelVO.debate_state_reverse;
					break;
				case ConstData.DEBATE_STATE_RESULT :
					debateStateName = GlobalData.labelVO.debate_state_result;
					break;
			}
			
			return debateStateName;
		}
		
		public static function getDebateUserTypeName( userType:int ):String
		{
			var userTypeName:String = "";
			switch ( userType )
			{
				case ConstData.DEBATE_TYPE_USER_MC :
					userTypeName = GlobalData.labelVO.label_mc;
					break;
				case ConstData.DEBATE_TYPE_USER_SECONDER :
					userTypeName = GlobalData.labelVO.label_seconder;
					break;
				case ConstData.DEBATE_TYPE_USER_DISSENTER :
					userTypeName = GlobalData.labelVO.label_dissenter;
					break;
				case ConstData.DEBATE_TYPE_USER_VISITOR :
					userTypeName = GlobalData.labelVO.label_visitor;
					break;
			}
			
			return userTypeName;
		}
		
		public static function getDebateItemList( itemList:Array ):Array
		{
			var debateItemList:Array = [];
			var debateItemVO:DebateItemVO = null;
			var i:int;
			for each ( var item:Object in itemList )
			{
				item.timeRealMin = GlobalData.roomVO.roomInfoVO.debateItemList[i].timeRealMin;
				item.timeRealSec = GlobalData.roomVO.roomInfoVO.debateItemList[i].timeRealSec;
				
				debateItemVO = new DebateItemVO();
				debateItemVO.setVO( item );
				
				debateItemList.push( debateItemVO );
				i++;
			}
			
			return debateItemList;
		}
		
		public static function getDebateUserName( userType:int ):String
		{
			var userName:String = "";
			//trace( "======= GlobalData.allUserList : " + GlobalData.allUserList.length + "   GlobalData.debateUserList : " + GlobalData.debateUserList);
			for each ( var userVO:UserVO in GlobalData.allUserList.source )
			{
				//trace( "======= userType : " + userType + "   userVO.userType : " + userVO.userType );
				if ( userType == userVO.userType )
				{
					userName = userVO.userName;
					//trace( "======= userName : " + userName );
					break;
				}
			}
			return userName;
		}
		
		public static function hasContainDebateUser( userType:int ):Boolean
		{
			var isContainDebateUser:Boolean = false;
			for each ( var userVO:UserVO in GlobalData.debateUserList.source )
			{
				if ( userType == userVO.userType ) 
				{
					isContainDebateUser = true;
					break;
				}
			}
			return isContainDebateUser;
		}
		
		
		
		
		public static const MENU_MG:MenuVO = new MenuVO( new LabelVO()[ConstData.M_MG], ConstData.M_MG );
		public static const MENU_MAIL:MenuVO = new MenuVO( new LabelVO()[ConstData.M_MAIL], ConstData.M_MAIL );
		public static const MENU_GW:MenuVO = new MenuVO( new LabelVO()[ConstData.M_GW], ConstData.M_GW );
		
		public static const MENU:ArrayList = new ArrayList( [
			MENU_MG, 
			MENU_MAIL,
			MENU_GW
		] );
		
		public static const MENU_MSG_CHAT:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_CHAT], ConstData.MM_CHAT );
		public static const MENU_MSG_MIC:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_MIC], ConstData.MM_MIC );
		public static const MENU_MSG_CAM:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_CAM], ConstData.MM_CAM );
		public static const MENU_MSG_DOC:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_DOC], ConstData.MM_DOC );
		public static const MENU_MSG_TOTAL:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_TOTAL], ConstData.MM_TOTAL );
		public static const MENU_MSG_SHARE_PART:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_SHARE_PART], ConstData.MM_SHARE_PART );
		public static const MENU_MSG_SHARE_FULL:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_SHARE_FULL], ConstData.MM_SHARE_FULL );
		public static const MENU_MSG_REMOTE_FULL:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_REMOTE_FULL], ConstData.MM_REMOTE_FULL );
		public static const MENU_MSG_SETUP:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_SETUP], ConstData.MM_SETUP );
		
		public static const MENU_MSG:Array = [
			MENU_MSG_CHAT, 
			MENU_MSG_MIC,
			MENU_MSG_CAM,
			MENU_MSG_DOC,
			MENU_MSG_TOTAL,
			MENU_MSG_SHARE_PART,
			MENU_MSG_SHARE_FULL,
			MENU_MSG_REMOTE_FULL
		];
		
		public static function getMenuItems( menuList:Array, data:MenuPropVO=null ):ArrayList
		{
			var menuItems:ArrayList = new ArrayList();
			for each ( var menuVO:MenuVO in menuList )
			{
				menuVO.data = data;
				menuItems.addItem( menuVO );
			}
			
			return menuItems;
		}
		
		public static const MENU_CLOSE:MenuVO = new MenuVO( "", ConstData.M_CLOSE );
		
		public static const MENU_CHAT_MIC:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_MIC], ConstData.MC_MIC );
		public static const MENU_CHAT_CAM:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_CAM], ConstData.MC_CAM );
		public static const MENU_CHAT_DOC:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_DOC], ConstData.MC_DOC );
		public static const MENU_CHAT_TOTAL:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_TOTAL], ConstData.MC_TOTAL );
		public static const MENU_CHAT_SHARE_PART:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_SHARE_PART], ConstData.MC_SHARE_PART );
		public static const MENU_CHAT_SHARE_FULL:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_SHARE_FULL], ConstData.MC_SHARE_FULL );
		public static const MENU_CHAT_REMOTE_FULL:MenuVO = new MenuVO( new LabelVO()[ConstData.MM_REMOTE_FULL], ConstData.MC_REMOTE_FULL );
		public static const MENU_CHAT_FILE:MenuVO = new MenuVO( new LabelVO()[ConstData.MC_FILE], ConstData.MC_FILE );
		public static const MENU_CHAT_CAMERA:MenuVO = new MenuVO( new LabelVO()[ConstData.MC_CAMERA], ConstData.MC_CAMERA );
		
		public static const MENU_CHAT:Array = [
			MENU_CHAT_MIC, 
			MENU_CHAT_DOC,
			MENU_CHAT_SHARE_PART,
			MENU_CHAT_REMOTE_FULL,
			MENU_CHAT_CAM,
			MENU_CHAT_TOTAL,
			MENU_CHAT_SHARE_FULL,
			MENU_CLOSE
		];
		
		public static const MENU_CONF_CAM:MenuVO = new MenuVO( new LabelVO()[ConstData.MF_CAM], ConstData.MF_CAM );
		public static const MENU_CONF_CHAT:MenuVO = new MenuVO( new LabelVO()[ConstData.MF_CHAT], ConstData.MF_CHAT );
		public static const MENU_CONF_DOC:MenuVO = new MenuVO( new LabelVO()[ConstData.MF_DOC], ConstData.MF_DOC );
		public static const MENU_CONF_USERS:MenuVO = new MenuVO( new LabelVO()[ConstData.MF_USERS], ConstData.MF_USERS );
		
		public static const MENU_CONF:Array = [
			MENU_CONF_CAM, 
			MENU_CONF_CHAT, 
			MENU_CONF_USERS,
			MENU_CONF_DOC,
			MENU_CLOSE
		];
		
		
		
		
		
		
		public static function getLayoutVO( layoutInfo:Object ):LayoutVO
		{
			var layoutVO:LayoutVO = new LayoutVO();
			layoutVO.setVO( layoutInfo );
			
			return layoutVO;
		}
		
//		public static function showAlertMessage( message:String, closeHandler:Function, alertMode:String="yesNo", closeTime:int=-1 ):void
//		{
//			//trace( "=======> showAlertMessage : " + message );
//			
//			var alertMessage:AlertMessage = new AlertMessage();
//			alertMessage.titleWindowBG = LayoutData.TITLEWINDOW_GRAY_BG;
//			alertMessage.closeHandler = closeHandler;
//			alertMessage.message = message;
//			alertMessage.AlertMode = alertMode;
//
//			TitleWindowManager.openTitleWindow( alertMessage, null, null, InterfaceData.removeAlertMessageHandler );
//			TitleWindowManager.setTitleWindow( null, new Rectangle(0, 0, LayoutData.POPUP_ASK_WIDTH, LayoutData.POPUP_ASK_HEIGHT ), true, true, "", closeTime );
//		}
//
//		public static function removeAlertMessageHandler():void
//		{
//			LayoutManager.getInstance().controlDebateSpeakRequestEnd();
//		}
	}
}

