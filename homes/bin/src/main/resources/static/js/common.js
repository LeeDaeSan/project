var common = {
	
	date : {
		toString : function (date, pattern) {
			
			var y = date.getFullYear();
			var m = (date.getMonth() + 1);
				m = m < 10 ? '0' + m : m;
			var d = date.getDate();
				d = d < 10 ? '0' + d : d;
				
			return [y, m, d].join(pattern);
		} 
	},

	string : {
		toEmpty : function (obj) {
			return obj ? obj : '';
		}
	},
	
	number : {
		// n : 수, w : 길이 -> 길이 만큼 수를 채우고 나머지는 0으로 채운다.
		pad : function (n, w) {
			n = n + '';
			return n.length >= w ? n : new Array(w - n.length + 1).join('0') + n;
		},
		
		// 문자열에서 숫자 외의 문자 제외
		onlyNumber : function (n) {
			return n.replace(/[^0-9]/g, '');
		},
		
		addComma : function (n) {
			n = n + '';
			return n == null || n == 'null' || n == 0 ? 0 : n.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}
	},
	
	// 페이징
	paging : function (page, limit, pageLimit, totalCount, callback) {
		
		var firstPage 	= 1;														// 맨 처음 페이지 번호
		var lastPage 	= Math.ceil(totalCount / limit); 							// 맨 마지막 페이지 번호
		var startPage 	= Math.ceil(page / pageLimit) * pageLimit - pageLimit + 1;	// 페이징의 첫 번호
		var endPage 	= Math.ceil(page / pageLimit) * pageLimit;					// 페이징의 마지막 번호
		
		// 페이징의 마지막 페이지 번호가 맨 마지막 페이지 번호보다 클 경우
		if (lastPage < endPage) {
			endPage = lastPage;
		}
		
		// 페이징 초기화
		$('#pagination').empty();
		
			// first page
		var html  = '<li class="paginate_button page-item ' + (firstPage == startPage ? 'disabled' : '') + '"><a href="javascript:void(0);" class="page-link" id="firstPage"><span>≪</span></a></li>';
			// prev page
			html += '<li class="paginate_button page-item ' + (page == firstPage ? 'disabled' : '') + '"><a href="javascript:void(0);" class="page-link" id="prevBtn"><span>＜</span></a></li>';
			// page number
		for (var i = startPage; i <= endPage; i++) {
			console.log(123);
			html += '<li class="paginate_button page-item ' + (i == page ? 'active' : '') + '"><a href="javascript:void(0);" class="page-link page_btn" num="' + i + '">' + i + '</a></li>';
		}
			// next page
			html += '<li class="paginate_button page-item ' + (page == lastPage ? 'disabled' : '') + '"><a href="javascript:void(0);" class="page-link" id="nextBtn"><span>＞</span></a></li>';
			// last page
			html += '<li class="paginate_button page-item ' + (endPage >= lastPage ? 'disabled' : '') + '"><a href="javascript:void(0);" class="page-link" id="lastBtn"><span>≫</span></a></li>';

		// 페이징 append
		$('#pagination').append(html);
		
		// first page 클릭
		$('#firstPage').unbind('click').click(function (e) {
			e.preventDefault();
			// 목록 함수 재호출
			if (!$(this).closest('li').hasClass('disabled')) {
				callback(firstPage);
			}
		});
		
		// start page 클릭
		$('#prevBtn').unbind('click').click(function (e) {
			e.preventDefault();
			// 목록 함수 재호출
			if (!$(this).closest('li').hasClass('disabled')) {
				callback(page - 1);
			}
		});
		
		// 페이징 번호 클릭
		$('.page_btn').unbind('click').click(function (e) {
			e.preventDefault();
			// 목록 함수 재호출
			callback($(this).attr('num'));
		});
		
		// end page 클릭
		$('#nextBtn').unbind('click').click(function (e) {
			e.preventDefault();
			// 목록 함수 재호출
			if (!$(this).closest('li').hasClass('disabled')) {
				callback(Number(page) + 1);
			}
		});
		
		// last page 클릭
		$('#lastBtn').unbind('click').click(function (e) {
			e.preventDefault();
			// 목록 함수 재호출
			if (!$(this).closest('li').hasClass('disabled')) {
				callback(lastPage);
			}
		});
	}
};