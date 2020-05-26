/**
 * Popup Util
 */
var popup = {
	
		
		// basic
		/**
		 * 		param = {
		 * 			id 			: '아이디',			// 태그 아이디
		 * 			title		: '팝업상세',			// 제목
		 * 			width		: '300',			// 폭
		 * 			height		: '200',			// 높이
		 * 			body		: html,				// body에 들어갈 html
		 * 			footer		: html,				// footer에 들어갈 html
		 * 		}
		 */
		basic : {
			// 추가 팝업
			add : function (param) {
				
				// 파라미터 변수 초기화
				var tagId 	= (param.id 	? param.id 		: '');
				var title	= (param.title 	? param.title 	: '');
				var width	= (param.width 	? param.width 	: '');
				var body	= (param.body	? param.body		: '');
				var footer	= (param.footer ? param.footer 	: '');
				
				// 팝업 html 생성
				var html  = '<div class="model" id="' + tagId + 'Modal" tabindex="-1" role="dialog" aria-labelledby="' + tagId + 'ModalLabel">';
					html += '	<div class="modal-dialog" style="width:' + width + 'px;">';
					html += '		<div class="modal-content">';
					html += '			<div class="modal-header">';
					html += '				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>';
					html += '				<h4 class="modal-title" id="' + tagId + 'Title">' + title + '</h4>';
					html += '			</div>';
					html += '			<div class="modal-body">';
					html += 				body;
					html += '			</div>';
					html += '			<div class="modal-footer">';
					html += 				footer;
					html += '			</div>';
					html += '		</div>';
					html += '	</div>';
					html += '</div>';
				
				// 팝업 html 초기
				$('#' + tagId).empty();
				// 팝업 추가
				$('#' + tagId).append(html);
			},
			
			// 팝업 비우기
			empty : function (tagId) {
				
				$('#' + tagId).empty();
			}
			
		}
};
