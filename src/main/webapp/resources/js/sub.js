(function($) {
	'use strict';

	$(function() {

		var $window = $(window),
			$container = $('#container'),
			$contents = $('#contents'),
			debounce = null;

		$window.load(function(){
			$('.sub_visual').addClass('active');
		});

		// cms 탭메뉴
		var $tab = $container.find('.tab'),
			$tabMenu = $tab.find('.tab_menu'),
			$tabSelect = $tabMenu.find('.tab_select');

		$tabSelect.click(function () {
			var $this = $(this),
				$ParentTabmenu = $this.parent('.tab_menu'),
				IsActive = $ParentTabmenu.is('.active'),
				$tabPanel = $this.siblings('.tab_panel');

			if(!IsActive){
				$ParentTabmenu.addClass('active');
				$this.attr('title','목록닫기');
				$tabPanel.slideDown();
			} else{
				$ParentTabmenu.removeClass('active');
				$this.attr('title','목록열기');
				$tabPanel.slideUp();
			};
		});

		// 컨텐츠 탭메뉴
		$tab.each(function(index, element){
			var $tabMenu = $(element).find('.tab_menu'),
				$tabButton = $(element).find('button.tab_button'),
				tabAllCheck = $tabButton.is('.tab_all'),/*전체보기 탭메뉴 유무*/
				$tabContent = $(element).find('.tab_content');

			var li_length = $tabMenu.find('.tab_item').length;
			$tabMenu.addClass('divide' + li_length);

			$tabButton.click(function () {
				var $this = $(this),
					index = $tabButton.index(this),
					tabButtonText = $this.text(),
					IsTabAll = $this.is('.tab_all'),
					$tab_panel = $this.parents('.tab_panel'),
					$tab_menu = $this.parents('.tab_menu');
				$this.attr('title', '선택됨').closest('.tab_item').addClass('active').siblings('.tab_item').removeClass('active').find('.tab_button').removeAttr('title');
				$this.parents('.tab').find('.tab_select span').text(tabButtonText);

				if (tabAllCheck){
					if (IsTabAll) {
						$tabContent.addClass('active');
					} else {
						$tabContent.eq(index - 1).addClass('active').siblings('.tab_content').removeClass('active');
					}
				} else if (!tabAllCheck){
					$tabContent.eq(index).addClass('active').siblings('.tab_content').removeClass('active');
				}
				if ($window.width() <= 800) {
					$tab_menu.removeClass('active');
					$tab_panel.slideUp();
				}
				if ($window.width() <= 800 && IsTabAll) {
					$tab_menu.removeClass('active');
					$tab_panel.slideUp();
				}

			});
		});

		// colbox 자동 높이
		function colboxAutoHeight() {
			var $collist = $container.find('.col_box');

			$collist.each(function (index, element) {
				if($window.width() > 800){
					var $element = $(element),
						$elementboxItem = $element.find('.col_item'),
						height = 0,
						width = 0,
						count;
					if($element.parents('.col_box')){
						$($elementboxItem, element).each(function (index) {
							var $this = $(this),
								thisWidth = $this.width(),
								thisHeight = $this.height();

							if (thisWidth > width){
								width = thisWidth;
							}
							if (thisHeight > height){
								height = thisHeight;
							}
							count = index + 1;
						}).height(height);
					}
				}
			});
		}
		colboxAutoHeight();
		$window.on('resize', function(){
			colboxAutoHeight();
		});

		// 아이콘박스 자동 높이
		function iconboxAutoHeight() {
			var $iconcollist = $container.find('.icon_col_box');

			$iconcollist.each(function (index, element) {
				if($window.width() > 800){
					var $element = $(element),
						$elementboxItem = $element.find('.icon_col_item'),
						height = 0,
						width = 0,
						count;
					if($element.parents('.icon_col_box')){
						$($elementboxItem, element).each(function (index) {
							var $this = $(this),
								thisWidth = $this.find('.box_cont').width(),
								thisHeight = $this.find('.box_cont').height();

							if (thisWidth > width){
								width = thisWidth;
							}
							if (thisHeight > height){
								height = thisHeight;
							}
							count = index + 1;
						}).height(height);
					}
				}
			});
		}
		iconboxAutoHeight();
		$window.on('resize', function(){
			iconboxAutoHeight();
		});

		// 스텝 자동 높이
		function stepAutoHeight(){
			var $step = $container.find('.step'),
				$stepList = $step.find('.step_list'),
				$stepItem = $stepList.find('.step_item');

			$stepList.each(function (index, element) {
				if($window.width() > 640){
					var $element = $(element),
						$elementStepItem = $element.find('.step_item'),
						$elementItemLevel = $elementStepItem.find('.level'),
						height = 0,
						width = 0,
						count;
					if($element.parents('.step')){
						$($elementStepItem, element).each(function (index){
							var $this = $(this),
								thisWidth = $this.find('.step_content').width(),
								thisHeight = $this.find('.step_content').height();

							if (thisWidth > width){
								width = thisWidth;
							}
							if (thisHeight > height){
								height = thisHeight;
							}

							count = index + 1;
						}).height(height);
					}
					$element.closest('.step').addClass('length' + count);
				}
			});
		}
		stepAutoHeight();
		$window.on('resize', function(){
			stepAutoHeight();
		});

		//테이블 thead tr 두 개 이상 스타일
		$('.table thead tr').each(function(){
			var trIndex = $(this).index() + 1;

			if (trIndex > 1) {
				$(this).closest('.table').addClass('tr_over');
			}
		});

		/* 반응형 테이블 */
		var $tableResponsive = $container.find('.table.responsive');

		$tableResponsive.each(function(index, element) {
			var $element = $(element),
				rowdivIs = $element.find('td, th').is('[rowdiv]'),
				theadLength = $element.find('thead').length;

			if(rowdivIs == false && !theadLength == 0){
				$element.find('tbody th, tbody td').each(function(index, element) {
					var $this = $(element),
						thisIndex = $this.index(),
						theadText = $this.parents('tbody').siblings('thead').find('th').eq(thisIndex).text();

					$this.attr('data-content', theadText);
				});

				$element.find('tfoot th, tfoot td').each(function(index, element) {
					var $this = $(element),
						thisIndex = $this.index(),
						theadText = $this.parents('tfoot').siblings('thead').find('th').eq(thisIndex).text();

					$this.attr('data-content', theadText);
				});
			}
		});

		//셀렉트박스 디자인
		$('.style_select_box .search_select').on('click', function (){
			var $this = $(this),
				$MyParent = $this.parent('.style_select_box'),
				MyParentIsActive = $MyParent.is('.active'),
				$MyLayer = $this.siblings('.search_list');

			if(!MyParentIsActive){
				$MyParent.addClass('active');
				$this.attr('title','목록닫기');
				$MyLayer.slideDown();
			} else {
				$MyParent.removeClass('active');
				$this.attr('title','목록열기');
				$MyLayer.slideUp();
			}
		})

		//인풋 포커스
		var selectTarget = $('.sd_input input[type="text"]');
		selectTarget.on({
			'focus' : function () {
				$(this).parent().addClass('focus');
			},
			'blur' : function () {
				$(this).parent().removeClass('focus');
			}
		});

		//레이어팝업
		$('.popup_btn').click(function (){
			$(this).siblings().addClass('on');
		});
		$('.popup_close').click(function (){
			$('.popup').removeClass('on');
			$('.popup_btn').focus();
		});

		//img mobile - 모바일에서 확대 아이콘 추가
		var $imgMobile = $('.img_mobile');
		$(window).on('load resize', function(){
			$imgMobile.each(function(){
				var $this = $(this),
					$img = $this.find('img'),
					imgRight = $img.outerWidth() + $img.offset().left;
				$this.find('.zoom').remove();
				if($(window).width() < 1000){
					var $elem = $('<a href="'+ $img.attr('src')  +'" class="zoom" target="_blank" title="이미지확대보기 새창"></a>');
					$this.append($img).append($elem);
					var $zoom = $this.find('.zoom');
					$zoom.css('left',imgRight - $this.offset().left - $zoom.width());
				}
			})
		});
		//FAQ
		$('.temp_accordion .accordion_item button.accordion_btn').on('click', function() {
			var $this = $(this),
				$MyParent = $this.parent('.accordion_item'),
				IsActive = $MyParent.is('.active'),
				$MyLayer = $this.siblings('.accordion_con');
			if(!IsActive){
				$MyParent.addClass('active');
				$MyLayer.slideDown();
				$this.attr('title', '내용닫기');
			} else{
				$MyParent.removeClass('active');
				$MyLayer.slideUp();
				$this.attr('title', '내용열기');
			}
		});

	});
})(window.jQuery);
