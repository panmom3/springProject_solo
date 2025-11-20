
'use strict';

try {
	//제이쿼리가 있으면
	this.jQuery = this.jQuery || undefined;

	//제이쿼리가 있으면
	if(jQuery) {
		//$ 중복방지
		(function($) {
			//태그객체
			var $window = $(window),
				$document = $(document),
				$html = $('html'),
				$head = $('head');
			$(function() {
				var $body = $('body'),
					$wrapper = $('#wrapper'),
					$container = $('#container');
					
				var scrollTop = $window.scrollTop();
				var scrollBottom = scrollTop + $window.height(),
					$rowgroup = $('.rowcont'),
					wrapperOffset = $wrapper.offset();
				if(scrollTop > wrapperOffset.top) {
					$wrapper.attr('data-nontop', 'nontop');
				}else{
					$wrapper.attr('data-nontop', 'top');
				};
				setTimeout(function(){
					$rowgroup.each(function(){
						var $this = $(this),
							ThisOffset = $this.offset(),
							ThisIndex = $this.attr('data-index');
						if(scrollBottom > ThisOffset.top) {
							$this.attr('data-active', 'Y');
							$wrapper.attr('data-row', ThisIndex);
						} else{
							$this.attr('data-active', 'N');
						}
					});
				}, 50);
				$window.on('scroll', function(event) {
					var scrollTop = $window.scrollTop(),
						scrollBottom = scrollTop + $window.height(),
						wrapperOffset = $wrapper.offset(),
						footerOffset = $('#footer').offset();

					if(scrollTop > wrapperOffset.top) {
						$wrapper.attr('data-nontop', 'nontop');
					}else{
						$wrapper.attr('data-nontop', 'top');
					};
					if(scrollBottom > footerOffset.top) {
						$wrapper.addClass('footeractive');
					}else{
						$wrapper.removeClass('footeractive');
					};
					$rowgroup.each(function(){
						var $this = $(this),
							ThisOffset = $this.offset(),
							ThisIndex = $this.attr('data-index');
						if(scrollBottom > ThisOffset.top) {
							$this.attr('data-active', 'Y');
							$wrapper.attr('data-row', ThisIndex);
						} else{
							$this.attr('data-active', 'N');
						}
					});
					// setTimeout(function() {
					// 	$rowgroup.each(function (){
					// 		var $this = $(this),
					// 			ThisOffset = $this.offset();
					// 		if(scrollBottom > ThisOffset.top) {
					// 			$this.attr('data-state', 'on');
					// 		} else{
					// 			$this.attr('data-state', 'off');
					// 		}
					// 	});
					// }, 5000);
				});

				//메인비주얼 슬릭
				var $mainVisual = $('.main_visual'),
					$visualSlideBox = $mainVisual.find('.visual_slide'),
					$visualSlide = $visualSlideBox.find('.slide_list'),
					$visualSlideItem = $visualSlide.find('.slick-slide');

				$visualSlide.slick({
					autoplay : true,
					autoplaySpeed: 4000,
					pauseOnHover: false,
					swipe : false,
					draggable : false,
					slidesToShow: 1,
					slidesToScroll: 1,
					variableWidth: false,
					infinite: true,
					speed: 700,
					fade: true,
					arrows: true,
					dots : false,
					prevArrow : $('.slide_btn .slide_control .prev'),
					nextArrow : $('.slide_btn .slide_control .next'),
					autoArrow : $('.slide_btn .slide_control .auto'),
					isRunOnLowIE : false,
					pauseOnArrowClick : true,
					pauseOnDirectionKeyPush : true,
					pauseOnSwipe : true,
					pauseOnDotsClick : true,
					pauseText : '정지',
					playText : '재생',
					total : $('.slide_btn .count_box .total'),
					current : $('.slide_btn .count_box .current'),
					customState : function(state) {
						//현재 슬라이드 위치가 10보다 작을 때
						if(state.current < 10) {
							state.current = '0' + state.current;
						}
						//슬라이드 갯수가 10보다 작을 때
						if(state.total < 10) {
							state.total = '0' + state.total;
						}
						return state;
					},
					responsive: [
						{
							breakpoint: 1001,
							settings: {
								swipe:true,
								draggable:true,
								slidesToShow : 1,
								slidesToScroll: 1
							}
						}
					]
				});
				$(window).on('scroll', function (){
					$visualSlide.slick('setPosition');
				});
				
				
			});


			$window.on('screen:wide screen:web', function(event) {

			});

			$window.on('screen:tablet screen:phone', function(event) {

			});

		})(jQuery);
	}
}catch(e) {
	console.error(e);
}